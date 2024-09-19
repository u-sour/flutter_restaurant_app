import 'package:flutter/material.dart';
import '../../../screens/app_screen.dart';
import '../../models/sale/invoice/sale_invoice_model.dart';

class DashboardProvider extends ChangeNotifier {
  late String _branchId;
  late String _depId;
  SaleInvoiceModel _saleInvoice =
      const SaleInvoiceModel(data: [], totalRecords: 0);
  SaleInvoiceModel get saleInvoice => _saleInvoice;
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isFiltering = false;
  bool get isFiltering => _isFiltering;
  late String _filterText;
  String get filterText => _filterText;
  final int _pageSize = 10;
  int get pageSize => _pageSize;

  void initData({required String branchId, required String depId}) async {
    _isLoading = true;
    notifyListeners();
    _branchId = branchId;
    _depId = depId;
    _saleInvoice = await fetchSaleForDataTable(
        tab: _selectedTab, branchId: _branchId, depId: _depId);
    _isLoading = false;
    _filterText = '';
    notifyListeners();
  }

  Future<void> search({int tab = 0, String filterText = ''}) async {
    await filter(tab: tab, filterText: filterText);
  }

  Future<void> pageNavigationChange({
    required int page,
  }) async {
    await filter(tab: _selectedTab, filterText: _filterText, page: page += 1);
  }

  Future<void> filter(
      {int tab = 0, String filterText = '', int? page, int? pageSize}) async {
    _isFiltering = true;
    notifyListeners();
    _selectedTab = tab;
    _filterText = filterText;
    _saleInvoice = await fetchSaleForDataTable(
        tab: _selectedTab,
        filter: filterText,
        page: page,
        pageSize: pageSize,
        branchId: _branchId,
        depId: _depId);
    _isFiltering = false;
    notifyListeners();
  }

  Future<SaleInvoiceModel> fetchSaleForDataTable({
    int tab = 0,
    String filter = '',
    int? page,
    int? pageSize,
    required String branchId,
    required String depId,
  }) async {
    Map<String, dynamic> params = {
      'filters': {'value': filter}, // search value
      'depId': depId
    };

    if (tab == 0) {
      params['billed'] = 1;
    } else if (tab == 1) {
      params['status'] = 'Open';
    } else if (tab == 2) {
      params['status'] = 'Partial';
    } else if (tab == 3) {
      params['status'] = 'Closed';
    } else if (tab == 4) {
      params['status'] = 'Cancel';
    }
    Map<String, dynamic> tableQuery = {};

    if (tab == 2 || tab == 3 || tab == 4) {
      // If fetch for table with paginate (tab = 2,3,4)
      tableQuery = {
        'page': page ?? 1,
        'pageSize': pageSize ?? _pageSize,
      };
    }
    if (tab == 0 || tab == 1) {
      // If fetch for card (tab = 0,1)
      tableQuery = {
        'page': page ?? 1,
        'pageSize': page ?? 1 << 32,
      };
    }

    Map<String, dynamic> result =
        await meteor.call('rest.findSaleForTableData', args: [
      {'params': params, 'tableQuery': tableQuery, 'branchId': branchId}
    ]);
    return SaleInvoiceModel.fromJson(result);
  }

  Future<Map<String, dynamic>> fetchOneTable({required String branchId}) async {
    Map<String, dynamic> selector = {'branchId': branchId};
    Map<String, dynamic> result = await meteor.call('rest.findOneTable', args: [
      {'selector': selector}
    ]);
    return result;
  }
}
