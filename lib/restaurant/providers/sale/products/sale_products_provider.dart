import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_provider.dart';
import '../../../../screens/app_screen.dart';
import '../../../../storages/connection_storage.dart';
import '../../../models/sale/product-group/sale_product_group_model.dart';
import '../../../models/sale/product/sale_product_model.dart';
import '../../../models/sale/product/sale_product_result_model.dart';

class SaleProductsProvider extends ChangeNotifier {
  late GlobalKey<FormBuilderState> fbSearchKey;
  late String _branchId;
  late String _depId;
  late String _ipAddress;
  String get ipAddress => _ipAddress;
  late List<SaleProductGroupModel> _productGroup;
  List<SaleProductGroupModel> get productGroup => _productGroup;
  late List<SaleProductModel> _products;
  List<SaleProductModel> get products => [..._products];
  late int _productCount;
  String _search = '';
  String get search => _search;
  late String _productGroupId;
  String get productGroupId => _productGroupId;
  bool _showExtraFood = false;
  bool get showExtraFood => _showExtraFood;
  late int _skip;
  int get skip => _skip;
  late int _limit;
  int get limit => _limit;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isLoadMore = false;
  bool get isLoadMore => _isLoadMore;
  // current index of product item when user scrolling
  late int _currentProductIndex;
  int get currentProductIndex => _currentProductIndex;

  Future<void> initData(
      {required BuildContext context, int skip = 0, int limit = 25}) async {
    _isLoading = true;
    AppProvider readAppProvider = context.read<AppProvider>();
    _branchId = readAppProvider.selectedBranch!.id;
    _depId = readAppProvider.selectedDepartment!.id;
    _products = [];
    _productGroup = [];
    SaleProductResultModel saleProductsResult = await fetchSaleProducts(
        branchId: _branchId, depId: _depId, skip: skip, limit: limit);
    _products = saleProductsResult.items;
    _productCount = saleProductsResult.itemCount;
    _ipAddress = (await ConnectionStorage().getIpAddress())!;
    _productGroupId = '';
    _skip = skip;
    _limit = limit;
    _currentProductIndex = 0;
    _isLoading = false;
    notifyListeners();
  }

  Future<SaleProductResultModel> fetchSaleProducts(
      {String search = '',
      String activeCategory = '',
      String activeGroup = '',
      bool showExtraFood = false,
      String? invoiceId,
      required String branchId,
      required String depId,
      required int limit,
      required int skip}) async {
    // Set params
    Map<String, dynamic> params = {'status': 'Active'};

    // Set Options
    Map<String, dynamic> options = {
      'sort': {'name': 1},
      'limit': limit,
      'skip': skip
    };

    // Filter type
    if (showExtraFood) {
      params['type'] = {
        '\$in': ['ExtraFood']
      };
      params['isExtraFood'] = true;
    } else {
      params['type'] = {
        '\$in': ['Product', 'Dish', 'Catalog', 'Service']
      };
    }

    // Filter category
    if (activeCategory.isNotEmpty) {
      params['categoryId'] = activeCategory;
    }

    //  Filter group
    if (activeGroup.isNotEmpty) params['groupId'] = activeGroup;

    //  Filter search
    String searchFormat = RegExp.escape(search);
    if (searchFormat.isNotEmpty) {
      params['search'] = [
        {
          'code': {'\$regex': searchFormat, '\$options': '\$i'}
        },
        {
          'name': {'\$regex': searchFormat, '\$options': '\$i'}
        },
        {
          'barcode': {'\$regex': searchFormat, '\$options': '\$i'}
        },
      ];
    }

    Map<String, dynamic> result =
        await meteor.call('rest.findProductForSale', args: [
      {
        'params': params,
        'options': options,
        'invoiceId': invoiceId,
        'branchId': branchId,
        'depId': depId
      }
    ]);

    return SaleProductResultModel.fromJson(result);
  }

  Future<List<SaleProductGroupModel>> fetchSaleProductGroup(
      {required String branchId,
      required String depId,
      String? categoryId,
      bool? isExtraFood}) async {
    final List<dynamic> result =
        await meteor.call('rest.findGroupForSale', args: [
      {
        'branchId': branchId,
        'depId': depId,
        'categoryId': categoryId == '' ? 'all' : categoryId,
        'isExtraFood': isExtraFood
      }
    ]);
    List<SaleProductGroupModel> toModelList =
        result.map((json) => SaleProductGroupModel.fromJson(json)).toList();
    return toModelList;
  }

  Future<void> productGroupFilter(
      {String? categoryId, bool? isExtraFood}) async {
    _productGroup = [];
    _productGroup = await fetchSaleProductGroup(
        branchId: _branchId,
        depId: _depId,
        categoryId: categoryId,
        isExtraFood: isExtraFood);
    notifyListeners();
  }

  Future<void> filter(
      {String search = '',
      String categoryId = '',
      String productGroupId = '',
      bool showExtraFood = false}) async {
    _limit = 25;
    _skip = 0;
    _products = [];
    _search = search;
    _productGroupId = productGroupId;
    _showExtraFood = showExtraFood;
    SaleProductResultModel saleProductsResult = await fetchSaleProducts(
        search: _search,
        activeCategory: categoryId,
        activeGroup: _productGroupId,
        showExtraFood: _showExtraFood,
        branchId: _branchId,
        depId: _depId,
        skip: _skip,
        limit: _limit);
    _products = saleProductsResult.items;
    notifyListeners();
  }

  Future<void> loadMore({int loadMore = 25, String categoryId = ''}) async {
    // check allow user load more products if products still exist
    if (_limit < _productCount) {
      _isLoadMore = true;
      notifyListeners();
      _skip += loadMore;
      _limit += loadMore;
      SaleProductResultModel saleProductsResult = await fetchSaleProducts(
          search: _search,
          activeCategory: categoryId,
          activeGroup: _productGroupId,
          showExtraFood: _showExtraFood,
          branchId: _branchId,
          depId: _depId,
          skip: _skip,
          limit: _limit);
      _productCount = saleProductsResult.itemCount;
      _products.addAll(saleProductsResult.items);
      _isLoadMore = false;
      notifyListeners();
    }
  }

  void setCurrentProductIndex({required int index}) {
    _currentProductIndex = index;
    notifyListeners();
  }

  void clearSearchTextFieldAndState() {
    _search = '';
    if (fbSearchKey.currentState!.saveAndValidate()) {
      final String search = fbSearchKey.currentState?.value['search'] ?? '';
      if (search.isNotEmpty) {
        fbSearchKey.currentState!.reset();
      }
    }
    notifyListeners();
  }
}
