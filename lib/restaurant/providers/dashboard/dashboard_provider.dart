import 'package:big_dart/big_dart.dart';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../models/servers/response_model.dart';
import '../../../providers/app_provider.dart';
import '../../../screens/app_screen.dart';
import '../../../services/global_service.dart';
import '../../../utils/alert/alert.dart';
import '../../../utils/alert/awesome_snack_bar_utils.dart';
import '../../models/sale/invoice/sale_invoice_model.dart';
import '../../models/sale/receipt/edit_sale_receipt_model.dart';
import '../../utils/constants.dart';
import '../../utils/round_number.dart';
import '../../widgets/confirm_dialog_widget.dart';
import '../../widgets/dashboard/confirm-dialog-content/edit_sale_receipt_cdc_widget.dart';
import '../../widgets/dialog_widget.dart';
import '../../widgets/receipt/edit_sale_receipt_widget.dart';

class DashboardProvider extends ChangeNotifier {
  late String _branchId;
  late String _depId;
  SaleInvoiceModel _saleInvoice =
      const SaleInvoiceModel(data: [], totalRecords: 0);
  SaleInvoiceModel get saleInvoice => _saleInvoice;
  late int _selectedTab;
  int get selectedTab => _selectedTab;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isFiltering = false;
  bool get isFiltering => _isFiltering;
  late String _filterText;
  String get filterText => _filterText;
  final int _pageSize = 10;
  int get pageSize => _pageSize;

  // edit sale receipt
  late num _fee;
  num get fee => _fee;
  late num _feeAmount;
  num get feeAmount => _feeAmount;
  late num _receiveAmount;
  num get receiveAmount => _receiveAmount;

  void initData({required String branchId, required String depId}) async {
    _isLoading = true;
    notifyListeners();
    _selectedTab = 0;
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
        filter: _filterText,
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

  Future<ResponseModel?> removeSale({required String id}) async {
    ResponseModel? result;
    try {
      await removeSaleMethod(id: id);
      result = const ResponseModel(
          message: 'screens.dashboard.alert.success.removeSale',
          type: AWESOMESNACKBARTYPE.success);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  Future<ResponseModel?> editSaleReceipt({
    required String receiptId,
    required BuildContext context,
  }) async {
    AppProvider readAppProvider = context.read<AppProvider>();
    String confirmSalePassword = readAppProvider.saleSetting.sale.password!;
    final GlobalKey<FormBuilderState> fbConfirmKey =
        GlobalKey<FormBuilderState>();
    final GlobalKey<FormBuilderState> fbEditSaleReceiptKey =
        GlobalKey<FormBuilderState>();
    ResponseModel? result;
    try {
      await GlobalService.openDialog(
          contentWidget: ConfirmDialogWidget(
            content: EditSaleReceiptCdcWidget(
                confirmSalePassword: confirmSalePassword, fbKey: fbConfirmKey),
            onAgreePressed: () async {
              if (fbConfirmKey.currentState!.saveAndValidate()) {
                AppProvider readAppProvider = context.read<AppProvider>();
                final saleReceipt =
                    await findReceiptForEditById(receiptId: receiptId);
                _fee = 0;
                _feeAmount = 0;
                _receiveAmount = 0;
                final String baseCurrency =
                    readAppProvider.companyAccounting.baseCurrency;
                final int decimalNumber =
                    readAppProvider.companyAccounting.decimalNumber;
                final String employeeId = readAppProvider.currentUser!.id;
                if (context.mounted) {
                  // close modal
                  context.pop();
                  // open edit sale receipt
                  await GlobalService.openDialog(
                      contentWidget: DialogWidget(
                        type: DialogType.update,
                        titleIcon: RestaurantDefaultIcons.edit,
                        title:
                            'screens.dashboard.dialog.confirm.editSaleReceipt.title',
                        content: SizedBox(
                          width: double.maxFinite,
                          child: EditSaleReceiptWidget(
                            fbEditSaleReceiptKey: fbEditSaleReceiptKey,
                            saleReceipt: saleReceipt,
                            baseCurrency: baseCurrency,
                            decimalNumber: decimalNumber,
                          ),
                        ),
                        onUpdatePressed: () async {
                          if (fbEditSaleReceiptKey.currentState!
                              .saveAndValidate()) {
                            // prepare sale receipt doc for update
                            final form =
                                fbEditSaleReceiptKey.currentState!.value;
                            Map<String, dynamic> doc = {
                              '_id': saleReceipt.id,
                              'date': form['date'],
                              'paymentBy': form['paymentBy'],
                              'receiveAmount':
                                  num.tryParse(form['receiveAmount']),
                              'feeAmount': _feeAmount,
                              'guestId': form['guestId'],
                              'branchId': saleReceipt.branchId,
                              'invoiceId': saleReceipt.invoiceId,
                              'openAmount': saleReceipt.openAmount,
                              'employeeId': employeeId,
                              'memo': form['memo'],
                            };
                            final ResponseModel? result =
                                await updateSaleReceipt(doc: doc);
                            if (result != null &&
                                result.type == AWESOMESNACKBARTYPE.success) {
                              late SnackBar snackBar;
                              snackBar = Alert.awesomeSnackBar(
                                  message: result.message, type: result.type);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              // reload sale invoice on dashboard if update success
                              await filter(
                                  tab: _selectedTab, filterText: _filterText);
                            }
                            if (context.mounted) {
                              context.pop();
                            }
                          }
                        },
                      ),
                      context: context);
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

  Future<EditSaleReceiptModel> findReceiptForEditById(
      {required String receiptId}) async {
    final Map<String, dynamic> result =
        await meteor.call('rest.findReceiptForEditById', args: [
      {'_id': receiptId}
    ]);
    late EditSaleReceiptModel toModel;
    if (result.isNotEmpty) {
      toModel = EditSaleReceiptModel.fromJson(result);
    }
    return toModel;
  }

  Future<ResponseModel?> updateSaleReceipt({
    required Map<String, dynamic> doc,
  }) async {
    ResponseModel? result;
    try {
      await updateSaleReceiptMethod(doc: doc);
      result = const ResponseModel(
          message: 'screens.dashboard.alert.success.updateSaleReceipt',
          type: AWESOMESNACKBARTYPE.success);
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    return result;
  }

  void setFee({required num fee}) {
    _fee = fee;
    notifyListeners();
  }

  void setReceiveAmount({required num receiveAmount}) {
    _receiveAmount = receiveAmount;
    notifyListeners();
  }

  void getFeeAmount({
    required num openAmount,
    required num fee,
    required num receiveAmount,
    required String baseCurrency,
    required int decimalNumber,
  }) {
    num amountBase = receiveAmount >= openAmount ? openAmount : receiveAmount;
    num feeAmount = formatMoney(
        amount: Big(amountBase).times(Big(fee).div(100)).toNumber(),
        baseCurrency: baseCurrency,
        decimalNumber: decimalNumber);
    _feeAmount = feeAmount;
    notifyListeners();
  }

  num formatMoney(
      {required num amount,
      required String baseCurrency,
      required int decimalNumber}) {
    final roundNumber = RoundNumber(
        decimalNumber: baseCurrency == 'KHR' ? -decimalNumber : decimalNumber);
    return roundNumber.round(
        value: amount,
        roundingMode: baseCurrency == 'KHR' ? RoundingMode.roundUp : null);
  }

  Future<dynamic> updateSaleReceiptMethod({required Map<String, dynamic> doc}) {
    return meteor.call('rest.updateSaleReceipt', args: [
      {'doc': doc}
    ]);
  }

  Future<dynamic> removeSaleMethod({required String id}) {
    return meteor.call('rest.removeSale', args: [
      {'_id': id}
    ]);
  }
}
