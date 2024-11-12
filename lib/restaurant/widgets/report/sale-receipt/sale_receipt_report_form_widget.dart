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
import '../../../providers/reports/sale_receipt_report_provider.dart';
import '../../../services/report_service.dart';
import '../../../../widgets/empty_data_widget.dart';
import '../../../../widgets/loading_widget.dart';

class SaleReceiptReportFormWidget extends StatefulWidget {
  final GlobalKey<FormBuilderState> fbKey;
  const SaleReceiptReportFormWidget({super.key, required this.fbKey});

  @override
  State<SaleReceiptReportFormWidget> createState() =>
      _SaleReceiptReportFormWidgetState();
}

class _SaleReceiptReportFormWidgetState
    extends State<SaleReceiptReportFormWidget> {
  final String prefixSaleReceiptReportForm =
      'screens.reports.customer.children.saleReceipt.form';
  final prefixFormBuilderInputDecoration = 'screens.formBuilderInputDecoration';
  late SaleReceiptReportProvider readSaleReceiptReportProvider;
  late AppProvider readAppProvider;
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbCustomerKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbEmployeeKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbDepartmentKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbPaymentByKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbStatusKey =
      GlobalKey<DropdownSearchState<SelectOptionModel>>();
  late Future<List<SelectOptionModel>> _customerOptions;
  late Future<List<SelectOptionModel>> _employeeOptions;
  late Future<List<SelectOptionModel>> _departmentOptions;
  late Future<List<SelectOptionModel>> _paymentByOptions;
  late String _branchId;
  late List<String> _allowDepartmentIds;

  @override
  void initState() {
    super.initState();
    readSaleReceiptReportProvider = context.read<SaleReceiptReportProvider>();
    readAppProvider = context.read<AppProvider>();
    _branchId = readAppProvider.selectedBranch!.id;
    _allowDepartmentIds = readAppProvider.currentUser?.profile.depIds ?? [];
    _customerOptions = ReportService.getCustomers(branchId: _branchId);
    _employeeOptions = ReportService.getEmployees(branchId: _branchId);
    _departmentOptions = ReportService.getDepartments(
        branchId: _branchId, allowDepartmentIds: _allowDepartmentIds);
    _paymentByOptions = ReportService.getPaymentMethods(branchId: _branchId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormBuilder(
      key: widget.fbKey,
      child: FutureBuilder(
          future: Future.wait([
            _customerOptions,
            _employeeOptions,
            _departmentOptions,
            _paymentByOptions,
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              final error = snapshot.error;
              return Text('$error');
            } else if (snapshot.hasData) {
              final List<SelectOptionModel> customerOptions =
                  snapshot.data?[0] ?? [];
              final List<SelectOptionModel> employeeOptions =
                  snapshot.data?[1] ?? [];
              final List<SelectOptionModel> departmentOptions =
                  snapshot.data?[2] ?? [];
              final List<SelectOptionModel> paymentByOptions =
                  snapshot.data?[3] ?? [];
              return DynamicHeightGridView(
                itemCount: 7,
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
                                '$prefixSaleReceiptReportForm.reportPeriod',
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
                        fbKey: fbCustomerKey,
                        name: 'guestId',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReceiptReportForm.customers',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: customerOptions,
                        selectedItem: (value) {
                          readSaleReceiptReportProvider.setFilter(
                              index: 0,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 2:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbEmployeeKey,
                        name: 'employeeId',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReceiptReportForm.employees',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: employeeOptions,
                        selectedItem: (value) {
                          readSaleReceiptReportProvider.setFilter(
                              index: 1,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 3:
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
                                '$prefixSaleReceiptReportForm.departments',
                            require: true,
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: departmentOptions,
                        selectedItem: (value) {
                          readSaleReceiptReportProvider.setFilter(
                              index: 2,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 4:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbPaymentByKey,
                        name: 'paymentBy',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReceiptReportForm.paymentBy',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: paymentByOptions,
                        selectedItem: (value) {
                          readSaleReceiptReportProvider.setFilter(
                              index: 3,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    case 5:
                      widget = FormBuilderSearchableDropdownMultiSelect(
                        fbKey: fbStatusKey,
                        name: 'status',
                        hintText: '$prefixFormBuilderInputDecoration.selectAll',
                        decoration: CustomFormBuilderInputStyle.fbInputStyle(
                            labelText: '$prefixSaleReceiptReportForm.status',
                            theme: theme),
                        searchFieldPropsDecoration:
                            CustomFormBuilderInputStyle.fbSearchInputStyle(),
                        items: ReportService.statusOptions,
                        selectedItem: (value) {
                          readSaleReceiptReportProvider.setFilter(
                              index: 4,
                              newFilter: value.map((o) => o.label).toList());
                        },
                      );
                      break;
                    default:
                      widget = FormBuilderSearchableDropdown<SelectOptionModel>(
                          name: 'orderBy',
                          initialValue: ReportService.orderByOptions.first,
                          decoration: CustomFormBuilderInputStyle.fbInputStyle(
                              labelText:
                                  '$prefixSaleReceiptReportForm.orderBy.title',
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
                          items: ReportService.orderByOptions);
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
