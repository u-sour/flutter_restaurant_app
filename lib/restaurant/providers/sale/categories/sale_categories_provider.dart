import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_provider.dart';
import '../../../../widgets/screens/app_screen.dart';
import '../../../models/sale/category/sale_category_model.dart';

class SaleCategoriesProvider extends ChangeNotifier {
  late List<SaleCategoryModel> _categories;
  late List<SaleCategoryModel> _selectedCategories;

  //getter
  List<SaleCategoryModel> get categories => _categories;
  List<SaleCategoryModel> get selectedCategories => _selectedCategories;

  Future<void> setSelectedCategory(
      {required SaleCategoryModel category,
      required String branchId,
      required String depId}) async {
    _categories = await fetchSaleCategories(
        branchId: branchId,
        depId: depId,
        parentId: category.id == '' ? null : category.id,
        level: category.id == '' ? 0 : null);
    _selectedCategories.add(SaleCategoryModel(
      id: category.id,
      name: category.name,
      level: category.level,
    ));
    notifyListeners();
  }

  void clearSelectedCategory({required int index}) {
    _selectedCategories.removeRange(index, _selectedCategories.length);
    notifyListeners();
  }

  Future<void> initData({required BuildContext context}) async {
    AppProvider readAppProvider = context.read<AppProvider>();
    _categories = [];
    _selectedCategories = [
      const SaleCategoryModel(id: '', name: 'All', level: 0)
    ];
    String branchId = readAppProvider.selectedBranch!.id;
    String depId = readAppProvider.selectedDepartment!.id;
    _categories =
        await fetchSaleCategories(branchId: branchId, depId: depId, level: 0);
    notifyListeners();
  }

  Future<List<SaleCategoryModel>> fetchSaleCategories(
      {required String branchId,
      required String depId,
      int? level,
      String? parentId}) async {
    Map<String, dynamic> selector = {
      'branchId': branchId,
      'productType': {
        '\$in': ['Product', 'Dish', 'Catalog', 'Service']
      },
      '\$or': [
        {'status': 'Active'},
        {
          'status': {'\$exists': false}
        }
      ],
    };

    if (level != null) {
      selector['level'] = level;
    }

    if (parentId != null) {
      selector['parentId'] = parentId;
    }

    final List<dynamic> result =
        await meteor.call('rest.findCategoriesForSale', args: [
      {'selector': selector, 'depId': depId}
    ]);
    List<SaleCategoryModel> toModelList =
        result.map((json) => SaleCategoryModel.fromJson(json)).toList();
    return toModelList;
  }
}
