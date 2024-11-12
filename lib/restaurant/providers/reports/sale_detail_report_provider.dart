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
import '../../models/reports/sale-detail/sale_detail_data_detail_report_model.dart';
import '../../models/reports/sale-detail/sale_detail_report_model.dart';
import '../../services/report_service.dart';
import '../../utils/report/sale_detail_report_utils.dart';

class SaleDetailReportProvider extends ChangeNotifier {
  final String _prefixFormBuilderInputDecoration =
      'screens.formBuilderInputDecoration';
  late String _branchId;
  String get branchId => _branchId;
  List<OptionModel> _filters = [];
  List<OptionModel> get filters => _filters;
  late SaleDetailReportModel _saleDetailReportResult;
  SaleDetailReportModel get saleDetailReportResult => _saleDetailReportResult;
  late String _groupBy;
  String get groupBy => _groupBy;

  void initData() {
    _saleDetailReportResult = SaleDetailReportModel(
        data: [],
        qty: 0,
        discountAmount: 0,
        amount: 0,
        totalDoc: ReportExchangeModel(khr: 0, usd: 0, thb: 0));
    _groupBy = '';
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
          label: SaleDetailReportFilterType.groupBy.toTitle, value: 'Default'),
      OptionModel(
          label: SaleDetailReportFilterType.departments.toTitle,
          value: [departments[0].label]),
      OptionModel(
          label: SaleDetailReportFilterType.employees.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label: SaleDetailReportFilterType.categories.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label: SaleDetailReportFilterType.groups.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label: SaleDetailReportFilterType.products.toTitle,
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
      {required SaleDetailDataDetailReportModel saleDetailDataDetail,
      required BuildContext context}) {
    String result =
        '${saleDetailDataDetail.floorName}-${saleDetailDataDetail.tableName}: ${saleDetailDataDetail.refNo}';
    return result;
  }

  Future<ResponseModel?> submit({required Map<String, dynamic> formDoc}) async {
    ResponseModel? result;
    try {
      final data = await meteor.call('rest.saleDetailReport', args: [formDoc]);
      if (data.isNotEmpty) {
        _groupBy = formDoc['groupBy'] ?? '';
        _saleDetailReportResult = SaleDetailReportModel.fromJson(data);
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
