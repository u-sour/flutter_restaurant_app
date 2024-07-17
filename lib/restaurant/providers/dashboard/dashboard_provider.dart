import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/material.dart';
import '../../../screens/app_screen.dart';
import '../../models/sale/invoice/sale_invoice_model.dart';

class DashboardProvider extends ChangeNotifier {
  SaleInvoiceModel _saleInvoice =
      const SaleInvoiceModel(data: [], totalRecords: 0);
  SaleInvoiceModel get saleInvoice => _saleInvoice;
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  void getSaleForDataTable({
    int tab = 0,
    String filter = '',
    required String branchId,
    required String depId,
  }) {
    _selectedTab = tab;
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
        'page': 1,
        'pageSize': 10,
      };
    }
    if (tab == 0 || tab == 1) {
      // If fetch for card (tab = 0,1)
      tableQuery = {
        'page': 1,
        'pageSize': 1 << 32,
      };
    }

    meteor.call('rest.findSaleForTableData', args: [
      {'params': params, 'tableQuery': tableQuery, 'branchId': branchId}
    ]).then((result) {
      if (result != null) {
        _saleInvoice =
            SaleInvoiceModel.fromJson(result as Map<String, dynamic>);
        notifyListeners();
      }
    }).catchError((err) {
      if (err is MeteorError) {
        print(err.message);
      }
    });
    notifyListeners();
  }
}
