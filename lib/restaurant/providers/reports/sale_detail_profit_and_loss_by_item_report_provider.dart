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
import '../../models/reports/profit-and-loss-by-item/sale_detail_profit_and_loss_by_item_report_model.dart';
import '../../models/reports/report_exchange_model.dart';
import '../../services/report_service.dart';
import '../../utils/report/sale_detail_profit_and_loss_by_item_report_utils.dart';

class SaleDetailProfitAndLossByItemReportProvider extends ChangeNotifier {
  final String _prefixFormBuilderInputDecoration =
      'screens.formBuilderInputDecoration';
  late String _branchId;
  String get branchId => _branchId;
  List<OptionModel> _filters = [];
  List<OptionModel> get filters => _filters;
  late SaleDetailProfitAndLossByItemReportModel
      _sdProfitAndLossByItemReportResult;
  SaleDetailProfitAndLossByItemReportModel
      get sdProfitAndLossByItemReportResult =>
          _sdProfitAndLossByItemReportResult;
  void initData() {
    _sdProfitAndLossByItemReportResult =
        const SaleDetailProfitAndLossByItemReportModel(
            data: [],
            totalQty: 0,
            totalCost: 0,
            totalPrice: 0,
            totalDiscountAmount: 0,
            totalProfit: 0,
            totalProfitDoc: ReportExchangeModel(khr: 0, usd: 0, thb: 0));
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
          label:
              SaleDetailProfitAndLossByItemReportFilterType.categories.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label:
              SaleDetailProfitAndLossByItemReportFilterType.employees.toTitle,
          value: ['$_prefixFormBuilderInputDecoration.selectAll'.tr()]),
      OptionModel(
          label:
              SaleDetailProfitAndLossByItemReportFilterType.departments.toTitle,
          value: [departments[0].label]),
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

  Future<ResponseModel?> submit({required Map<String, dynamic> formDoc}) async {
    ResponseModel? result;
    try {
      final data = await meteor.call('rest.findProfitAndLoss', args: [formDoc]);
      if (data.isNotEmpty) {
        _sdProfitAndLossByItemReportResult =
            SaleDetailProfitAndLossByItemReportModel.fromJson(data);
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
