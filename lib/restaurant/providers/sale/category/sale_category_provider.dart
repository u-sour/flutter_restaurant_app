import 'package:flutter/material.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../models/sale/category/sale_category_model.dart';

class SaleCategoryProvider extends ChangeNotifier {
  final List<SaleCategoryModel> _categories = const [
    SaleCategoryModel(
        parent: SelectOptionModel(
            label: "Vegetable", value: 'vegetable', extra: "root"),
        children: [
          SaleCategoryModel(
              parent: SelectOptionModel(label: "Salad", value: "salad"),
              children: [
                SaleCategoryModel(
                    parent:
                        SelectOptionModel(label: "Salad A+", value: "salad-a+"),
                    children: [
                      SaleCategoryModel(
                          parent: SelectOptionModel(
                              label: "Salad A++", value: "Salad A++"))
                    ]),
                SaleCategoryModel(
                  parent:
                      SelectOptionModel(label: "Salad B+", value: "salad-b+"),
                )
              ]),
        ]),
    SaleCategoryModel(
        parent: SelectOptionModel(label: "Meat", value: "meat", extra: "root")),
    SaleCategoryModel(
        parent:
            SelectOptionModel(label: "Drink", value: "drink", extra: "root")),
  ];

  //getter
  List<SaleCategoryModel> get categories => _categories;

  void setSelected() {
    for (var i = 0; i < _categories.length; i++) {}
    notifyListeners();
  }
}
