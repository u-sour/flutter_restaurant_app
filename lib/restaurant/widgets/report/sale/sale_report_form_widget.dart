import 'package:dart_date/dart_date.dart';
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
import '../../../providers/reports/sale_report_provider.dart';
import '../../../services/report_service.dart';
import '../../../../widgets/empty_data_widget.dart';
import '../../../../widgets/loading_widget.dart';

class SaleReportFormWidget extends StatefulWidget {
  final GlobalKey<FormBuilderState> fbKey;
  const SaleReportFormWidget({super.key, required this.fbKey});

  @override
  State<SaleReportFormWidget> createState() => _SaleReportFormWidgetState();
}

class _SaleReportFormWidgetState extends State<SaleReportFormWidget> {
  final String prefixSaleReportForm =
      'screens.reports.customer.children.sale.form';
  final prefixFormBuilderInputDecoration = 'screens.formBuilderInputDecoration';
  late SaleReportProvider readSaleReportProvider;
  late AppProvider readAppProvider;
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbDepartmentKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbCustomerKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbEmployeeKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbStatusKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  late Future<List<SelectOptionModel>> _departmentOptions;
  late Future<List<SelectOptionModel>> _customerOptions;
  late Future<List<SelectOptionModel>> _employeeOptions;
  late String _branchId;
  late List<String> _allowDepartmentIds;

  @override
  void initState() {
    super.initState();
    readSaleReportProvider = context.read<SaleReportProvider>();
    readAppProvider = context.read<AppProvider>();
    _branchId = readAppProvider.selectedBranch!.id;
    _allowDepartmentIds = readAppProvider.currentUser?.profile.depIds ?? [];
    _departmentOptions = ReportService.getDepartments(
        branchId: _branchId, allowDepartmentIds: _allowDepartmentIds);
    _customerOptions = ReportService.getCustomers(branchId: _branchId);
    _employeeOptions = ReportService.getEmployees(branchId: _branchId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormBuilder(
      key: widget.fbKey,
      child: FutureBuilder(
          future: Future.wait(
              [_departmentOptions, _customerOptions, _employeeOptions]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              return Text('$error');
            } else if (snapshot.hasData) {
              final List<SelectOptionModel> departmentOptions =
                  snapshot.data?[0] ?? [];
              List<SelectOptionModel> initDepartment = [
                departmentOptions.first
              ];
              if (readAppProvider.selectedDepartment != null) {
                initDepartment = [
                  SelectOptionModel(
                      label: readAppProvider.selectedDepartment!.name,
                      value: readAppProvider.selectedDepartment!.id)
                ];
              }
              final List<SelectOptionModel> customerOptions =
                  snapshot.data?[1] ?? [];
              final List<SelectOptionModel> employeeOptions =
                  snapshot.data?[2] ?? [];
              return DynamicHeightGridView(
                itemCount: 8,
                crossAxisCount: ResponsiveLayout.isMobile(context) ? 1 : 2,
                shrinkWrap: true,
                builder: (context, index) {
                  late Widget widget;
                  switch (index) {
                    case 0:
                      widget = FormBuilderDateTimePicker(
                        name: 'startDate',
                        initialValue: DateTime.now().startOfDay,
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2100),
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReportForm.startDate',
                            require: true,
                            theme: theme),
                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<ReportTemplateProvider>()
                                .setReportPeriodByDateTimePicker(
                                    startDate: value);
                          }
                        },
                      );
                      break;
                    case 1:
                      widget = FormBuilderDateTimePicker(
                        name: 'endDate',
                        initialValue: DateTime.now().endOfDay,
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2100),
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReportForm.endDate',
                            require: true,
                            theme: theme),
                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<ReportTemplateProvider>()
                                .setReportPeriodByDateTimePicker(
                                    endDate: value);
                          }
                        },
                      );
                      break;
                    case 2:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbDepartmentKey,
                        name: 'depId',
                        initialValue: initDepartment,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReportForm.departments',
                            require: true,
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: departmentOptions,
                        selectedItem: (value) {
                          readSaleReportProvider.setFilter(
                              index: 3,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 3:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbCustomerKey,
                        name: 'guestId',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReportForm.customers',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: customerOptions,
                        selectedItem: (value) {
                          readSaleReportProvider.setFilter(
                              index: 1,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 4:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbEmployeeKey,
                        name: 'employeeId',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReportForm.employees',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: employeeOptions,
                        selectedItem: (value) {
                          readSaleReportProvider.setFilter(
                              index: 2,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 5:
                      widget = FormBuilderSwitch(
                        name: 'isSummary',
                        initialValue: false,
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReportForm.summary',
                            theme: theme),
                        title: const Text(''),
                        onChanged: (value) =>
                            readSaleReportProvider.setIsSummary(value: value!),
                      );

                      break;
                    case 6:
                      widget = Selector<SaleReportProvider, bool>(
                          selector: (context, state) => state.isSummary,
                          builder: (context, isSummary, child) => Visibility(
                                visible: !isSummary,
                                maintainState: true,
                                child: FormBuilderSearchableDropdown<
                                        SelectOptionModel>(
                                    name: 'groupBy',
                                    initialValue:
                                        ReportService.groupByOptions.first,
                                    onChanged: (value) {
                                      if (value != null) {
                                        readSaleReportProvider.setFilter(
                                            index: 0, newFilter: value.label);
                                      }
                                    },
                                    decoration: CustomFormBuilderInputStyle
                                        .fbInputStyle(
                                            labelText:
                                                '$prefixSaleReportForm.groupBy.title',
                                            theme: theme),
                                    popupProps: PopupProps.dialog(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                                AppDefaultIcons.search),
                                            hintText:
                                                'screens.sale.search'.tr(),
                                            isDense: true),
                                      ),
                                      loadingBuilder: (context, searchEntry) =>
                                          const LoadingWidget(),
                                      emptyBuilder: (context, searchEntry) =>
                                          const Center(
                                              child: EmptyDataWidget()),
                                    ),
                                    compareFn: (SelectOptionModel i,
                                            SelectOptionModel s) =>
                                        i.value == s.value,
                                    valueTransformer:
                                        (SelectOptionModel? item) {
                                      if (item != null) {
                                        return item.value;
                                      }
                                    },
                                    itemAsString: ((SelectOptionModel? item) {
                                      return item!.label;
                                    }),
                                    items: ReportService.groupByOptions),
                              ));
                      break;
                    default:
                      widget = Selector<SaleReportProvider, bool>(
                          selector: (context, state) => state.isSummary,
                          builder: (context, isSummary, child) => Visibility(
                                visible: !isSummary,
                                maintainState: true,
                                child: FormBuilderSearchableDropdownMultiSelect(
                                  fbKey: fbStatusKey,
                                  name: 'status',
                                  initialValue: [
                                    ReportService.statusOptions[1],
                                    ReportService.statusOptions[2]
                                  ],
                                  hintText:
                                      '$prefixFormBuilderInputDecoration.selectAll',
                                  decoration:
                                      CustomFormBuilderInputStyle.fbInputStyle(
                                          labelText:
                                              '$prefixSaleReportForm.status.title',
                                          theme: theme),
                                  searchFieldPropsDecoration:
                                      CustomFormBuilderInputStyle
                                          .fbSearchInputStyle(),
                                  items: ReportService.statusOptions,
                                  selectedItem: (value) {
                                    readSaleReportProvider.setFilter(
                                        index: 4,
                                        newFilter:
                                            value.map((o) => o.label).toList());
                                  },
                                ),
                              ));
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
