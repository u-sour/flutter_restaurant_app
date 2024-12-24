import 'package:dart_meteor/dart_meteor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../models/servers/response_model.dart';
import '../../../providers/app_provider.dart';
import '../../../utils/alert/awesome_snack_bar_utils.dart';
import '../../../screens/app_screen.dart';
import '../../models/option/option_model.dart';
import '../../models/reports/report_exchange_model.dart';
import '../../models/reports/sale-receipt/sale_receipt_data_report_model.dart';
import '../../models/reports/sale-receipt/sale_receipt_report_model.dart';
import '../../models/reports/sale-receipt/sale_receipt_total_doc_report_model.dart';
import '../../services/report_service.dart';
import '../../services/sale_service.dart';
import '../../utils/report/sale_receipt_report_utils.dart';

class SaleReceiptReportProvider extends ChangeNotifier {
  final String _prefixFormBuilderInputDecoration =
      'screens.formBuilderInputDecoration';
  late String _branchId;
  String get branchId => _branchId;
  List<OptionModel> _filters = [];
  List<OptionModel> get filters => _filters;
  late SaleReceiptReportModel _saleReceiptReportResult;
  SaleReceiptReportModel get saleReceiptReportResult =>
      _saleReceiptReportResult;

  void initData() {
    _saleReceiptReportResult = const SaleReceiptReportModel(
      data: [],
      totalDoc: SaleReceiptTotalDocReportModel(
        openAmount: 0,
        openAmountDoc: ReportExchangeModel(khr: 0, usd: 0, thb: 0),
        receiveAmount: 0,
        receiveAmountDoc: ReportExchangeModel(khr: 0, usd: 0, thb: 0),
        feeAmount: 0,
        feeAmountDoc: ReportExchangeModel(khr: 0, usd: 0, thb: 0),
        remainingAmount: 0,
        remainingAmountDoc: ReportExchangeModel(khr: 0, usd: 0, thb: 0),
      ),
    );
  }

  Future<List<OptionModel>> initFilters({required BuildContext context}) async {
    AppProvider readAppProvider = context.read<AppProvider>();
    _branchId = readAppProvider.selectedBranch!.id;
    List<String> allowDepartmentIds =
        readAppProvider.currentUser?.profile.depIds ?? [];
    List<SelectOptionModel> departments = await ReportService.getDepartments(
        branchId: branchId, allowDepartmentIds: allowDepartmentIds);
    _filters = [
      OptionModel(
          label: SaleReceiptReportFilterType.customers.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label: SaleReceiptReportFilterType.employees.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label: SaleReceiptReportFilterType.departments.toTitle,
          value: [
            readAppProvider.selectedDepartment != null
                ? readAppProvider.selectedDepartment!.name
                : departments[0].label
          ]),
      OptionModel(
          label: SaleReceiptReportFilterType.paymentBy.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label: SaleReceiptReportFilterType.status.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
    ];
    return _filters;
  }

  void setFilter({required int index, required dynamic newFilter}) {
    if (newFilter.isEmpty) {
      newFilter = ['$_prefixFormBuilderInputDecoration.selectAll'.tr()];
    }
    _filters[index] =
        OptionModel(label: _filters[index].label, value: newFilter);
    notifyListeners();
  }

  String getInvoiceText(
      {required SaleReceiptDataReportModel saleReceiptData,
      required BuildContext context}) {
    String result = saleReceiptData.refNo;
    if (SaleService.isModuleActive(
        modules: ['order-number'], overpower: false, context: context)) {
      result += '-${saleReceiptData.orderNum}';
    }
    return result;
  }

  Future<ResponseModel?> submit({required Map<String, dynamic> formDoc}) async {
    ResponseModel? result;
    try {
      final data = await meteor.call('rest.saleReceiptReport', args: [formDoc]);
      if (data.isNotEmpty) {
        _saleReceiptReportResult = SaleReceiptReportModel.fromJson(data);
        result = const ResponseModel(
            message: 'ok', type: AWESOMESNACKBARTYPE.success);
      }
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            message: e.message!, type: AWESOMESNACKBARTYPE.failure);
      }
    }
    notifyListeners();
    return result;
  }
}
