import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../providers/app_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/custom_form_builder_input_style.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../../widgets/custom-form-builder/form_builder_dropdown_multiselect.dart';
import '../../../providers/report-template/report_template_provider.dart';
import '../../../providers/reports/sale_detail_report_provider.dart';
import '../../../services/report_service.dart';
import '../../../../widgets/empty_data_widget.dart';
import '../../../../widgets/loading_widget.dart';

class SaleDetailReportFormWidget extends StatefulWidget {
  final GlobalKey<FormBuilderState> fbKey;
  const SaleDetailReportFormWidget({super.key, required this.fbKey});

  @override
  State<SaleDetailReportFormWidget> createState() =>
      _SaleDetailReportFormWidgetState();
}

class _SaleDetailReportFormWidgetState
    extends State<SaleDetailReportFormWidget> {
  final String prefixSaleDetailReportForm =
      'screens.reports.customer.children.saleDetail.form';
  final prefixFormBuilderInputDecoration = 'screens.formBuilderInputDecoration';
  late SaleDetailReportProvider readSaleDetailReportProvider;
  late AppProvider readAppProvider;
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbEmployeeKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbCategoryKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbGroupKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbProductKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbDepartmentKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();

  late Future<List<SelectOptionModel>> _employeeOptions;
  late Future<List<SelectOptionModel>> _categoryOptions;
  late Future<List<SelectOptionModel>> _groupOptions;
  late Future<List<SelectOptionModel>> _departmentOptions;
  late String _branchId;
  late List<String> _allowDepartmentIds;

  @override
  void initState() {
    super.initState();
    readSaleDetailReportProvider = context.read<SaleDetailReportProvider>();
    readAppProvider = context.read<AppProvider>();
    _branchId = readAppProvider.selectedBranch!.id;
    _allowDepartmentIds = readAppProvider.currentUser?.profile.depIds ?? [];
    _employeeOptions = ReportService.getEmployees(branchId: _branchId);
    _categoryOptions = ReportService.getCategories(branchId: _branchId);
    _groupOptions = ReportService.getGroups(branchId: _branchId);
    _departmentOptions = ReportService.getDepartments(
        branchId: _branchId, allowDepartmentIds: _allowDepartmentIds);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormBuilder(
      key: widget.fbKey,
      child: FutureBuilder(
          future: Future.wait([
            _employeeOptions,
            _categoryOptions,
            _groupOptions,
            _departmentOptions
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              return Text('$error');
            } else if (snapshot.hasData) {
              final List<SelectOptionModel> employeeOptions =
                  snapshot.data?[0] ?? [];
              final List<SelectOptionModel> categoryOptions =
                  snapshot.data?[1] ?? [];
              final List<SelectOptionModel> groupOptions =
                  snapshot.data?[2] ?? [];
              final List<SelectOptionModel> departmentOptions =
                  snapshot.data?[3] ?? [];
              return DynamicHeightGridView(
                itemCount: 8,
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
                                '$prefixSaleDetailReportForm.reportPeriod',
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
                        fbKey: fbEmployeeKey,
                        name: 'employeeId',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleDetailReportForm.employees',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: employeeOptions,
                        selectedItem: (value) {
                          readSaleDetailReportProvider.setFilter(
                              index: 2,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );

                      break;
                    case 2:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbCategoryKey,
                        name: 'categoryIds',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleDetailReportForm.categories',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: categoryOptions,
                        selectedItem: (value) {
                          readSaleDetailReportProvider.setFilter(
                              index: 3,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 3:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbGroupKey,
                        name: 'groupIds',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleDetailReportForm.groups',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: groupOptions,
                        selectedItem: (value) {
                          readSaleDetailReportProvider.setFilter(
                              index: 4,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 4:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbProductKey,
                        name: 'productIds',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleDetailReportForm.products',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        onFind: (String search) {
                          return ReportService.getProducts(
                              branchId: _branchId, search: search);
                        },
                        selectedItem: (value) {
                          readSaleDetailReportProvider.setFilter(
                              index: 5,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 5:
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
                                '$prefixSaleDetailReportForm.departments',
                            require: true,
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: departmentOptions,
                        selectedItem: (value) {
                          readSaleDetailReportProvider.setFilter(
                              index: 1,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 6:
                      widget = FormBuilderSearchableDropdown<SelectOptionModel>(
                          name: 'groupBy',
                          onChanged: (value) {
                            readSaleDetailReportProvider.setFilter(
                                index: 0,
                                newFilter:
                                    value != null ? value.label : "Default");
                          },
                          decoration: CustomFormBuilderInputStyle.fbInputStyle(
                              labelText:
                                  '$prefixSaleDetailReportForm.groupBy.title',
                              theme: theme),
                          clearButtonProps:
                              const ClearButtonProps(isVisible: true),
                          popupProps: PopupProps.dialog(
                            showSelectedItems: true,
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(AppDefaultIcons.search),
                                  hintText: 'screens.sale.search'.tr(),
                                  isDense: true),
                            ),
                            loadingBuilder: (context, searchEntry) =>
                                const LoadingWidget(),
                            emptyBuilder: (context, searchEntry) =>
                                const Center(child: EmptyDataWidget()),
                          ),
                          compareFn:
                              (SelectOptionModel i, SelectOptionModel s) =>
                                  i.value == s.value,
                          valueTransformer: (SelectOptionModel? item) {
                            if (item != null) {
                              return item.value;
                            }
                          },
                          itemAsString: ((SelectOptionModel? item) {
                            return item!.label;
                          }),
                          items: ReportService.saleDetailGroupByOptions);
                      break;
                    default:
                      widget = FormBuilderSwitch(
                        name: 'discountOnly',
                        initialValue: false,
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText:
                                '$prefixSaleDetailReportForm.discountOnly',
                            theme: theme),
                        title: const Text(''),
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
