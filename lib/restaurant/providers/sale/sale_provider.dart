import 'dart:async';
import 'dart:convert';
import 'package:big_dart/big_dart.dart';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../models/servers/response_model.dart';
import '../../../providers/app_provider.dart';
import '../../../router/route_utils.dart';
import '../../../storages/connection_storage.dart';
import '../../../screens/app_screen.dart';
import '../../../services/global_service.dart';
import '../../../utils/alert/awesome_snack_bar_utils.dart';
import '../../../utils/convert_date_time.dart';
import '../../../widgets/confirm_dialog_widget.dart';
import '../../models/exchange/exchange_model.dart';
import '../../models/sale/add-product/sale_add_product_model.dart';
import '../../models/sale/app-bar/sale_app_bar_action_model.dart';
import '../../models/sale/detail/sale_detail_extra_item_model.dart';
import '../../models/sale/detail/sale_detail_model.dart';
import '../../models/sale/guest/guest_model.dart';
import '../../models/sale/guest/insert_guest_model.dart';
import '../../models/sale/insert-item-input/insert_item_input_model.dart';
import '../../models/sale/invoice/sale_invoice_action_model.dart';
import '../../models/sale/invoice/sale_invoice_status_date_model.dart';
import '../../models/sale/receipt/sale_receipt_allow_currency_amount_model.dart';
import '../../models/sale/receipt/sale_receipt_model.dart';
import '../../models/sale/sale/sale_model.dart';
import '../../models/sale/table-location/table_location_model.dart';
import '../../services/sale_service.dart';
import '../../services/user_service.dart';
import '../../utils/constants.dart';
import '../../utils/debounce.dart';
import '../../utils/round_number.dart';
import '../../utils/sale/sale_utils.dart';
import '../../widgets/sale/detail/confirm-dialog-content/cancel_sale_cdc_widget.dart';
import '../../widgets/sale/detail/edit_sale_detail_footer_action_widget.dart';
import '../../widgets/sale/detail/edit_sale_detail_operation_action_widget.dart';

class SaleProvider extends ChangeNotifier {
  late String _ipAddress;
  String get ipAddress => _ipAddress;
  late SubscriptionHandler _saleSubscription;
  SubscriptionHandler get saleSubscription => _saleSubscription;
  late StreamSubscription<Map<String, dynamic>> _saleListener;
  late String _baseCurrency;
  String get baseCurrency => _baseCurrency;
  late int _decimalNumber;
  int get decimalNumber => _decimalNumber;
  late RoundNumber _roundNumber;
  late String _branchId;
  late String _depId;
  late String _employeeId;
  late SelectOptionModel _currentGuest;
  SelectOptionModel get currentGuest => _currentGuest;
  late String _tableId;
  late bool _fastSale;
  late bool _isTabletOrder;
  late bool _isDecimalQty;
  bool? _isSkipTable;
  bool? get isSkipTable => _isSkipTable;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // sales
  late String _activeSaleInvoiceId;
  String get activeSaleInvoiceId => _activeSaleInvoiceId;
  late List<SaleModel> _sales;
  List<SaleModel> get sales => _sales;
  SaleModel? _currentSale;
  SaleModel? get currentSale => _currentSale;

  // sale details
  final String _prefixSaleDetailAlert = 'screens.sale.detail.alert';
  late List<SaleDetailModel> _previousSaleDetails;
  List<SaleDetailModel> get previousSaleDetails => _previousSaleDetails;
  late List<SaleDetailModel> _saleDetails;
  List<SaleDetailModel> get saleDetails => _saleDetails;
  bool _isSelectedAllRows = false;
  bool get isSelectedAllRows => _isSelectedAllRows;
  late List<SaleDetailModel> _selectedSaleDetails;
  List<SaleDetailModel> get selectedSaleDetails => _selectedSaleDetails;
  late List<SaleDetailModel> _selectedSaleDetailsForOperation;
  List<SaleDetailModel> get selectedSaleDetailsForOperation =>
      [..._selectedSaleDetailsForOperation];
  late List<SaleDetailModel> _printableItems;
  late TableLocationModel _tableLocation;
  TableLocationModel get tableLocation => _tableLocation;

  // sale action title (table floor & name, sale id & sale date)
  SaleAppBarActionModel? _saleActionAppBarTitle;
  SaleAppBarActionModel? get saleActionAppBarTitle => _saleActionAppBarTitle;
  late String _tableLocationText;
  late String _invoiceText;

  // last item added
  SaleAddProductModel? _lastItemAdded;
  SaleAddProductModel? get lastItemAdded => _lastItemAdded;

  Future<void> initData(
      {String? invoiceId,
      required String table,
      required bool fastSale,
      required BuildContext context}) async {
    AppProvider readAppProvider = context.read<AppProvider>();
    _activeSaleInvoiceId = '';
    _tableLocationText = '';
    _invoiceText = '';
    _sales = [];
    _currentSale = null;
    _previousSaleDetails = [];
    _saleDetails = [];
    _selectedSaleDetails = [];
    _selectedSaleDetailsForOperation = [];
    _lastItemAdded = null;
    _printableItems = [];
    _baseCurrency = readAppProvider.companyAccounting.baseCurrency;
    _decimalNumber = readAppProvider.companyAccounting.decimalNumber;
    _roundNumber = RoundNumber(
        decimalNumber:
            _baseCurrency == 'KHR' ? -_decimalNumber : _decimalNumber);
    _branchId = readAppProvider.selectedBranch!.id;
    _depId = readAppProvider.selectedDepartment!.id;
    _employeeId = readAppProvider.currentUser!.id;
    _currentGuest = const SelectOptionModel(label: '', value: null);
    _ipAddress = (await ConnectionStorage().getIpAddress())!;
    GuestModel generalGuest = await fetchOneGeneralGuest();
    // set current guest
    setCurrentGuest(
        guest: SelectOptionModel(
            label: generalGuest.name, value: generalGuest.id));
    if (context.mounted) {
      // check current user enable 'tablet-orders' role & module
      _isTabletOrder = SaleService.isModuleActive(
              modules: ['tablet-orders'], overpower: false, context: context) &&
          UserService.userInRole(roles: ['tablet-orders'], overpower: false);

      // check current user enable 'decimal-qty' module
      _isDecimalQty = SaleService.isModuleActive(
          modules: ['decimal-qty'], overpower: false, context: context);

      // check current user enable 'skip-table' module
      _isSkipTable = SaleService.isModuleActive(
          modules: ['skip-table'], overpower: false, context: context);
      // get table Id & fastSale from query router
      _tableId = table;
      _fastSale = fastSale;
      // get invoice Id and set _activeSaleInvoiceId from query router is route come from dashboard
      if (invoiceId != null) {
        _activeSaleInvoiceId = invoiceId;
      }
      // check insert a new sale if fast sale
      if (_fastSale) {
        addNewSale();
      }

      // get & set table location
      _tableLocation = await fetchTableLocation(tableId: _tableId);
    }

    // subscribe sales
    if (context.mounted) {
      // Note: used on Sale Action AppBar Title
      _tableLocationText =
          getTableLocationText(tableLocation: _tableLocation, context: context);
      subscribeSales(invoiceId: invoiceId, context: context);
    }
    notifyListeners();
  }

  void subscribeSales({String? invoiceId, required BuildContext context}) {
    final debounce = Debounce(delay: const Duration(milliseconds: 800));
    Map<String, dynamic> selector = {
      'branchId': _branchId,
      'tableId': _tableId,
      'depId': _depId,
      'status': 'Open',
    };

    // If tablet order module is active
    if (_isTabletOrder) {
      selector['requestPayment'] = {'\$ne': true};
    }

    _saleSubscription = meteor.subscribe(
      'sales',
      args: [
        selector,
        {
          'sort': {'refNo': 1}
        }
      ],
      onReady: () {
        _isLoading = true;
        notifyListeners();
        _saleListener = meteor.collection('rest_sales').listen((event) {
          //  call method only 1 time when sale data updated
          debounce.run(() async {
            _sales = await fetchSales(
                branchId: _branchId,
                tableId: _tableId,
                depId: _depId,
                isTabletOrder: _isTabletOrder);
            if (_sales.isNotEmpty) {
              // get current sale with sale detail
              // if _activeSaleInvoiceId empty set the first sale to _currentSale by id
              // else set _currentSale by _activeSaleInvoiceId
              if (context.mounted) {
                await getCurrentSaleWithSaleDetail(
                    invoiceId: invoiceId == null
                        ? _sales.first.id
                        : _activeSaleInvoiceId,
                    context: context);
              }
            } else {
              _activeSaleInvoiceId = '';
              _sales = [];
              _currentSale = null;
              _saleDetails = [];
              // set sale action app bar title
              _saleActionAppBarTitle =
                  SaleAppBarActionModel(title: _tableLocationText);
            }
            _isLoading = false;
            notifyListeners();
          });
        });
      },
    );
  }

  String getTableLocationText(
      {required TableLocationModel tableLocation,
      required BuildContext context}) {
    String result = '${_tableLocation.floor} (${_tableLocation.table})';
    if (SaleService.isModuleActive(modules: ['skip-table'], context: context)) {
      result = '';
    }
    return result;
  }

  String getInvoiceText(
      {required SaleModel sale, required BuildContext context}) {
    String result = sale.refNo;
    if (SaleService.isModuleActive(
        modules: ['order-number'], overpower: false, context: context)) {
      result += '-${sale.orderNum}';
    }
    return result;
  }

  // add new guest
  Future<ResponseModel?> addGuest({required Map<String, dynamic> form}) async {
    ResponseModel? result;
    try {
      form['branchId'] = _branchId;
      await insertGuestMethod(doc: InsertGuestModel.fromJson(form));
      result = const ResponseModel(
          message: 'screens.guest.alert.success.message',
          type: AWESOMESNACKBARTYPE.success);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  // add new sale
  Future<ResponseModel?> addNewSale({SaleAddProductModel? item}) async {
    ResponseModel? result;
    _isLoading = true;
    notifyListeners();
    final SaleInvoiceActionModel doc = SaleInvoiceActionModel(
        date: DateTime.now(),
        type: 'Invoice',
        status: 'Open',
        statusDate: SaleInvoiceStatusDateModel(open: DateTime.now()),
        discountRate: 0,
        discountValue: 0,
        total: 0,
        totalReceived: 0,
        tableId: _tableId,
        depId: _depId,
        employeeId: _employeeId,
        guestId: _currentGuest.value,
        numOfGuest: 0,
        billed: 0,
        branchId: _branchId);
    try {
      // insert sale
      final String invoiceId = await insertSaleMethod(doc: doc);
      if (invoiceId.isEmpty) {
        throw Exception('Invoice is not found');
      }
      // add item
      if (item != null && invoiceId.isNotEmpty) {
        handleItemAdd(item: item, invoiceId: invoiceId);
      }
      // set active invoice
      _activeSaleInvoiceId = invoiceId;
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        _isLoading = false;
      }
    }
    notifyListeners();
    return result;
  }

  Future<void> getCurrentSaleWithSaleDetail(
      {required String invoiceId, required BuildContext context}) async {
    // clear selected details
    _selectedSaleDetails = [];

    // set sale active invoice id
    _activeSaleInvoiceId = invoiceId;

    // find current sale by active sale invoice id
    List<SaleModel> currentSale =
        _sales.where((s) => s.id == _activeSaleInvoiceId).toList();

    if (currentSale.isNotEmpty) {
      // set current sale
      _currentSale = currentSale.first;
      // Note: used on Sale Action AppBar Title
      // set invoice text
      _invoiceText = getInvoiceText(sale: _currentSale!, context: context);

      // set current guest
      GuestModel guest = await fetchOneGuest(id: _currentSale!.guestId);
      setCurrentGuest(
          guest: SelectOptionModel(label: guest.name, value: guest.id));

      // set sale action app bar title
      if (_currentSale != null) {
        _saleActionAppBarTitle = SaleAppBarActionModel(
          title: _tableLocationText.isNotEmpty
              ? "$_tableLocationText : $_invoiceText"
              : _invoiceText,
          date:
              ConvertDateTime.formatTimeStampToString(_currentSale!.date, true),
        );
      }

      // set current sale detail by _activeSaleInvoiceId
      _previousSaleDetails = await fetchSaleDetails();
      _saleDetails = await fetchSaleDetails();
    }
    notifyListeners();
  }

  // Note: sale detail item (product) amount just for show
  num getItemAmount({required SaleDetailModel item}) {
    num amount = item.amount;
    if (item.extraItemDoc.isNotEmpty) {
      for (var i = 0; i < item.extraItemDoc.length; i++) {
        amount += item.extraItemDoc[i].amount;
      }
    }
    return amount;
  }

  double formatQty({required num qty}) {
    int dp = 0;
    if (_isDecimalQty) dp = 2;
    return _roundNumber.round(value: qty, decimalNumber: dp);
  }

  // handle item click
  // Note: check sales && current sale isn't existed then create a new sale
  // sales && current sale is existed add item
  Future<ResponseModel?> handleItemClick(
      {required SaleAddProductModel item}) async {
    ResponseModel? result;

    // if there no current sale, add new sale then add item
    if (_sales.isEmpty && _activeSaleInvoiceId.isEmpty) {
      result = await addNewSale(item: item);
    }

    // check current sale is existed then add item
    if (_sales.isNotEmpty && currentSale != null) {
      result = await handleItemAdd(item: item, invoiceId: currentSale!.id);
    }
    return result;
  }

  void setLastItemAdded({required SaleAddProductModel item}) {
    _lastItemAdded = item;
    notifyListeners();
  }

  // handle add item (product) 3 types = catalog == 'Set', extra food & normal
  Future<ResponseModel?> handleItemAdd(
      {required SaleAddProductModel item, required String invoiceId}) async {
    ResponseModel? result;
    if (item.catalogType != null && item.catalogType == 'Set') {
      // Make doc
      List<Map<String, dynamic>> products =
          item.products?.map((p) => p.toJson()).toList() ?? [];
      Map<String, dynamic> doc = {
        'invoiceId': invoiceId,
        'status': 'New',
        'product': products,
        'branchId': _branchId
      };

      // Merge main item to products
      if (item.addOwnItem != null) {
        // Main item
        List<Map<String, dynamic>> mainItem = [
          {
            'productId': item.id,
            'qty': 1,
            'cost': item.price,
            'amount': item.price,
          },
        ];

        // Merge items
        doc['products'] = [...mainItem, ...products];
      } else {
        doc['products'] = products;
      }

      // Check if order mode active
      if (_isTabletOrder) {
        doc['products']
            .forEach((Map<String, dynamic> p) => {p['draft'] = true});
      }

      // Add item list
      result = await addItemList(doc: InsertItemInputModel.fromJson(doc));
    } else if (item.type == 'ExtraFood' && _selectedSaleDetails.isNotEmpty) {
      // Filter by checkPrintKitchen == null or checkPrintKitchen == false
      List<SaleDetailModel> selectedSaleDetailFilter = _selectedSaleDetails
          .where((sd) =>
              sd.checkPrintKitchen == null || sd.checkPrintKitchen == false)
          .toList();

      Map<String, dynamic> doc = {
        'itemId': item.id,
        'itemName': item.name,
        'qty': 1,
        'price': item.price,
        'discount': item.discount,
        'amount': 0,
        'status': 'New',
        'invoiceId': invoiceId,
        'checkPrint': false,
        'branchId': _branchId
      };

      // Check if order mode active
      if (_isTabletOrder) {
        doc['draft'] = true;
      }

      // Add extra item
      result = await addExtraItem(
          doc: InsertItemInputModel.fromJson(doc),
          selectedSaleDetailFilter: selectedSaleDetailFilter);
      // clear all selected items
      selectAllRows(false);
    } else {
      Map<String, dynamic> doc = {
        'itemId': item.id,
        'qty': 1,
        'price': item.price,
        'discount': item.discount,
        'amount': 0,
        'status': 'New',
        'invoiceId': invoiceId,
        'checkPrint': false,
        'branchId': _branchId
      };

      // Check if order mode active
      if (_isTabletOrder) {
        doc['draft'] = true;
      }

      // Add normal item or item type catalog == "Combo"
      result = await addItem(doc: InsertItemInputModel.fromJson(doc));
    }
    setLastItemAdded(item: item);
    return result;
  }

  // add item list (product as catalogType == 'Set')
  Future<ResponseModel?> addItemList(
      {required InsertItemInputModel doc}) async {
    ResponseModel? result;
    try {
      await insertSaleDetailListMethod(doc: doc);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        _isLoading = false;
      }
    }
    return result;
  }

  // insert sale detail extra food (product as extra food)
  Future<ResponseModel?> addExtraItem(
      {required InsertItemInputModel doc,
      required List<SaleDetailModel> selectedSaleDetailFilter}) async {
    ResponseModel? result;
    try {
      await insertSaleDetailExtraMethod(
          doc: doc, itemList: selectedSaleDetailFilter);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        _isLoading = false;
      }
    }
    return result;
  }

  // Add item
  Future<ResponseModel?> addItem({
    required InsertItemInputModel doc,
  }) async {
    ResponseModel? result;
    try {
      // insert sale detail item
      await insertSaleDetailMethod(doc: doc);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        _isLoading = false;
      }
    }
    return result;
  }

  // Handle update sale detail item
  void handleItemUpdate({
    // required int index,
    required String onChangedValue,
    required SaleDetailModel item,
    required SaleDetailDTRowType rowType,
  }) {
    num amountBeforeDiscount = 0;
    num discountAmount = 0;
    num amountAfterDiscount = 0;
    // Note: invisible change use for condition to change the values (amountBeforeDiscount, discountAmount, amountAfterDiscount) that unable to be seen
    bool invisibleChange = false;

    if (rowType.name == 'price') {
      num price = num.tryParse(onChangedValue) ?? 0;
      // set a new price
      item.price =
          _roundNumber.round(value: price, decimalNumber: _decimalNumber);
      // set trigger
      invisibleChange = true;
    }

    if (rowType.name == 'discountRate') {
      num discountRate = num.tryParse(onChangedValue) ?? 0;
      // set a new discount rate
      item.discount = discountRate > 100 ? 100 : discountRate;
      // check extraItemDoc is exist
      if (item.extraItemDoc.isNotEmpty) {
        for (int i = 0; i < item.extraItemDoc.length; i++) {
          SaleDetailExtraItemModel extraItem = item.extraItemDoc[i];
          // set a new extra item discount
          extraItem.discount = item.discount;
          // set a new discount amount
          discountAmount = calculateDiscountAmount(
              amountBeforeDiscount: extraItem.price,
              discountRate: extraItem.discount);
          // set a new amount after discount
          amountAfterDiscount = calculateAmountAfterDiscount(
              amountBeforeDiscount: extraItem.price,
              discountAmount: discountAmount);
          // set a new extra item amount
          extraItem.amount = _roundNumber.round(
              value: Big(extraItem.qty).times(amountAfterDiscount));
        }
      }
      // set trigger
      invisibleChange = true;
    }

    if (rowType.name == 'note') {
      // set a new note
      item.note = onChangedValue;
    }

    if (rowType.name == 'qty') {
      num qty = num.tryParse(onChangedValue) ?? 0;
      // set a new total qty
      item.totalQty = qty;
      // set a new qty and totalQty by condition
      handleQtyAndTotalQty(item: item);
      // Check extra item is exist
      if (item.extraItemDoc.isNotEmpty) {
        // Set new extra item amount
        for (int i = 0; i < item.extraItemDoc.length; i++) {
          SaleDetailExtraItemModel extraItem = item.extraItemDoc[i];
          // set a new discount amount
          discountAmount = calculateDiscountAmount(
              amountBeforeDiscount: extraItem.price,
              discountRate: extraItem.discount);
          // set a new amount after discount
          amountAfterDiscount = calculateAmountAfterDiscount(
              amountBeforeDiscount: extraItem.price,
              discountAmount: discountAmount);
          // set a new extra item amount
          extraItem.amount = _roundNumber.round(
              value: Big(item.qty).times(amountAfterDiscount));
        }
      }
      // set trigger
      invisibleChange = true;
    }

    if (rowType.name == 'returnQty') {
      num returnQty = num.tryParse(onChangedValue) ?? 0;
      // set a new return qty
      item.returnQty = returnQty;
      // set a new qty and totalQty by condition
      handleQtyAndTotalQty(item: item);
      // set a new discount amount
      discountAmount = calculateDiscountAmount(
          amountBeforeDiscount: item.price, discountRate: item.discount);
      // set a new amount after discount
      amountAfterDiscount = calculateAmountAfterDiscount(
          amountBeforeDiscount: item.price, discountAmount: discountAmount);
      // set a new amount
      item.amount =
          _roundNumber.round(value: Big(item.qty).times(amountAfterDiscount));
    }

    if (invisibleChange) {
      // set a new amount before discount
      amountBeforeDiscount =
          calculateAmountBeforeDiscount(qty: item.qty, price: item.price);
      // set a new discount amount
      discountAmount = calculateDiscountAmount(
          amountBeforeDiscount: amountBeforeDiscount,
          discountRate: item.discount);
      // set a new amount after discount
      amountAfterDiscount = calculateAmountAfterDiscount(
          amountBeforeDiscount: amountBeforeDiscount,
          discountAmount: discountAmount);
      // set a new amount
      item.amount = _roundNumber.round(value: amountAfterDiscount);
    }
    notifyListeners();
  }

  // Handle update sale detail item from operation (transfer or split)
  void handleItemUpdateFromOperation({
    required String onChangedValue,
    required SaleDetailModel item,
    required int index,
    required SaleDetailDTRowType rowType,
  }) {
    Map<String, dynamic> itemAsJson = item.toJson();
    num amountBeforeDiscount = 0;
    num discountAmount = 0;
    num amountAfterDiscount = 0;
    // Note: invisible change use for condition to change the values (amountBeforeDiscount, discountAmount, amountAfterDiscount) that unable to be seen
    bool invisibleChange = false;

    if (rowType.name == 'qty') {
      num qty = num.tryParse(onChangedValue) ?? 0;
      // set a new total qty
      itemAsJson['totalQty'] = qty;
      // set a new qty and totalQty by condition
      handleQtyAndTotalQtyForOperation(item: itemAsJson);
      // set trigger
      invisibleChange = true;
      // Check extra item is exist
      if (itemAsJson['extraItemDoc'].isNotEmpty) {
        // Set new extra item amount
        for (int i = 0; i < itemAsJson['extraItemDoc'].length; i++) {
          Map<String, dynamic> extraItem = itemAsJson['extraItemDoc'][i];
          // set a new discount amount
          discountAmount = calculateDiscountAmount(
              amountBeforeDiscount: extraItem['price'],
              discountRate: extraItem['discount']);
          // set a new amount after discount
          amountAfterDiscount = calculateAmountAfterDiscount(
              amountBeforeDiscount: extraItem['price'],
              discountAmount: discountAmount);
          // set a new extra item amount
          extraItem['amount'] = _roundNumber.round(
              value: Big(itemAsJson['qty']).times(amountAfterDiscount));
        }
      }
    }

    if (invisibleChange) {
      // set a new amount before discount
      amountBeforeDiscount = calculateAmountBeforeDiscount(
          qty: itemAsJson['qty'], price: itemAsJson['price']);
      // set a new discount amount
      discountAmount = calculateDiscountAmount(
          amountBeforeDiscount: amountBeforeDiscount,
          discountRate: itemAsJson['discount']);
      // set a new amount after discount
      amountAfterDiscount = calculateAmountAfterDiscount(
          amountBeforeDiscount: amountBeforeDiscount,
          discountAmount: discountAmount);
      // set a new amount
      itemAsJson['amount'] = _roundNumber.round(value: amountAfterDiscount);
    }
    // convert from model to json list
    List<Map<String, dynamic>> toMapList = _selectedSaleDetailsForOperation
        .map((model) => model.toJson())
        .toList();
    // update item by index
    toMapList[index] = itemAsJson;
    // convert json to model list then set _selectedSaleDetailsForOperation
    _selectedSaleDetailsForOperation =
        toMapList.map((json) => SaleDetailModel.fromJson(json)).toList();
    notifyListeners();
  }

  // set selected sale details for operation (transfer or split)
  void setSelectedSaleDetailsForOperation(
      {required List<SaleDetailModel> selectedSaleDetails}) {
    _selectedSaleDetailsForOperation = selectedSaleDetails;
    notifyListeners();
  }

  // remove selected sale detail for operation (transfer or split)
  void removeSelectedSaleDetailsForOperation({required String id}) {
    _selectedSaleDetailsForOperation.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // Note: this function's used for qty and return qty to set a new qty and totalQty by condition
  void handleQtyAndTotalQty({required SaleDetailModel item}) {
    // format qty to decimal if current user enable 'decimal-qty' module
    num qty = formatQty(qty: item.totalQty - item.returnQty);
    if (qty <= 0) {
      item.totalQty = item.returnQty;
      qty = 0;
    }
    // set a new qty
    item.qty = qty;
  }

  void handleQtyAndTotalQtyForOperation({required Map<String, dynamic> item}) {
    num qty = item['totalQty'] - item['returnQty'];
    if (qty <= 0) {
      item['totalQty'] = item['returnQty'];
      qty = 0;
    }
    // set a new qty
    item['qty'] = qty;
  }

  // calculate amount before discount
  num calculateAmountBeforeDiscount({required num qty, required num price}) {
    return Big(qty).times(price).toNumber();
  }

  // calculate discount amount
  num calculateDiscountAmount(
      {required num amountBeforeDiscount, required num discountRate}) {
    return Big(amountBeforeDiscount).times(discountRate).div(100).toNumber();
  }

  // calculate amount after discount
  num calculateAmountAfterDiscount(
      {required num amountBeforeDiscount, required num discountAmount}) {
    return Big(amountBeforeDiscount).sub(discountAmount).toNumber();
  }

  // Sale details footer
  num calculateSubTotal({required List<SaleDetailModel> saleDetails}) {
    num subTotal = 0;
    for (int i = 0; i < saleDetails.length; i++) {
      SaleDetailModel item = saleDetails[i];
      subTotal =
          _roundNumber.round(value: subTotal += item.amount, decimalNumber: 2);
      // if extra item is exist
      if (item.extraItemDoc.isNotEmpty) {
        for (int i = 0; i < item.extraItemDoc.length; i++) {
          SaleDetailExtraItemModel extraItem = item.extraItemDoc[i];
          subTotal = _roundNumber.round(
              value: subTotal += extraItem.amount, decimalNumber: 2);
        }
      }
    }
    // check base currency == "KHR" round up
    return formatMoney(amount: subTotal, baseCurrency: _baseCurrency);
  }

  Map<String, dynamic> calculateDiscount(
      {required SaleModel? currentSale, required num subTotal}) {
    Map<String, dynamic> discount = {"rate": 0, "value": 0};
    if (currentSale != null) {
      if (currentSale.discountRate > 0) {
        discount['rate'] = currentSale.discountRate;
        discount['value'] =
            Big(discount['rate']).times(subTotal).div(100).toNumber();
      } else if (currentSale.discountValue > 0) {
        discount['rate'] = 0;
        discount['value'] = currentSale.discountValue;
      }
    }
    return discount;
  }

  num calculateTotal({required num subTotal, required num discountValue}) {
    num total = 0;
    total = Big(subTotal).sub(discountValue).toNumber();
    // check base currency == "KHR" round up
    return formatMoney(amount: total, baseCurrency: _baseCurrency);
  }

  // Remove item
  Future<ResponseModel?> removeItem(
      {required String id, bool decreaseCount = false}) async {
    ResponseModel? result;
    try {
      await removeSaleDetailMethod(id: id, decreaseCount: decreaseCount);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        _isLoading = false;
      }
    }
    return result;
  }

  // Enter sale
  void handleEnterSale(
      {required BuildContext context,
      String? tableId,
      required String invoiceId,
      bool fastSale = false}) {
    Map<String, dynamic> query = {
      'table': tableId ?? _tableId,
      'id': invoiceId,
      'fastSale': '$fastSale'
    };
    context.replaceNamed(SCREENS.sale.toName, queryParameters: query);
  }

  void selectAllRows(bool isSelectedAllRows) {
    _isSelectedAllRows = isSelectedAllRows;
    // Filter by checkPrint == false
    List<SaleDetailModel> saleDetailFilter =
        _saleDetails.where((sd) => !sd.checkPrint).toList();
    _selectedSaleDetails = _isSelectedAllRows ? saleDetailFilter : [];
    // set printable items
    setPrintableItems();
    notifyListeners();
  }

  void selectRow(bool isSelectedRow, SaleDetailModel row) {
    isSelectedRow
        ? _selectedSaleDetails.add(row)
        : _selectedSaleDetails.remove(row);
    // set printable items
    setPrintableItems();
    notifyListeners();
  }

  // filter selected sale detail item.qty > 0
  // Note : Used for print to kitchen
  void setPrintableItems() {
    _printableItems = [];
    _printableItems = _selectedSaleDetails.where((sd) => sd.qty > 0).toList();
  }

  // fetch One Guest
  Future<GuestModel> fetchOneGuest({required String id}) async {
    Map<String, dynamic> selector = {'_id': id, 'branchId': _branchId};
    Map<String, dynamic> result = await meteor.call('rest.findOneGuest', args: [
      {'selector': selector}
    ]);
    return GuestModel.fromJson(result);
  }

  // fetch One Guest (name : General)
  Future<GuestModel> fetchOneGeneralGuest() async {
    Map<String, dynamic> selector = {'branchId': _branchId, 'name': 'General'};
    Map<String, dynamic> result = await meteor.call('rest.findOneGuest', args: [
      {'selector': selector}
    ]);
    return GuestModel.fromJson(result);
  }

  // fetch Table Location
  Future<TableLocationModel> fetchTableLocation(
      {required String tableId}) async {
    Map<String, dynamic> selector = {'branchId': _branchId, '_id': tableId};
    Map<String, dynamic> result =
        await meteor.call('rest.findSaleTableLocation', args: [
      {'selector': selector}
    ]);
    return TableLocationModel.fromJson(result);
  }

  // fetch tables
  // Note: Used for Change Table
  Future<List<SelectOptionModel>> fetchTables() async {
    Map<String, dynamic> selector = {'branchId': _branchId, 'depId': _depId};
    List<dynamic> result =
        await meteor.call('rest.findTableByDepartment', args: [selector]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(
          SelectOptionModel(
              label: result[i]['floorName'],
              value: result[i]['_id'],
              extra: 'floor'),
        );
        for (int j = 0; j < result[i]['tables'].length; j++) {
          toListModel.add(SelectOptionModel(
              label: result[i]['tables'][j]['name'],
              value: result[i]['tables'][j]['_id'],
              extra: 'table'));
        }
      }
    }

    return toListModel;
  }

  // fetch Guests
  // Note : Used for Change Guest and Edit Sale Receipt
  Future<List<SelectOptionModel>> fetchGuests({String? branchId}) async {
    Map<String, dynamic> selector = {'branchId': branchId ?? _branchId};
    Map<String, dynamic> options = {
      'sort': {'name': -1}
    };
    List<dynamic> result = await meteor.call('rest.findGuests', args: [
      {'selector': selector, 'options': options}
    ]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(SelectOptionModel(
          label: result[i]['name'],
          value: result[i]['_id'],
        ));
      }
    }
    return toListModel;
  }

  // fetch Sales
  Future<List<SaleModel>> fetchSales(
      {required String branchId,
      required String tableId,
      required String depId,
      required bool isTabletOrder}) async {
    Map<String, dynamic> selector = {
      'branchId': branchId,
      'tableId': tableId,
      'depId': depId,
      'status': 'Open',
    };

    // If tablet order module is active
    if (isTabletOrder) {
      selector['draft'] = isTabletOrder;
    }

    final List<dynamic> result =
        await meteor.call('rest.findSales', args: [selector]);

    List<SaleModel> toListModel = [];
    if (result.isNotEmpty) {
      toListModel = result.map((json) => SaleModel.fromJson(json)).toList();
    }
    return toListModel;
  }

  // fetch Sale Detail
  Future<List<SaleDetailModel>> fetchSaleDetails() async {
    Map<String, dynamic> selector = {'invoiceId': _activeSaleInvoiceId};
    selector['draft'] = _isTabletOrder;

    List<dynamic> result =
        await meteor.call('rest.findOrderList', args: [selector]);

    List<SaleDetailModel> toListModel = [];
    if (result.isNotEmpty) {
      toListModel =
          result.map((json) => SaleDetailModel.fromJson(json)).toList();
    }
    return toListModel;
  }

  // update sale table
  Future<ResponseModel?> updateSaleTable(
      {required String tableId, required BuildContext context}) async {
    ResponseModel? result;
    Map<String, dynamic> doc = {'_id': currentSale!.id, 'tableId': tableId};
    try {
      // set a new table Id state
      _tableId = tableId;
      // set table location state by new table Id state
      _tableLocation = await fetchTableLocation(tableId: _tableId);
      // set sale action app bar title
      _saleActionAppBarTitle = SaleAppBarActionModel(
        title:
            "${_tableLocation.floor} (${_tableLocation.table}) : $_invoiceText",
        date: ConvertDateTime.formatTimeStampToString(_currentSale!.date, true),
      );
      await updateSaleMethod(doc: doc);
      if (context.mounted) {
        handleEnterSale(
            context: context, tableId: tableId, invoiceId: _currentSale!.id);
      }
      notifyListeners();
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  // update sale guest
  Future<ResponseModel?> updateSaleGuest({required String guestId}) async {
    ResponseModel? result;
    try {
      await updateSaleGuestMethod(saleId: currentSale!.id, guestId: guestId);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  // set current guest state
  void setCurrentGuest({required SelectOptionModel guest}) {
    _currentGuest = SelectOptionModel(label: guest.label, value: guest.value);
  }

  // update sale detail item
  Future<ResponseModel?> updateSaleDetailItem(
      {required SaleDetailModel item, required BuildContext context}) async {
    ResponseModel? result;
    try {
      await updateItemAndExtraItemMethod(item: item);
      if (context.mounted) {
        context.pop();
      }
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  // update sale detail item note
  Future<ResponseModel?> updateSaleDetailItemNote(
      {required String id,
      required String note,
      required BuildContext context}) async {
    ResponseModel? result;
    try {
      await updateDetailOnNoteMethod(id: id, note: note);
      if (context.mounted) {
        context.pop();
      }
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  // update sale discount rate
  Future<ResponseModel?> updateSaleDiscountRate(
      {required String id, required num discountRate}) async {
    ResponseModel? result;
    try {
      await updateSaleDiscountRateMethod(id: id, discountRate: discountRate);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  // update sale discount amount
  Future<ResponseModel?> updateSaleDiscountAmount(
      {required String id, required num discountAmount}) async {
    ResponseModel? result;
    try {
      await updateSaleDiscountAmountMethod(
          id: id, discountAmount: discountAmount);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  // Print
  // Note: have 2 types : print to kitchen and print bill
  Future<ResponseModel?> printToKitchen({required BuildContext context}) async {
    ResponseModel? result;
    if (_printableItems.isNotEmpty) {
      try {
        if (_currentSale != null &&
            SaleService.isModuleActive(
                modules: ['chef-monitor'],
                overpower: false,
                context: context)) {
          await updateOnPrintToKitchenMethod(saleId: _currentSale!.id);
          result = const ResponseModel(
              message: 'screens.sale.detail.alert.success.printToKitchen',
              type: AWESOMESNACKBARTYPE.success);
        }
      } catch (e) {
        if (e is MeteorError) {
          result = ResponseModel(
              message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        }
      }
    } else {
      result = ResponseModel(
          message: '$_prefixSaleDetailAlert.info.saleDetailEmpty',
          type: AWESOMESNACKBARTYPE.info);
    }
    return result;
  }

  ResponseModel? printInvoiceToKitchen({required BuildContext context}) {
    ResponseModel? result;
    if (_selectedSaleDetails.isNotEmpty) {
      context.pushNamed(SCREENS.invoiceToKitchen.toName, queryParameters: {
        'invoiceId': currentSale!.id,
        'floorName': _tableLocation.floor,
        'tableName': _tableLocation.table,
        'saleDetailIds':
            jsonEncode(_selectedSaleDetails.map((sd) => sd.id).toList())
      });
    } else {
      result = ResponseModel(
          message: '$_prefixSaleDetailAlert.info.noSelectedItemsToPrint',
          type: AWESOMESNACKBARTYPE.info);
    }
    return result;
  }

  Future<ResponseModel?> printBill({required BuildContext context}) async {
    ResponseModel? result;
    if (_saleDetails.isNotEmpty) {
      try {
        if (_currentSale != null) {
          await updateOnPrintMethod(saleId: _currentSale!.id);
          // go to invoice
          if (context.mounted) {
            context.pushNamed(SCREENS.invoice.toName, queryParameters: {
              'tableId': _tableId,
              'invoiceId': currentSale!.id,
              'showEditInvoiceBtn': 'true'
            });
          }
        }
      } catch (e) {
        if (e is MeteorError) {
          result = ResponseModel(
              message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        }
      }
    } else {
      result = ResponseModel(
          message: '$_prefixSaleDetailAlert.info.saleDetailEmpty',
          type: AWESOMESNACKBARTYPE.info);
    }
    return result;
  }

  // merge sale
  Future<ResponseModel?> mergeSale({required BuildContext context}) async {
    final GlobalKey<FormBuilderState> fbMergeSaleKey =
        GlobalKey<FormBuilderState>();
    ResponseModel? result;
    if (_sales.isNotEmpty && _saleDetails.isNotEmpty) {
      try {
        await GlobalService.openDialog(
            contentWidget: EditSaleDetailOperationActionWidget(
              fbKey: fbMergeSaleKey,
              operationType: SaleDetailOperationType.merge,
              onInsertPressed: () async {
                if (fbMergeSaleKey.currentState!.saveAndValidate()) {
                  final String saleId =
                      fbMergeSaleKey.currentState!.value['saleId'];
                  final Map<String, dynamic> data =
                      await mergeSaleMethod(saleId: saleId);
                  if (data.isNotEmpty && context.mounted) {
                    result = ResponseModel(
                        message: '$_prefixSaleDetailAlert.success.merge',
                        type: AWESOMESNACKBARTYPE.success,
                        data: data);
                    handleEnterSale(
                        context: context,
                        tableId: data['tableId'],
                        invoiceId: data['_id']);
                    // close modal
                    context.pop();
                  }
                }
              },
            ),
            context: context);
      } catch (e) {
        if (e is MeteorError) {
          result = ResponseModel(
              message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        }
      }
    } else {
      result = ResponseModel(
          message: '$_prefixSaleDetailAlert.info.noItemsMerge',
          type: AWESOMESNACKBARTYPE.info);
    }

    return result;
  }

  // transfer sale detail items
  Future<ResponseModel?> transferSaleDetailItems(
      {required BuildContext context}) async {
    final GlobalKey<FormBuilderState> fbTransferSaleDetailItemKey =
        GlobalKey<FormBuilderState>();
    ResponseModel? result;
    if (_selectedSaleDetails.isNotEmpty) {
      setSelectedSaleDetailsForOperation(
          selectedSaleDetails: _selectedSaleDetails);
      await GlobalService.openDialog(
          contentWidget: EditSaleDetailOperationActionWidget(
            fbKey: fbTransferSaleDetailItemKey,
            operationType: SaleDetailOperationType.transfer,
            onInsertPressed: () async {
              if (fbTransferSaleDetailItemKey.currentState!.saveAndValidate()) {
                final String saleId =
                    fbTransferSaleDetailItemKey.currentState!.value['saleId'];
                final Map<String, dynamic> data = await transferSaleMethod(
                    saleId: saleId,
                    selectedSaleDetailsForOperation:
                        _selectedSaleDetailsForOperation);
                if (data.isNotEmpty && context.mounted) {
                  result = ResponseModel(
                      message: '$_prefixSaleDetailAlert.success.transfer',
                      type: AWESOMESNACKBARTYPE.success);
                  handleEnterSale(
                      context: context,
                      tableId: data['tableId'],
                      invoiceId: data['_id']);
                  // close modal
                  context.pop();
                }
              }
            },
          ),
          context: context);
    } else {
      result = ResponseModel(
          message: '$_prefixSaleDetailAlert.info.noSelectedItemsTransfer',
          type: AWESOMESNACKBARTYPE.info);
    }
    return result;
  }

  // split sale detail items
  Future<ResponseModel?> splitSaleDetailItems(
      {required BuildContext context}) async {
    final GlobalKey<FormBuilderState> fbSplitSaleDetailItemKey =
        GlobalKey<FormBuilderState>();
    ResponseModel? result;
    if (_selectedSaleDetails.isNotEmpty) {
      setSelectedSaleDetailsForOperation(
          selectedSaleDetails: _selectedSaleDetails);
      await GlobalService.openDialog(
          contentWidget: EditSaleDetailOperationActionWidget(
            fbKey: fbSplitSaleDetailItemKey,
            operationType: SaleDetailOperationType.split,
            onInsertPressed: () async {
              if (fbSplitSaleDetailItemKey.currentState!.saveAndValidate()) {
                final String tableId =
                    fbSplitSaleDetailItemKey.currentState!.value['tableId'];
                try {
                  final String newInvoiceId = await splitSaleMethod(
                      tableId: tableId,
                      selectedSaleDetailsForOperation:
                          _selectedSaleDetailsForOperation);
                  if (newInvoiceId.isNotEmpty && context.mounted) {
                    result = ResponseModel(
                        message: '$_prefixSaleDetailAlert.success.split',
                        type: AWESOMESNACKBARTYPE.success);
                    handleEnterSale(
                        context: context,
                        tableId: tableId,
                        invoiceId: newInvoiceId);
                    // close modal
                    context.pop();
                  }
                } catch (e) {
                  if (e is MeteorError) {
                    result = ResponseModel(
                        message: e.message!, type: AWESOMESNACKBARTYPE.failure);
                  }
                }
              }
            },
          ),
          context: context);
    } else {
      result = ResponseModel(
          message: '$_prefixSaleDetailAlert.info.noSelectedItemsSplit',
          type: AWESOMESNACKBARTYPE.info);
    }
    return result;
  }

  // update customer count sale
  Future<ResponseModel?> updateSaleCustomerCount(
      {required BuildContext context}) async {
    final GlobalKey<FormBuilderState> fbCustomerCountKey =
        GlobalKey<FormBuilderState>();
    ResponseModel? result;
    try {
      await GlobalService.openDialog(
          contentWidget: EditSaleDetailOperationActionWidget(
            fbKey: fbCustomerCountKey,
            operationType: SaleDetailOperationType.customerCount,
            value: _currentSale?.numOfGuest,
            onInsertPressed: () async {
              if (fbCustomerCountKey.currentState!.saveAndValidate()) {
                final int numOfGuest = int.parse(
                    fbCustomerCountKey.currentState!.value['numOfGuest']);
                final String data =
                    await updateSaleCustomerCountMethod(numOfGuest: numOfGuest);
                if (data.isNotEmpty && context.mounted) {
                  result = ResponseModel(
                      message: '$_prefixSaleDetailAlert.success.customerCount',
                      type: AWESOMESNACKBARTYPE.success,
                      data: data);

                  // close modal
                  context.pop();
                }
              }
            },
          ),
          context: context);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }

    return result;
  }

  // cancel sale, cancel and copy a new sale
  // Note: copy == true it mean cancelAndCopy
  Future<ResponseModel?> cancelSale({
    required BuildContext context,
    bool copy = false,
    bool editableInvoice = false,
    String invoiceId = '',
  }) async {
    AppProvider readAppProvider = context.read<AppProvider>();
    // Note: used for enable password text field on cancel sale alert dialog
    bool enablePassword =
        readAppProvider.saleSetting.sale.requirePasswordForCopyInvoice ?? false;
    String confirmSalePassword = readAppProvider.saleSetting.sale.password!;
    final GlobalKey<FormBuilderState> fbCancelSaleKey =
        GlobalKey<FormBuilderState>();
    ResponseModel? result;
    if (_currentSale != null && _currentSale!.billed > 0 || editableInvoice) {
      try {
        // Note: invoiceId exist when user edit invoice (cancel & copy) on print preview
        final String currentSaleId =
            editableInvoice ? invoiceId : _currentSale!.id;
        await GlobalService.openDialog(
            contentWidget: ConfirmDialogWidget(
              content: CancelSaleCdcWidget(
                  enablePassword: enablePassword,
                  copy: copy,
                  confirmSalePassword: confirmSalePassword,
                  fbKey: fbCancelSaleKey),
              onAgreePressed: () async {
                // cancel sale or cancel & copy sale with password
                if (enablePassword) {
                  if (fbCancelSaleKey.currentState!.saveAndValidate()) {
                    if (copy) {
                      final String newInvoiceId =
                          await cancelAndCopySaleMethod(saleId: currentSaleId);
                      if (context.mounted) {
                        result = ResponseModel(
                            message:
                                '$_prefixSaleDetailAlert.success.cancelAndCopy',
                            type: AWESOMESNACKBARTYPE.success);
                        // go to sale
                        handleEnterSale(
                            context: context, invoiceId: newInvoiceId);
                      }
                    } else {
                      await cancelSaleMethod(saleId: currentSaleId);
                    }
                    // close modal
                    if (context.mounted) {
                      context.pop();
                    }
                  }
                } else {
                  // cancel sale or cancel & copy without password
                  if (copy) {
                    final String newInvoiceId =
                        await cancelAndCopySaleMethod(saleId: currentSaleId);

                    if (context.mounted) {
                      result = ResponseModel(
                          message:
                              '$_prefixSaleDetailAlert.success.cancelAndCopy',
                          type: AWESOMESNACKBARTYPE.success);
                      // go to sale
                      handleEnterSale(
                          context: context, invoiceId: newInvoiceId);
                    }
                  } else {
                    await cancelSaleMethod(saleId: currentSaleId);
                  }
                  // close modal
                  if (context.mounted) {
                    context.pop();
                  }
                }
              },
            ),
            context: context);
      } catch (e) {
        if (e is MeteorError) {
          result = ResponseModel(
              message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        }
      }
    } else {
      result = ResponseModel(
          message: '$_prefixSaleDetailAlert.info.printBeforeCancel',
          type: AWESOMESNACKBARTYPE.info);
    }
    return result;
  }

  // preview
  Future<ResponseModel?> preview({required BuildContext context}) async {
    ResponseModel? result;
    AppProvider readAppProvider = context.read<AppProvider>();
    const String prefixSaleInvoice = 'screens.sale.invoice';
    if (_currentSale != null || _saleDetails.isNotEmpty) {
      List<String> saleDetailDraftItemIds = _saleDetails
          .where((sd) => sd.draft == true)
          .map((sd) => sd.id)
          .toList();
      if (saleDetailDraftItemIds.isNotEmpty) {
        // invoice information
        List<SelectOptionModel> info = [
          SelectOptionModel(
              label: "$prefixSaleInvoice.info.invoice",
              value: _currentSale!.refNo),
          SelectOptionModel(
              label: "$prefixSaleInvoice.info.customer",
              value: _currentSale!.guestName),
          SelectOptionModel(
              label: "$prefixSaleInvoice.info.tableLocation",
              value: "${_tableLocation.floor} - ${_tableLocation.table}"),
          SelectOptionModel(
              label: "$prefixSaleInvoice.info.user",
              value: readAppProvider.currentUser?.profile.fullName),
          SelectOptionModel(
              label: "$prefixSaleInvoice.info.date",
              value: ConvertDateTime.formatTimeStampToString(
                  _currentSale!.date, true)),
        ];
        // invoice footer
        num subTotal = calculateSubTotal(saleDetails: saleDetails);
        num discountValue = calculateDiscount(
            currentSale: _currentSale, subTotal: subTotal)['value'];
        num total =
            calculateTotal(subTotal: subTotal, discountValue: discountValue);
        List<SelectOptionModel> footer = [
          SelectOptionModel(
              label: '$prefixSaleInvoice.footer.subTotal', value: subTotal),
          SelectOptionModel(
              label: '$prefixSaleInvoice.footer.discountAmount',
              value: discountValue),
          SelectOptionModel(
              label: '$prefixSaleInvoice.footer.total', value: total)
        ];

        if (context.mounted) {
          await GlobalService.openDialog(
              contentWidget: EditSaleDetailFooterActionWidget(
                titleIcon: RestaurantDefaultIcons.preview,
                footerType: SaleDetailFooterType.preview,
                value: {
                  'info': info,
                  'saleDetails': _saleDetails,
                  'footer': footer,
                },
                insertLabel: 'screens.sale.detail.dialog.actions.submit',
                onInsertPressed: () async {
                  // station list
                  // Note: this feature not add yet with Module "multi-printers"
                  // List<dynamic> stationList =
                  //     await findSaleDetailGroupByStationMethod(
                  //         saleDetailIds: saleDetailDraftItemIds);
                  // open confirm dialog
                  if (context.mounted) {
                    await GlobalService.openDialog(
                        contentWidget: ConfirmDialogWidget(
                          content: Text(
                              'screens.sale.detail.dialog.confirm.submitOrders.description'
                                  .tr()),
                          onAgreePressed: () async {
                            // Note: this feature not add yet with Module "multi-printers"
                            List<String> printItemIds = [];
                            try {
                              await updateSaleDraftToNormalMethod(
                                  saleId: currentSale!.id,
                                  printItemIds: printItemIds);
                              // insert notification
                              await upsertNotificationsMethods(
                                  saleId: currentSale!.id,
                                  branchId: currentSale!.branchId,
                                  depId: currentSale!.depId);
                              // Back to sale table
                              if (context.mounted) {
                                context.goNamed(SCREENS.saleTable.toName);
                              }
                            } catch (e) {
                              if (e is MeteorError) {
                                result = ResponseModel(
                                    message: e.message!,
                                    type: AWESOMESNACKBARTYPE.failure);
                              }
                            }
                          },
                        ),
                        context: context);
                  }
                },
              ),
              context: context);
        }
      } else {
        result = ResponseModel(
            message: '$_prefixSaleDetailAlert.info.noNewItem',
            type: AWESOMESNACKBARTYPE.info);
      }
    }
    return result;
  }

  // payment
  Future<ResponseModel?> payment({
    required BuildContext context,
    String? invoiceId,
    bool fromDashboard = false,
    bool makeRepaid = false,
    bool isPrint = false,
  }) async {
    // Note: invoiceId exist if route come from dashboard
    ResponseModel? result;
    if (_currentSale != null && _saleDetails.isNotEmpty || fromDashboard) {
      final GlobalKey<FormBuilderState> fbPaymentKey =
          GlobalKey<FormBuilderState>();
      SaleReceiptModel saleReceipt = await fetchSaleReceipt(
          invoiceId: !fromDashboard ? _currentSale!.id : invoiceId!);
      List<String> allowedCurrencies = [];
      if (context.mounted) {
        if (fromDashboard) {
          AppProvider readAppProvider = context.read<AppProvider>();
          _baseCurrency = readAppProvider.companyAccounting.baseCurrency;
          _decimalNumber = readAppProvider.companyAccounting.decimalNumber;
          _roundNumber = RoundNumber(
              decimalNumber:
                  _baseCurrency == 'KHR' ? -_decimalNumber : _decimalNumber);
          _branchId = readAppProvider.selectedBranch!.id;
        }
        allowedCurrencies = getAllowedCurrencies(context: context);
        await getOpenReceiveReturn(
            allowedCurrencies: allowedCurrencies, saleReceipt: saleReceipt);
      }
      if (context.mounted) {
        await GlobalService.openDialog(
            contentWidget: EditSaleDetailFooterActionWidget(
              fbKey: fbPaymentKey,
              titleIcon: RestaurantDefaultIcons.saleReceipt,
              footerType: SaleDetailFooterType.payment,
              value: {
                'saleReceipt': saleReceipt,
                'allowedCurrencies': allowedCurrencies,
              },
              onInsertPressed: () async {
                result = await handleInsertPayment(
                    fbPaymentKey: fbPaymentKey,
                    saleReceipt: saleReceipt,
                    makeRepaid: makeRepaid,
                    fromDashboard: fromDashboard,
                    context: context);
              },
              onInsertAndPrintPressed: () async {
                result = await handleInsertPayment(
                    fbPaymentKey: fbPaymentKey,
                    saleReceipt: saleReceipt,
                    makeRepaid: makeRepaid,
                    fromDashboard: fromDashboard,
                    isPrint: true,
                    context: context);
              },
            ),
            context: context);
      }
    } else {
      result = ResponseModel(
          message: '$_prefixSaleDetailAlert.info.saleEmpty',
          type: AWESOMESNACKBARTYPE.info);
    }
    return result;
  }

  Future<ResponseModel?> handleInsertPayment({
    required GlobalKey<FormBuilderState> fbPaymentKey,
    required SaleReceiptModel saleReceipt,
    bool fromReceiptForm = true,
    bool fromDashboard = false,
    bool makeRepaid = false,
    bool isPrint = false,
    required BuildContext context,
  }) async {
    ResponseModel? result;
    if (fbPaymentKey.currentState!.saveAndValidate()) {
      try {
        final Map<String, dynamic> form =
            Map.of(fbPaymentKey.currentState!.value);
        form['guestId'] = saleReceipt.orderDoc.guestId;
        form['employeeId'] = saleReceipt.orderDoc.employeeId;
        form['invoiceId'] = saleReceipt.orderDoc.id;
        form['openAmount'] = _openAmount.toJson()[_baseCurrency.toLowerCase()];
        form['receiveAmount'] =
            _receiveAmount.toJson()[_baseCurrency.toLowerCase()];
        form['feeAmount'] = _feeAmount.toJson()[_baseCurrency.toLowerCase()];
        form['branchId'] = saleReceipt.orderDoc.branchId;
        // remove useless key
        form.remove('receiveKHR');
        form.remove('receiveUSD');
        form.remove('receiveTHB');
        if (form['memo'] == null) {
          form.remove('memo');
        }
        String methodName = makeRepaid == true
            ? 'rest.insertSaleReceiptRepaid'
            : 'rest.insertSaleReceiptInit';
        final String receiptId =
            await insertSaleReceiptMethod(methodName: methodName, doc: form);
        if (context.mounted) {
          result = ResponseModel(
              message: 'screens.sale.detail.alert.success.payment',
              type: AWESOMESNACKBARTYPE.success,
              data: receiptId);
          // Close modal
          context.pop();
          if (receiptId.isEmpty) {
            // Back to dashboard
            context.goNamed(SCREENS.dashboard.toName);
          }
          // Save & Print
          if (isPrint) {
            // Go invoice
            context.goNamed(SCREENS.invoice.toName, queryParameters: {
              'tableId': _tableId,
              'invoiceId': saleReceipt.orderDoc.id,
              'receiptId': receiptId,
              'fromReceiptForm': '$fromReceiptForm',
              'fromDashboard': '$fromDashboard',
              'receiptPrint': 'true',
              'isRepaid': '$makeRepaid'
            });
          } else if (!fromDashboard &&
              (_isSkipTable != null && _isSkipTable == false)) {
            // Back to sale table if fromDashboard == false and skip table module == false
            context.goNamed(SCREENS.saleTable.toName);
          }
        }
      } catch (e) {
        if (e is MeteorError) {
          result = ResponseModel(
              message: e.message!, type: AWESOMESNACKBARTYPE.failure);
        }
      }
    }
    return result;
  }

  Future<SaleReceiptModel> fetchSaleReceipt({required String invoiceId}) async {
    late SaleReceiptModel toModel;
    if (invoiceId.isNotEmpty) {
      Map<String, dynamic> selector = {
        'invoiceId': invoiceId,
      };
      final Map<String, dynamic> result =
          await meteor.call('rest.findSaleReceiptFormData', args: [selector]);
      if (result.isNotEmpty) {
        toModel = SaleReceiptModel.fromJson(result);
      }
    }
    return toModel;
  }

  Future<List<SelectOptionModel>> fetchPaymentMethods(
      {String? branchId}) async {
    Map<String, dynamic> selector = {'branchId': branchId ?? _branchId};
    Map<String, dynamic> options = {
      'sort': {'name': 1}
    };
    List<dynamic> result = await meteor.call('rest.findPaymentMethods', args: [
      {'selector': selector, 'options': options}
    ]);
    List<SelectOptionModel> toListModel = [];
    if (result.isNotEmpty) {
      // convert Json to List<SelectOptionModel>
      for (int i = 0; i < result.length; i++) {
        toListModel.add(SelectOptionModel(
          label: result[i]['name'],
          value: result[i]['_id'],
          extra: result[i]['fee'],
        ));
      }
    }
    return toListModel;
  }

  List<String> getAllowedCurrencies({required BuildContext context}) {
    AppProvider readAppProvider = context.read<AppProvider>();
    final baseCurrency = readAppProvider.companyAccounting.baseCurrency;
    List<String> base = [baseCurrency];
    List<String> allowedCurrencies =
        readAppProvider.companyAccounting.allowedCurrencies;
    // merge base with allowedCurrencies and remove duplicate
    return <String>{...base, ...allowedCurrencies}.toList();
  }

  late SaleReceiptAllowCurrencyAmountModel _openAmount;
  SaleReceiptAllowCurrencyAmountModel get openAmount => _openAmount;
  late SaleReceiptAllowCurrencyAmountModel _receiveAmount;
  SaleReceiptAllowCurrencyAmountModel get receiveAmount => _receiveAmount;
  late num _fee;
  num get fee => _fee;
  late SaleReceiptAllowCurrencyAmountModel _feeAmount;
  SaleReceiptAllowCurrencyAmountModel get feeAmount => _feeAmount;
  late SaleReceiptAllowCurrencyAmountModel _returnAmount;
  SaleReceiptAllowCurrencyAmountModel get returnAmount => _returnAmount;

  Future<void> getOpenReceiveReturn(
      {required List<String> allowedCurrencies,
      required SaleReceiptModel saleReceipt}) async {
    _openAmount =
        const SaleReceiptAllowCurrencyAmountModel(khr: 0, usd: 0, thb: 0);
    _receiveAmount =
        const SaleReceiptAllowCurrencyAmountModel(khr: 0, usd: 0, thb: 0);
    _fee = 0;
    _feeAmount =
        const SaleReceiptAllowCurrencyAmountModel(khr: 0, usd: 0, thb: 0);
    _returnAmount =
        const SaleReceiptAllowCurrencyAmountModel(khr: 0, usd: 0, thb: 0);
    _openAmount = getOpenAmountExchange(saleReceipt: saleReceipt);
    _receiveAmount = getOpenAmountExchange(saleReceipt: saleReceipt);
    _returnAmount =
        getReturnAmount(openAmount: _openAmount, receiveAmount: _receiveAmount);
    notifyListeners();
  }

  // Fee Amount
  void getFeeAmount({required num fee}) {
    _fee = fee;
    Map<String, dynamic> feeAmount = {'khr': 0, 'usd': 0, 'thb': 0};
    num openAmountBase = _openAmount.toJson()[_baseCurrency.toLowerCase()];
    num receiveAmountBase =
        _receiveAmount.toJson()[_baseCurrency.toLowerCase()];
    // If receive > open amount, calculate fee base on open amount
    SaleReceiptAllowCurrencyAmountModel amountBase =
        receiveAmountBase >= openAmountBase ? _openAmount : _receiveAmount;
    List<String> currencyList = ['KHR', 'USD', 'THB'];
    for (String currency in currencyList) {
      feeAmount[currency.toLowerCase()] = formatMoney(
          amount: Big(amountBase.toJson()[currency.toLowerCase()])
              .times(Big(fee).div(100))
              .toNumber(),
          baseCurrency: currency);
    }
    // convert to model
    SaleReceiptAllowCurrencyAmountModel toModel =
        SaleReceiptAllowCurrencyAmountModel.fromJson(feeAmount);
    _feeAmount = toModel;
    notifyListeners();
  }

  // Open Amount
  SaleReceiptAllowCurrencyAmountModel getOpenAmountExchange(
      {required SaleReceiptModel saleReceipt}) {
    num total = saleReceipt.orderDoc.total;
    num totalReceived = saleReceipt.orderDoc.totalReceived;
    ExchangeModel exchange = saleReceipt.exchangeDoc;
    Map<String, dynamic> openAmount = {'khr': 0, 'usd': 0, 'thb': 0};
    switch (_baseCurrency) {
      case "KHR":
        // to KHR
        openAmount['khr'] = formatMoney(
            amount: Big(total).sub(totalReceived).toNumber(),
            baseCurrency: 'KHR');
        // to USD
        openAmount['usd'] = formatMoney(
            amount: Big(openAmount['khr'])
                .div(Big(exchange.usd).times(exchange.khr))
                .toNumber(),
            baseCurrency: 'USD');
        // to THB
        openAmount['thb'] = formatMoney(
            amount: Big(openAmount['usd']).times(exchange.thb).toNumber(),
            baseCurrency: 'THB');
        break;
      case "USD":
        // to USD
        openAmount['usd'] = formatMoney(
            amount: Big(total).sub(totalReceived).toNumber(),
            baseCurrency: 'USD');
        // to KHR
        openAmount['khr'] = formatMoney(
            amount: Big(openAmount['usd'])
                .times(Big(exchange.usd).times(exchange.khr))
                .toNumber(),
            baseCurrency: 'KHR');
        // to THB
        openAmount['thb'] = formatMoney(
            amount: Big(openAmount['usd']).times(exchange.thb).toNumber(),
            baseCurrency: 'THB');
        break;
      default:
        // to THB
        openAmount['thb'] = formatMoney(
            amount: Big(total).sub(totalReceived).toNumber(),
            baseCurrency: 'THB');
        // to USD
        openAmount['usd'] = formatMoney(
            amount: Big(openAmount['thb'])
                .div(Big(exchange.usd).times(exchange.thb))
                .toNumber(),
            baseCurrency: 'USD');
        // to KHR
        openAmount['khr'] = formatMoney(
            amount: Big(openAmount['usd'])
                .times(Big(exchange.usd).times(exchange.khr))
                .toNumber(),
            baseCurrency: 'KHR');
    }
    return SaleReceiptAllowCurrencyAmountModel.fromJson(openAmount);
  }

  // Return Amount
  SaleReceiptAllowCurrencyAmountModel getReturnAmount(
      {required SaleReceiptAllowCurrencyAmountModel openAmount,
      required SaleReceiptAllowCurrencyAmountModel receiveAmount}) {
    Map<String, dynamic> returnAmount = {'khr': 0, 'usd': 0, 'thb': 0};
    // KHR
    returnAmount['khr'] = formatMoney(
        amount: Big(receiveAmount.khr).sub(openAmount.khr).toNumber(),
        baseCurrency: 'KHR');
    // USD
    returnAmount['usd'] = formatMoney(
        amount: Big(receiveAmount.usd).sub(openAmount.usd).toNumber(),
        baseCurrency: 'USD');
    // THB
    returnAmount['thb'] = formatMoney(
        amount: Big(receiveAmount.thb).sub(openAmount.thb).toNumber(),
        baseCurrency: 'THB');
    return SaleReceiptAllowCurrencyAmountModel.fromJson(returnAmount);
  }

  num formatMoney({required num amount, required String baseCurrency}) {
    return _roundNumber.round(
        value: amount,
        decimalNumber: baseCurrency == 'KHR' ? -_decimalNumber : _decimalNumber,
        roundingMode: baseCurrency == 'KHR' ? RoundingMode.roundUp : null);
  }

  void handleReceiveInputChange(
      {required num amount,
      required String currency,
      required ExchangeModel exchange}) {
    switch (currency) {
      case "KHR":
        _receiveAmount = handleReceiveKHR(amount: amount, exchange: exchange);
        break;
      case "USD":
        _receiveAmount = handleReceiveUSD(amount: amount, exchange: exchange);
        break;
      default:
        _receiveAmount = handleReceiveTHB(amount: amount, exchange: exchange);
    }
    _returnAmount =
        getReturnAmount(openAmount: _openAmount, receiveAmount: _receiveAmount);
    notifyListeners();
  }

  SaleReceiptAllowCurrencyAmountModel handleReceiveKHR(
      {required num amount, required ExchangeModel exchange}) {
    Map<String, dynamic> receiveAmount = {'khr': 0, 'usd': 0, 'thb': 0};
    receiveAmount['khr'] = amount;
    if (amount == _openAmount.khr) {
      receiveAmount['usd'] = _openAmount.usd;
      receiveAmount['thb'] = _openAmount.thb;
    } else {
      receiveAmount['usd'] = formatMoney(
          amount:
              Big(amount).div(Big(exchange.usd).times(exchange.khr)).toNumber(),
          baseCurrency: 'USD');
      receiveAmount['thb'] = formatMoney(
          amount: Big(receiveAmount['usd']).times(exchange.thb).toNumber(),
          baseCurrency: 'THB');
    }
    return SaleReceiptAllowCurrencyAmountModel.fromJson(receiveAmount);
  }

  SaleReceiptAllowCurrencyAmountModel handleReceiveUSD(
      {required num amount, required ExchangeModel exchange}) {
    Map<String, dynamic> receiveAmount = {'khr': 0, 'usd': 0, 'thb': 0};
    receiveAmount['usd'] = amount;
    if (amount == _openAmount.usd) {
      receiveAmount['khr'] = _openAmount.khr;
      receiveAmount['thb'] = _openAmount.thb;
    } else {
      receiveAmount['khr'] = formatMoney(
          amount: Big(amount)
              .times(Big(exchange.usd).times(exchange.khr))
              .toNumber(),
          baseCurrency: 'KHR');
      receiveAmount['thb'] = formatMoney(
          amount: Big(amount).times(exchange.thb).toNumber(),
          baseCurrency: 'THB');
    }
    return SaleReceiptAllowCurrencyAmountModel.fromJson(receiveAmount);
  }

  SaleReceiptAllowCurrencyAmountModel handleReceiveTHB(
      {required num amount, required ExchangeModel exchange}) {
    Map<String, dynamic> receiveAmount = {'khr': 0, 'usd': 0, 'thb': 0};
    receiveAmount['thb'] = amount;
    if (amount == _openAmount.thb) {
      receiveAmount['khr'] = _openAmount.khr;
      receiveAmount['usd'] = _openAmount.usd;
    } else {
      receiveAmount['usd'] = formatMoney(
          amount:
              Big(amount).div(Big(exchange.usd).times(exchange.thb)).toNumber(),
          baseCurrency: 'USD');
      receiveAmount['khr'] = formatMoney(
          amount: Big(receiveAmount['usd'])
              .times(Big(exchange.usd).times(exchange.khr))
              .toNumber(),
          baseCurrency: 'KHR');
    }
    return SaleReceiptAllowCurrencyAmountModel.fromJson(receiveAmount);
  }

  // Methods
  Future<dynamic> insertGuestMethod({required InsertGuestModel doc}) {
    return meteor.call('rest.insertGuest', args: [doc.toJson()]);
  }

  Future<dynamic> insertSaleMethod({required SaleInvoiceActionModel doc}) {
    return meteor.call('rest.insertSale', args: [
      {'doc': doc.toJson()}
    ]);
  }

  Future<dynamic> insertSaleDetailMethod({required InsertItemInputModel doc}) {
    return meteor.call('rest.insertSaleDetail', args: [
      {'doc': doc.toJson()}
    ]);
  }

  Future<dynamic> insertSaleDetailExtraMethod(
      {required InsertItemInputModel doc,
      required List<SaleDetailModel> itemList}) {
    return meteor.call('rest.insertSaleDetailExtra', args: [
      {
        'doc': doc.toJson(),
        'itemList': itemList.map((i) => i.toJson()).toList()
      }
    ]);
  }

  // insert sale detail list (product as catalogType == 'Set')
  Future<dynamic> insertSaleDetailListMethod(
      {required InsertItemInputModel doc}) {
    return meteor.call('rest.insertSaleDetailList', args: [
      {'doc': doc.toJson(), 'depId': _depId}
    ]);
  }

  Future<dynamic> updateSaleMethod({required Map<String, dynamic> doc}) {
    return meteor.call('rest.updateSale', args: [
      {'doc': doc}
    ]);
  }

  Future<dynamic> updateSaleGuestMethod(
      {required String saleId, required String guestId}) {
    Map<String, dynamic> selector = {'_id': saleId, 'guestId': guestId};
    return meteor.call('rest.updateSaleGuest', args: [selector]);
  }

  Future<dynamic> updateItemAndExtraItemMethod(
      {required SaleDetailModel item}) {
    return meteor.call('rest.updateSaleDetailAndExtraItems', args: [
      {'item': item.toJson()}
    ]);
  }

  Future<dynamic> updateDetailOnNoteMethod(
      {required String id, required String note}) {
    return meteor.call('rest.updateDetailOnNote', args: [
      {'_id': id, 'note': note}
    ]);
  }

  Future<dynamic> updateSaleDiscountRateMethod(
      {required String id, required num discountRate}) {
    return meteor.call('rest.updateSaleDiscountRate', args: [
      {'_id': id, 'discountRate': discountRate}
    ]);
  }

  Future<dynamic> updateSaleDiscountAmountMethod(
      {required String id, required num discountAmount}) {
    return meteor.call('rest.updateSaleDiscountValue', args: [
      {'_id': id, 'discountValue': discountAmount}
    ]);
  }

  // remove sale detail item
  Future<dynamic> removeSaleDetailMethod(
      {required String id, bool decreaseCount = false}) {
    return meteor.call('rest.removeSaleDetail', args: [
      {'_id': id, 'decreaseCount': decreaseCount}
    ]);
  }

  //  remove empty sale invoice
  Future<dynamic> removeEmptySaleInvoiceMethod() {
    Map<String, dynamic> selector = {
      'currentDate': DateTime.now(),
      'employeeId': _employeeId
    };
    return meteor.call('rest.removeEmptySale', args: [selector]);
  }

  // Preview
  Future<dynamic> findSaleDetailGroupByStationMethod(
      {required List<String> saleDetailIds}) {
    Map<String, dynamic> selector = {'_ids': saleDetailIds};
    return meteor.call('rest.findSaleDetailGroupByStation', args: [selector]);
  }

  Future<dynamic> updateSaleDraftToNormalMethod(
      {required String saleId, required List<String> printItemIds}) {
    Map<String, dynamic> selector = {
      'invoiceId': saleId,
      'printItemIds': printItemIds
    };
    return meteor.call('rest.updateSaleDraftToNormal', args: [selector]);
  }

  Future<dynamic> upsertNotificationsMethods({
    required String saleId,
    required String branchId,
    required String depId,
  }) {
    Map<String, dynamic> doc = {
      'type': 'IO',
      'refId': saleId,
      'date': DateTime.now(),
      'branchId': branchId,
      'depId': depId,
    };
    return meteor.call('rest.upsertNotifications', args: [doc]);
  }

  // Print
  // update field billed, checkPrint on sale and sale detail
  Future<dynamic> updateOnPrintMethod({required String saleId}) {
    Map<String, dynamic> selector = {'_id': saleId, 'employeeId': _employeeId};
    return meteor.call('rest.updateOnPrint', args: [selector]);
  }

  Future<dynamic> updateOnPrintToKitchenMethod({required String saleId}) {
    Map<String, dynamic> selector = {
      'invoiceId': saleId,
      'itemIds': _printableItems.map((i) => i.id).toList()
    };
    return meteor.call('rest.updateOnPrintToKitchen', args: [selector]);
  }

  // Operations
  // merge
  Future<List<SelectOptionModel>> fetchSaleGroupByTable(
      {required BuildContext context}) async {
    List<SelectOptionModel> toListModel = [];
    if (_currentSale != null) {
      Map<String, dynamic> selector = {
        'status': 'Open',
        'depId': _currentSale!.depId,
        'banInvoice': _currentSale!.id,
        'branchId': _branchId,
      };
      final result =
          await meteor.call('rest.findSaleGroupByTable', args: [selector]);
      if (result.isNotEmpty) {
        for (int i = 0; i < result.length; i++) {
          toListModel.add(
            SelectOptionModel(
                label: result[i]['location'],
                value: result[i]['_id'],
                extra: 'table-location'),
          );
          if (result[i]['invoices'].isNotEmpty) {
            for (int j = 0; j < result[i]['invoices'].length; j++) {
              String label = result[i]['invoices'][j]['refNo'];
              if (context.mounted &&
                  SaleService.isModuleActive(
                      modules: ['order-number'],
                      overpower: false,
                      context: context)) {
                label += "-${result[i]['invoices'][j]['orderNum']}";
              }
              toListModel.add(
                SelectOptionModel(
                  label: label,
                  value: result[i]['invoices'][j]['_id'],
                ),
              );
            }
          }
        }
      }
    }
    return toListModel;
  }

  Future<dynamic> mergeSaleMethod({required String saleId}) {
    Map<String, dynamic> selector = {
      'currentInvoice': _currentSale!.id,
      'mergeInvoice': saleId
    };
    return meteor.call('rest.updateOnMerge', args: [selector]);
  }

  Future<dynamic> transferSaleMethod(
      {required String saleId,
      required List<SaleDetailModel> selectedSaleDetailsForOperation}) {
    Map<String, dynamic> selector = {
      'items':
          selectedSaleDetailsForOperation.map((sd) => sd.toJson()).toList(),
      'currentInvoice': _currentSale!.id,
      'transferInvoice': saleId,
    };
    return meteor.call('rest.updateOnTransfer', args: [selector]);
  }

  Future<dynamic> splitSaleMethod(
      {required String tableId,
      required List<SaleDetailModel> selectedSaleDetailsForOperation}) {
    final SaleInvoiceActionModel doc = SaleInvoiceActionModel(
        date: DateTime.now(),
        type: 'Invoice',
        status: 'Open',
        statusDate: SaleInvoiceStatusDateModel(open: DateTime.now()),
        discountRate: 0,
        discountValue: 0,
        total: 0,
        totalReceived: 0,
        tableId: tableId,
        depId: _depId,
        employeeId: _employeeId,
        guestId: _currentGuest.value,
        numOfGuest: 0,
        billed: 0,
        branchId: _branchId);
    Map<String, dynamic> selector = {
      'doc': doc.toJson(),
      'items':
          selectedSaleDetailsForOperation.map((sd) => sd.toJson()).toList(),
      'currentInvoice': _currentSale!.id,
    };
    return meteor.call('rest.splitSale', args: [selector]);
  }

  Future<dynamic> cancelSaleMethod({required String saleId}) {
    Map<String, dynamic> selector = {'_id': saleId, 'employeeId': _employeeId};
    return meteor.call('rest.cancelOrder', args: [selector]);
  }

  Future<dynamic> updateSaleCustomerCountMethod({required int numOfGuest}) {
    Map<String, dynamic> selector = {
      '_id': _currentSale!.id,
      'numOfGuest': numOfGuest
    };
    return meteor.call('rest.updateSale', args: [
      {'doc': selector}
    ]);
  }

  Future<dynamic> cancelAndCopySaleMethod({required String saleId}) {
    Map<String, dynamic> selector = {'_id': saleId, 'employeeId': _employeeId};
    return meteor.call('rest.cancelCopySale', args: [selector]);
  }

  Future<dynamic> insertSaleReceiptMethod(
      {required String methodName, required Map<String, dynamic> doc}) {
    Map<String, dynamic> selector = {'doc': doc};
    return meteor.call(methodName, args: [selector]);
  }

  void unSubscribe() {
    if (_saleSubscription.subId.isNotEmpty) {
      _saleSubscription.stop();
      _saleListener.cancel();
    }
  }
}
