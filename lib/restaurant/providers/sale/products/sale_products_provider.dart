import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_provider.dart';
import '../../../../screens/app_screen.dart';
import '../../../../storages/connection_storage.dart';
import '../../../models/sale/product-group/sale_product_group_model.dart';
import '../../../models/sale/product/sale_product_model.dart';
import '../../../models/sale/product/sale_product_result_model.dart';

class SaleProductsProvider extends ChangeNotifier {
  late TextEditingController _searchController;
  TextEditingController get searchController => _searchController;
  late String _branchId;
  late String _depId;
  late String _ipAddress;
  String get ipAddress => _ipAddress;
  List<SaleProductGroupModel> _productGroup = [];
  List<SaleProductGroupModel> get productGroup => _productGroup;
  Stream<List<SaleProductModel>>? _productsStream;
  Stream<List<SaleProductModel>>? get productsStream => _productsStream;
  List<SaleProductModel> _products = [];
  List<SaleProductModel> get products => [..._products];
  late StreamController<List<SaleProductModel>> _productsStreamController;
  late int _productCount;
  String _search = '';
  String _productGroupId = '';
  String get productGroupId => _productGroupId;
  bool _showExtraFood = false;
  bool get showExtraFood => _showExtraFood;
  int _skip = 0;
  int get skip => _skip;
  int _limit = 25;
  int get limit => _limit;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isLoadMore = false;
  bool get isLoadMore => _isLoadMore;

  Future<void> initData(
      {required BuildContext context,
      required int skip,
      required int limit}) async {
    _isLoading = true;
    _searchController = TextEditingController();
    AppProvider readAppProvider = context.read<AppProvider>();
    _branchId = readAppProvider.selectedBranch!.id;
    _depId = readAppProvider.selectedDepartment!.id;

    _productsStreamController =
        StreamController<List<SaleProductModel>>.broadcast();
    _productsStream = _productsStreamController.stream;
    SaleProductResultModel saleProductsResult = await fetchSaleProducts(
        branchId: _branchId, depId: _depId, skip: skip, limit: limit);
    _productCount = saleProductsResult.itemCount;

    // check not allow duplicate products when add to _products
    // for (int i = 0; i < saleProductsResult.items.length; i++) {
    //   SaleProductModel newProduct = saleProductsResult.items[i];
    //   if (_products.where((p) => p.id == newProduct.id).isEmpty) {
    //     _products.add(newProduct);
    //   }
    // }
    _products = saleProductsResult.items;
    _productsStreamController.add(_products);
    _ipAddress = (await ConnectionStorage().getIpAddress())!;
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
    _productsStreamController.add(_products);
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
      _productsStreamController.add(_products);
      _isLoadMore = false;
      notifyListeners();
    }
  }

  void clearSearchTextFieldAndState() {
    _search = '';
    if (_searchController.text.isNotEmpty) {
      _searchController.clear();
    }
    notifyListeners();
  }

  void clearState() {
    _productGroup = [];
    _products = [];
    _productsStreamController.close();
    _searchController.dispose();
    _productGroupId = '';
    _showExtraFood = false;
    _search = '';
    _skip = 0;
    _limit = 25;
  }
}
