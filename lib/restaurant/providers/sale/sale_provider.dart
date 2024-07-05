import 'package:flutter/material.dart';
import '../../models/sale/detail/sale_detail_model.dart';

class SaleProvider extends ChangeNotifier {
  List<SaleDetailModel> _rows = [];
  List<SaleDetailModel> get rows => _rows;
  List<SaleDetailModel> _selectedRows = [];
  List<SaleDetailModel> get selectedRows => _selectedRows;

  void initData() {
    _rows = List.generate(
        20,
        (int index) => SaleDetailModel(
            itemName: "Item $index",
            price: 200000,
            discountRate: 10,
            qty: 1000,
            returnQty: 1000,
            total: 2000000)).toList();
  }

  void selectAllRows(bool isSelectedAllRows) {
    _selectedRows = isSelectedAllRows ? _rows : [];
    notifyListeners();
  }

  void selectRow(bool isSelectedRow, SaleDetailModel row) {
    isSelectedRow ? _selectedRows.add(row) : _selectedRows.remove(row);
    notifyListeners();
  }
}
