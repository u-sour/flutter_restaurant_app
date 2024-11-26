import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/custom-form-builder/form_builder_custom_touch_spin.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../services/sale_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../dialog_widget.dart';

class EditSaleDetailDataTableRowWidget extends StatelessWidget {
  final GlobalKey<FormBuilderState> fbEditRowKey;
  final IconData titleIcon;
  final SaleDetailDTRowType rowType;
  final SaleDetailModel item;
  final String insertLabel;
  final void Function()? onInsertPressed;
  final void Function()? onInsertAndPrintPressed;

  const EditSaleDetailDataTableRowWidget({
    super.key,
    required this.fbEditRowKey,
    this.titleIcon = RestaurantDefaultIcons.edit,
    required this.rowType,
    required this.item,
    this.insertLabel = 'dialog.actions.insert',
    this.onInsertPressed,
    this.onInsertAndPrintPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: rowType.toTitle,
      titleIcon: titleIcon,
      content: SizedBox(
        width: double.minPositive,
        child: FormBuilder(
          key: fbEditRowKey,
          child: EditSaleDetailDataTableRow(
            rowType: rowType,
            item: item,
          ),
        ),
      ),
      insertLabel: insertLabel,
      onInsertPressed: onInsertPressed,
      onInsertAndPrintPressed: onInsertAndPrintPressed,
    );
  }
}

class EditSaleDetailDataTableRow extends StatefulWidget {
  final SaleDetailDTRowType rowType;
  final SaleDetailModel item;

  const EditSaleDetailDataTableRow(
      {super.key, required this.rowType, required this.item});

  @override
  State<EditSaleDetailDataTableRow> createState() =>
      _EditSaleDetailDataTableRowState();
}

class _EditSaleDetailDataTableRowState
    extends State<EditSaleDetailDataTableRow> {
  late SaleProvider readProvider;
  TextEditingController priceController = TextEditingController();
  TextEditingController disRateController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController returnQtyController = TextEditingController();
  late bool isDecimalQtyModule;
  RegExp regExpDecimalNumber = RegExp(r"[0-9.]");

  @override
  void initState() {
    readProvider = context.read<SaleProvider>();
    priceController.value = TextEditingValue(text: '${widget.item.price}');
    disRateController.value = TextEditingValue(text: '${widget.item.discount}');
    isDecimalQtyModule =
        SaleService.isModuleActive(modules: ['decimal-qty'], context: context);
    super.initState();
  }

  void selectInputText({required TextEditingController controller}) {
    controller.selection = TextSelection(
        baseOffset: 0, extentOffset: controller.value.text.length);
  }

  @override
  void dispose() {
    super.dispose();
    priceController.dispose();
    disRateController.dispose();
    qtyController.dispose();
    returnQtyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.rowType.name == 'price')
          FormBuilderTextField(
            name: 'price',
            controller: priceController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(regExpDecimalNumber),
            ],
            onChanged: (String? price) {
              if (price != null) {
                readProvider.handleItemUpdate(
                    onChangedValue: price,
                    item: widget.item,
                    rowType: SaleDetailDTRowType.price);
              }
            },
            onTap: () => selectInputText(controller: priceController),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.min(0),
            ]),
          ),
        if (widget.rowType.name == 'discountRate')
          FormBuilderTextField(
            name: 'discountRate',
            controller: disRateController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(regExpDecimalNumber),
            ],
            onChanged: (String? discountRate) {
              if (discountRate != null) {
                readProvider.handleItemUpdate(
                    onChangedValue: discountRate,
                    item: widget.item,
                    rowType: SaleDetailDTRowType.discountRate);
              }
            },
            onTap: () => selectInputText(controller: disRateController),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.min(0),
              FormBuilderValidators.max(100),
            ]),
          ),
        if (widget.rowType.name == 'note')
          FormBuilderTextField(
            name: 'note',
            initialValue: widget.item.note,
            maxLines: 3,
            onChanged: (String? note) {
              if (note != null) {
                readProvider.handleItemUpdate(
                    onChangedValue: note,
                    item: widget.item,
                    rowType: SaleDetailDTRowType.note);
              }
            },
            onTap: () {
              final FocusScopeNode currentScope = FocusScope.of(context);
              if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
          ),
        if (widget.rowType.name == 'qty')
          FormBuilderCustomTouchSpin(
            name: 'qty',
            initialValue: widget.item.totalQty,
            minValue: widget.item.returnQty.toInt(),
            controller: qtyController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              isDecimalQtyModule
                  ? FilteringTextInputFormatter.allow(regExpDecimalNumber)
                  : FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: isDecimalQtyModule
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.number,
            onTap: () => selectInputText(controller: qtyController),
            onChanged: (qty) {
              readProvider.handleItemUpdate(
                  onChangedValue: '$qty',
                  item: widget.item,
                  rowType: SaleDetailDTRowType.qty);
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.min(0),
            ]),
          ),
        if (widget.rowType.name == 'returnQty')
          FormBuilderCustomTouchSpin(
            name: 'returnQty',
            initialValue: widget.item.returnQty,
            maxValue: widget.item.totalQty.toInt(),
            controller: returnQtyController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              isDecimalQtyModule
                  ? FilteringTextInputFormatter.allow(regExpDecimalNumber)
                  : FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: isDecimalQtyModule
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.number,
            onTap: () => selectInputText(controller: returnQtyController),
            onChanged: (returnQty) {
              readProvider.handleItemUpdate(
                  onChangedValue: '$returnQty',
                  item: widget.item,
                  rowType: SaleDetailDTRowType.returnQty);
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.min(0),
            ]),
          ),
      ],
    );
  }
}
