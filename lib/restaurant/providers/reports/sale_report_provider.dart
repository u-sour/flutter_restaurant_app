import 'package:dart_meteor/dart_meteor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../models/servers/response_model.dart';
import '../../../providers/app_provider.dart';
import '../../../utils/alert/awesome_snack_bar_utils.dart';
import '../../../widgets/screens/app_screen.dart';
import '../../models/option/option_model.dart';
import '../../models/reports/report_exchange_model.dart';
import '../../models/reports/sale/sale_data_detail_report_model.dart';
import '../../models/reports/sale/sale_report_model.dart';
import '../../models/reports/sale/sale_summary_report_model.dart';
import '../../services/report_service.dart';
import '../../services/sale_service.dart';
import '../../utils/report/sale_report_utils.dart';

class SaleReportProvider extends ChangeNotifier {
  final String _prefixFormBuilderInputDecoration =
      'screens.formBuilderInputDecoration';
  late String _branchId;
  String get branchId => _branchId;
  List<OptionModel> _filters = [];
  List<OptionModel> get filters => _filters;
  late SaleReportModel _saleReportResult;
  SaleReportModel get saleReportResult => _saleReportResult;
  late List<SaleSummaryReportModel> _saleSummaryReportResult;
  List<SaleSummaryReportModel> get saleSummaryReportResult =>
      _saleSummaryReportResult;
  late String _groupBy;
  String get groupBy => _groupBy;
  late bool _isSummary;
  bool get isSummary => _isSummary;

  void initData() {
    _saleReportResult = SaleReportModel(
        data: [],
        grandSubTotal: 0,
        grandDiscount: 0,
        grandTotal: 0,
        grandTotalDoc: ReportExchangeModel(khr: 0, usd: 0, thb: 0));
    _groupBy = ReportService.groupByOptions.first.value;
    _saleSummaryReportResult = [];
    _isSummary = false;
  }

  void setIsSummary({required bool value}) {
    _isSummary = value;
    notifyListeners();
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
          label: SaleReportFilterType.groupBy.toTitle,
          value: ReportService.groupByOptions.first.label),
      OptionModel(
          label: SaleReportFilterType.customers.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label: SaleReportFilterType.employees.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label: SaleReportFilterType.departments.toTitle,
          value: [departments[0].label]),
      OptionModel(label: SaleReportFilterType.status.toTitle, value: [
        ReportService.statusOptions[1].label,
        ReportService.statusOptions[2].label
      ]),
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

  String getLocationText({required SaleDataDetailReportModel saleDataDetail}) {
    return '${saleDataDetail.floorName} - ${saleDataDetail.tableName}';
  }

  String getInvoiceText(
      {required SaleDataDetailReportModel saleDataDetail,
      required BuildContext context}) {
    String result = saleDataDetail.refNo;
    if (SaleService.isModuleActive(
        modules: ['order-number'], overpower: false, context: context)) {
      result += '-${saleDataDetail.orderNum}';
    }
    return result;
  }

  Future<ResponseModel?> submit({required Map<String, dynamic> formDoc}) async {
    ResponseModel? result;
    try {
      final data = await meteor.call('rest.saleReport', args: [formDoc]);
      if (data.isNotEmpty) {
        if (formDoc['isSummary']) {
          _saleSummaryReportResult = List<dynamic>.from(data)
              .map((json) => SaleSummaryReportModel.fromJson(json))
              .toList();
        } else {
          _groupBy = formDoc['groupBy'];
          _saleReportResult = SaleReportModel.fromJson(data);
        }
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
