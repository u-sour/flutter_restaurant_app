import 'dart:async';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../../screens/app_screen.dart';
import '../../models/sale-table/floor_model.dart';
import '../../models/sale-table/table_model.dart';
import '../../models/sale/sale/sale_model.dart';
import '../../utils/debounce.dart';

class SaleTableProvider with ChangeNotifier {
  late SubscriptionHandler _saleSubscription;
  SubscriptionHandler get saleSubscription => _saleSubscription;
  StreamSubscription<Map<String, dynamic>>? _saleListener;
  String _activeFloor = 'All';
  String get activeFloor => _activeFloor;
  List<FloorModel> _floors = [];
  List<FloorModel> get floors => _floors;
  List<TableModel> _tables = [];
  List<TableModel> get tables => _tables;

  Future<void> setActiveFloor(
      {required String floorId,
      required String branchId,
      required String depId,
      required bool? displayTableAllDepartment}) async {
    _activeFloor = floorId;
    _tables = await fetchTables(
        floorId: floorId,
        branchId: branchId,
        depId: depId,
        displayTableAllDepartment: displayTableAllDepartment);
    notifyListeners();
  }

  void subscribeSales({required BuildContext context}) {
    final debounce = Debounce(delay: const Duration(milliseconds: 800));
    AppProvider watchAppProvider = context.watch<AppProvider>();
    String branchId = watchAppProvider.selectedBranch!.id;
    String depId = watchAppProvider.selectedDepartment!.id;
    bool? displayTableAllDepartment =
        watchAppProvider.saleSetting.sale.displayTableAllDepartment;
    Map<String, dynamic> selector = {'branchId': branchId, 'status': 'Open'};
    if (displayTableAllDepartment != null && !displayTableAllDepartment) {
      selector['depId'] = depId;
    }
    _saleSubscription = meteor.subscribe(
      'sales',
      args: [selector],
      onReady: () {
        _saleListener = meteor.collection('rest_sales').listen((event) {
          if (event.isNotEmpty) {
            //  call method only 1 time when sale data updated
            debounce.run(() {
              initData(
                  branchId: branchId,
                  depId: depId,
                  displayTableAllDepartment: displayTableAllDepartment);
            });
          }
        });
      },
    );
  }

  void initData(
      {required String branchId,
      required String depId,
      required bool? displayTableAllDepartment}) async {
    _floors = await fetchFloors(
        branchId: branchId,
        depId: depId,
        displayTableAllDepartment: displayTableAllDepartment);
    _tables = await fetchTables(
        floorId: _activeFloor,
        branchId: branchId,
        depId: depId,
        displayTableAllDepartment: displayTableAllDepartment);
    notifyListeners();
  }

  Future fetchSales(
      {required String branchId,
      required String depId,
      required bool? displayTableAllDepartment}) async {
    Map<String, dynamic> selector = {'branchId': branchId, 'status': 'Open'};
    if (displayTableAllDepartment != null && !displayTableAllDepartment) {
      selector['depId'] = depId;
    }
    final List<dynamic> result = await meteor.call('rest.findSales', args: [
      {'selector': selector}
    ]);

    List<SaleModel> toModelList =
        result.map((json) => SaleModel.fromJson(json)).toList();

    return toModelList;
  }

  Future<List<FloorModel>> fetchFloors(
      {required String branchId,
      required String depId,
      required bool? displayTableAllDepartment}) async {
    Map<String, dynamic> selector = {'status': 'Active', 'branchId': branchId};
    if (displayTableAllDepartment != null && !displayTableAllDepartment) {
      selector['depId'] = depId;
    } else {
      selector['\$and'] = [
        {
          'depId': {'\$exists': true}
        },
        {
          'depId': {'\$ne': null}
        }
      ];
    }
    final List<dynamic> result = await meteor.call('rest.findFloors', args: [
      {'selector': selector}
    ]);
    List<FloorModel> toModelList = [
      const FloorModel(
          id: 'All',
          branchId: '',
          depId: '',
          name: 'screens.saleTable.tab.all',
          status: ''),
      ...result.map((json) => FloorModel.fromJson(json)).toList()
    ];
    return toModelList;
  }

  Future<List<TableModel>> fetchTables(
      {required String floorId,
      required String branchId,
      required String depId,
      required bool? displayTableAllDepartment}) async {
    Map<String, dynamic> selector = {
      'floorId': floorId,
      'branchId': branchId,
      'depId': depId,
      'displayTableAllDepartment': displayTableAllDepartment
    };
    List<SaleModel> sales = await fetchSales(
        branchId: branchId,
        depId: depId,
        displayTableAllDepartment: displayTableAllDepartment);

    final List<dynamic> result =
        await meteor.call('rest.findTableForSaleTable', args: [selector]);

    List<TableModel> tempTables =
        result.map((json) => TableModel.fromJson(json)).toList();

    // filter sale and get currentGuestCount and status for table
    for (int i = 0; i < tempTables.length; i++) {
      final TableModel tempTable = tempTables[i];
      // table currentGuestCount
      final salesByTable =
          sales.where((sale) => sale.tableId == tempTable.id).toList();
      tempTable.setCurrentGuestCount =
          salesByTable.fold(0, (sum, sale) => sum + sale.numOfGuest);
      // table status
      if (sales.any((sale) =>
          sale.tableId == tempTable.id &&
          sale.requestPayment != null &&
          sale.requestPayment == true)) {
        tempTable.setStatus = 'closed';
      } else if (sales
          .where((sale) => sale.tableId == tempTable.id && sale.billed > 0)
          .isNotEmpty) {
        tempTable.setStatus = 'isPrintBill';
      } else if (sales.any((sale) => sale.tableId == tempTable.id)) {
        tempTable.setStatus = 'busy';
      } else {
        tempTable.setStatus = 'open';
      }
    }
    List<TableModel> toModelList = tempTables;
    return toModelList;
  }

  void unSubscribe() {
    if (_saleSubscription.subId.isNotEmpty) {
      _saleSubscription.stop();
    }
    _saleListener?.cancel();
  }
}
