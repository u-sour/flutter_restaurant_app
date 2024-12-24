import 'dart:async';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/services/sale_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../models/servers/response_model.dart';
import '../../../providers/app_provider.dart';
import '../../../router/route_utils.dart';
import '../../../screens/app_screen.dart';
import '../../../utils/alert/awesome_snack_bar_utils.dart';
import '../../models/sale-table/floor_model.dart';
import '../../models/sale-table/table_model.dart';
import '../../models/sale/sale/sale_model.dart';
import '../../services/user_service.dart';
import '../../utils/debounce.dart';

class SaleTableProvider with ChangeNotifier {
  late SubscriptionHandler _saleSubscription;
  SubscriptionHandler get saleSubscription => _saleSubscription;
  late StreamSubscription<Map<String, dynamic>> _saleListener;
  late String _activeFloor;
  String get activeFloor => _activeFloor;
  late List<FloorModel> _floors;
  List<FloorModel> get floors => _floors;
  late List<TableModel> _tables;
  List<TableModel> get tables => _tables;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isFiltering = false;
  bool get isFiltering => _isFiltering;

  Future<void> setActiveFloor(
      {required String floorId,
      required String branchId,
      required String depId,
      required bool? displayTableAllDepartment}) async {
    _isFiltering = true;
    _activeFloor = floorId;
    _tables = [];
    notifyListeners();
    _tables = await fetchTables(
        floorId: _activeFloor,
        branchId: branchId,
        depId: depId,
        displayTableAllDepartment: displayTableAllDepartment);
    _isFiltering = false;
    notifyListeners();
  }

  void subscribeSales({required BuildContext context}) {
    final debounce = Debounce(delay: const Duration(milliseconds: 500));
    _activeFloor = 'All';
    _floors = [];
    _tables = [];
    String branchId =
        context.select<AppProvider, String>((ap) => ap.selectedBranch!.id);
    String depId =
        context.select<AppProvider, String>((ap) => ap.selectedDepartment!.id);
    bool? displayTableAllDepartment = context.select<AppProvider, bool?>(
        (ap) => ap.saleSetting.sale.displayTableAllDepartment);
    Map<String, dynamic> selector = {'branchId': branchId, 'status': 'Open'};
    if (displayTableAllDepartment != null && !displayTableAllDepartment) {
      selector['depId'] = depId;
    }
    _saleSubscription = meteor.subscribe(
      'sales',
      args: [selector],
      onReady: () {
        _isLoading = true;
        notifyListeners();
        _saleListener = meteor.collection('rest_sales').listen((event) {
          //  call method only 1 time when sale data updated
          debounce.run(() {
            initData(
                branchId: branchId,
                depId: depId,
                displayTableAllDepartment: displayTableAllDepartment);
          });
        });
      },
    );
  }

  Future<void> initData(
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
    _isLoading = false;
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
    final List<dynamic> result =
        await meteor.call('rest.findSales', args: [selector]);

    List<SaleModel> toModelList =
        result.map((json) => SaleModel.fromJson(json)).toList();

    return toModelList;
  }

  Future<List<FloorModel>> fetchFloors(
      {required String branchId,
      required String depId,
      required bool? displayTableAllDepartment}) async {
    Map<String, dynamic> selector = {'branchId': branchId, 'depId': depId};
    if (displayTableAllDepartment != null) {
      selector['displayTableAllDepartment'] = displayTableAllDepartment;
    }
    final List<dynamic> result =
        await meteor.call('rest.findFloorContainActiveTable', args: [selector]);
    List<FloorModel> toModelList = [
      const FloorModel(
          id: 'All',
          branchId: '',
          depId: '',
          name: 'screens.saleTable.tab.all',
          status: ''),
      ...result.map((json) => FloorModel.fromJson(json))
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
      // filter sales By Table
      final salesByTable =
          sales.where((sale) => sale.tableId == tempTable.id).toList();
      // table current invoice count
      tempTable.setCurrentInvoiceCount = salesByTable.length;
      // table current guest count
      // tempTable.setCurrentInvoiceCount = salesByTable.fold(0, (sum, sale) => sum + sale.numOfGuest);
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

  Future<ResponseModel?> enterSale(
      {required TableModel table, required BuildContext context}) async {
    // Note: user អាចចូល `form លក់` ពេល:
    // data គ្រប់គ្រាន់ ដូចជា `exchange rate, product, department`
    // បើ user role == `insert-invoice`
    // user role == `cashier` || `tablet-orders` អាចចូលបានបើ `table status == 'busy' || 'close'` នៅក្នុងតុនឹង
    ResponseModel? result;
    final bool isDataEnoughToEnterSale =
        await SaleService.isDataEnoughToEnterSale(context: context);
    bool allowEnterSale =
        UserService.userInRole(roles: ['cashier', 'tablet-orders']) &&
                table.status == 'closed' ||
            table.status == 'busy';

    if (isDataEnoughToEnterSale) {
      if (UserService.userInRole(roles: ['insert-invoice']) || allowEnterSale) {
        if (context.mounted) {
          context.goNamed(SCREENS.sale.toName,
              queryParameters: {'table': table.id, 'fastSale': 'false'});
        }
      } else {
        result = const ResponseModel(
            message: 'permissionDenied', type: AWESOMESNACKBARTYPE.info);
      }
    } else {
      result = const ResponseModel(
          message: 'screens.sale.detail.alert.dataNotEnoughToEnterSale',
          type: AWESOMESNACKBARTYPE.info);
    }
    return result;
  }

  void unSubscribe() {
    if (_saleSubscription.subId.isNotEmpty) {
      _saleSubscription.stop();
      _saleListener.cancel();
    }
  }
}
