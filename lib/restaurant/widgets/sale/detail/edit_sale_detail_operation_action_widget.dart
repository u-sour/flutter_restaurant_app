import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../dialog_widget.dart';
import '../../empty_data_widget.dart';
import '../../loading_widget.dart';
import 'sale_detail_data_table_operations_widget.dart';
import '../../form_builder_custom_touch_spin.dart';

class EditSaleDetailOperationActionWidget extends StatelessWidget {
  final GlobalKey<FormBuilderState> fbKey;
  final IconData titleIcon;
  final SaleDetailOperationType operationType;
  final dynamic value;
  final void Function()? onInsertPressed;
  const EditSaleDetailOperationActionWidget({
    super.key,
    required this.fbKey,
    this.titleIcon = RestaurantDefaultIcons.edit,
    required this.operationType,
    this.value,
    this.onInsertPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: operationType.toTitle,
      titleIcon: titleIcon,
      content: SizedBox(
        width: operationType.name == 'merge' ||
                operationType.name == 'customerCount'
            ? double.minPositive
            : double.maxFinite,
        child: FormBuilder(
          key: fbKey,
          child: EditSaleDetailOperation(
            operationType: operationType,
            value: value,
          ),
        ),
      ),
      onInsertPressed: onInsertPressed,
    );
  }
}

class EditSaleDetailOperation extends StatefulWidget {
  final SaleDetailOperationType operationType;
  final dynamic value;
  const EditSaleDetailOperation(
      {super.key, required this.operationType, this.value});

  @override
  State<EditSaleDetailOperation> createState() =>
      _EditSaleDetailOperationState();
}

class _EditSaleDetailOperationState extends State<EditSaleDetailOperation> {
  final _prefixSDOperationForm = 'screens.sale.detail.operations.form';
  late SaleProvider readProvider;
  Future<List<SelectOptionModel>>? sales;
  Future<List<SelectOptionModel>>? tables;
  TextEditingController customerCountController = TextEditingController();
  int minCustomerCount = 1;
  @override
  void initState() {
    super.initState();
    readProvider = context.read<SaleProvider>();
    if (widget.operationType.name == 'merge' ||
        widget.operationType.name == 'transfer') {
      sales = readProvider.fetchSaleGroupByTable(context: context);
    }

    if (widget.operationType.name == 'split') {
      tables = readProvider.fetchTables();
    }
  }

  void selectInputText({required TextEditingController controller}) {
    controller.selection = TextSelection(
        baseOffset: 0, extentOffset: controller.value.text.length);
  }

  @override
  void dispose() {
    super.dispose();
    customerCountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Invoices
        if (widget.operationType.name == 'merge' ||
            widget.operationType.name == 'transfer')
          FutureBuilder<List<SelectOptionModel>>(
              future: sales,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  final error = snapshot.error;
                  return Text('$error');
                } else if (snapshot.hasData) {
                  return FormBuilderSearchableDropdown<SelectOptionModel>(
                    name: 'saleId',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        labelText: '$_prefixSDOperationForm.saleId'.tr()),
                    popupProps: PopupProps.dialog(
                      showSelectedItems: true,
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                            prefixIcon:
                                const Icon(RestaurantDefaultIcons.search),
                            hintText: 'screens.sale.search'.tr(),
                            isDense: true),
                      ),
                      disabledItemFn: (item) => item.extra == 'table-location',
                      loadingBuilder: (context, searchEntry) =>
                          const LoadingWidget(),
                      emptyBuilder: (context, searchEntry) =>
                          const Center(child: EmptyDataWidget()),
                    ),
                    compareFn: (SelectOptionModel i, SelectOptionModel s) =>
                        i.value == s.value,
                    valueTransformer: (SelectOptionModel? item) {
                      if (item != null) {
                        return item.value;
                      }
                    },
                    itemAsString: ((SelectOptionModel? item) {
                      return item!.label;
                    }),
                    items: snapshot.data!,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  );
                } else {
                  return const LoadingWidget();
                }
              }),
        // Tables
        if (widget.operationType.name == 'split')
          FutureBuilder<List<SelectOptionModel>>(
              future: tables,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  final error = snapshot.error;
                  return Text('$error');
                } else if (snapshot.hasData) {
                  return FormBuilderSearchableDropdown<SelectOptionModel>(
                    name: 'tableId',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        labelText: '$_prefixSDOperationForm.tableId'.tr()),
                    popupProps: PopupProps.dialog(
                      showSelectedItems: true,
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                            prefixIcon:
                                const Icon(RestaurantDefaultIcons.search),
                            hintText: 'screens.sale.search'.tr(),
                            isDense: true),
                      ),
                      disabledItemFn: (item) => item.extra == 'floor',
                      loadingBuilder: (context, searchEntry) =>
                          const LoadingWidget(),
                      emptyBuilder: (context, searchEntry) =>
                          const Center(child: EmptyDataWidget()),
                    ),
                    compareFn: (SelectOptionModel i, SelectOptionModel s) =>
                        i.value == s.value,
                    valueTransformer: (SelectOptionModel? item) {
                      if (item != null) {
                        return item.value;
                      }
                    },
                    itemAsString: ((SelectOptionModel? item) {
                      return item!.label;
                    }),
                    items: snapshot.data!,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  );
                } else {
                  return const LoadingWidget();
                }
              }),
        if (widget.operationType.name == 'transfer' ||
            widget.operationType.name == 'split')
          const Expanded(
            child: SaleDetailDataTableOperationsWidget(),
          ),
        // Customer Count
        if (widget.operationType.name == 'customerCount')
          FormBuilderCustomTouchSpin(
            name: 'numOfGuest',
            initialValue: widget.value,
            controller: customerCountController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            minValue: minCustomerCount,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
            ],
            keyboardType: TextInputType.number,
            onTap: () => selectInputText(controller: customerCountController),
            onChanged: (qty) {},
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.min(minCustomerCount),
            ]),
          ),
      ],
    );
  }
}
