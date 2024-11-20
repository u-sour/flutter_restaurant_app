import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../providers/app_provider.dart';
import '../../../../utils/custom_form_builder_input_style.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../../widgets/custom-form-builder/form_builder_dropdown_multiselect.dart';
import '../../../providers/report-template/report_template_provider.dart';
import '../../../providers/reports/sale_detail_profit_and_loss_by_item_report_provider.dart';
import '../../../services/report_service.dart';
import '../../../../widgets/loading_widget.dart';

class SaleDetailProfitAndLossByItemReportFormWidget extends StatefulWidget {
  final GlobalKey<FormBuilderState> fbKey;
  const SaleDetailProfitAndLossByItemReportFormWidget(
      {super.key, required this.fbKey});

  @override
  State<SaleDetailProfitAndLossByItemReportFormWidget> createState() =>
      _SaleDetailProfitAndLossByItemReportFormWidgetState();
}

class _SaleDetailProfitAndLossByItemReportFormWidgetState
    extends State<SaleDetailProfitAndLossByItemReportFormWidget> {
  final String prefixSaleDetailProfitAndLossByItemReportForm =
      'screens.reports.customer.children.profitAndLossByItem.form';
  final prefixFormBuilderInputDecoration = 'screens.formBuilderInputDecoration';
  late SaleDetailProfitAndLossByItemReportProvider
      readSaleDetailProfitAndLossByItemReportProvider;
  late AppProvider readAppProvider;
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbDepartmentKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbCategoryKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbEmployeeKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbProductKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();

  late Future<List<SelectOptionModel>> _departmentOptions;
  late Future<List<SelectOptionModel>> _categoryOptions;
  late Future<List<SelectOptionModel>> _employeeOptions;
  late String _branchId;
  late List<String> _allowDepartmentIds;

  @override
  void initState() {
    super.initState();
    readSaleDetailProfitAndLossByItemReportProvider =
        context.read<SaleDetailProfitAndLossByItemReportProvider>();
    readAppProvider = context.read<AppProvider>();
    _branchId = readAppProvider.selectedBranch!.id;
    _allowDepartmentIds = readAppProvider.currentUser?.profile.depIds ?? [];
    _departmentOptions = ReportService.getDepartments(
        branchId: _branchId, allowDepartmentIds: _allowDepartmentIds);
    _categoryOptions = ReportService.getCategories(branchId: _branchId);
    _employeeOptions = ReportService.getEmployees(branchId: _branchId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormBuilder(
      key: widget.fbKey,
      child: FutureBuilder(
          future: Future.wait(
              [_departmentOptions, _categoryOptions, _employeeOptions]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              return Text('$error');
            } else if (snapshot.hasData) {
              final List<SelectOptionModel> departmentOptions =
                  snapshot.data?[0] ?? [];
              final List<SelectOptionModel> categoryOptions =
                  snapshot.data?[1] ?? [];
              final List<SelectOptionModel> employeeOptions =
                  snapshot.data?[2] ?? [];
              return DynamicHeightGridView(
                itemCount: 5,
                crossAxisCount: ResponsiveLayout.isMobile(context) ? 1 : 2,
                shrinkWrap: true,
                builder: (context, index) {
                  late Widget widget;
                  switch (index) {
                    case 0:
                      widget = FormBuilderDateRangePicker(
                        name: 'reportPeriod',
                        initialValue: DateTimeRange(
                            start: DateTime.now(), end: DateTime.now()),
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2100),
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText:
                                '$prefixSaleDetailProfitAndLossByItemReportForm.reportPeriod',
                            require: true,
                            theme: theme),
                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<ReportTemplateProvider>()
                                .setReportPeriod(reportPeriodDateRange: value);
                          }
                        },
                      );
                      break;
                    case 1:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbDepartmentKey,
                        name: 'depId',
                        initialValue: [departmentOptions.first],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText:
                                '$prefixSaleDetailProfitAndLossByItemReportForm.departments',
                            require: true,
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: departmentOptions,
                        selectedItem: (value) {
                          readSaleDetailProfitAndLossByItemReportProvider
                              .setFilter(
                                  index: 2,
                                  newFilter:
                                      value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 2:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbCategoryKey,
                        name: 'categoryIds',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText:
                                '$prefixSaleDetailProfitAndLossByItemReportForm.categories',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: categoryOptions,
                        selectedItem: (value) {
                          readSaleDetailProfitAndLossByItemReportProvider
                              .setFilter(
                                  index: 0,
                                  newFilter:
                                      value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 3:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbEmployeeKey,
                        name: 'employeeId',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText:
                                '$prefixSaleDetailProfitAndLossByItemReportForm.employees',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: employeeOptions,
                        selectedItem: (value) {
                          readSaleDetailProfitAndLossByItemReportProvider
                              .setFilter(
                                  index: 1,
                                  newFilter:
                                      value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    default:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbProductKey,
                        name: 'productIds',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText:
                                '$prefixSaleDetailProfitAndLossByItemReportForm.products',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        onFind: (String search) {
                          return ReportService.getProducts(
                              branchId: _branchId, search: search);
                        },
                        selectedItem: (value) {
                          // readSaleDetailProfitAndLossByItemReportProvider
                          //     .setFilter(
                          //         index: 5,
                          //         newFilter:
                          //             value.map((o) => o.label).toList());
                        },
                      );
                  }
                  return widget;
                },
              );
            } else {
              return const LoadingWidget();
            }
          }),
    );
  }
}
