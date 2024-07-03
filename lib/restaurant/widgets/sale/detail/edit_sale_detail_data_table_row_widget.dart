import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../form_builder_touch_spin.dart';

class EditSaleDetailDataTableRowWidget extends StatelessWidget {
  final GlobalKey<FormBuilderState> fbEditRowKey;
  final SaleDetailDTRowType rowType;
  final int index;
  final SaleDetailModel item;

  const EditSaleDetailDataTableRowWidget(
      {super.key,
      required this.fbEditRowKey,
      required this.rowType,
      required this.index,
      required this.item});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: const EdgeInsets.only(
            left: AppStyleDefaultProperties.p,
            top: AppStyleDefaultProperties.p,
            right: AppStyleDefaultProperties.p),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(rowType.toTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold))
                .tr(),
            IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(AppDefaultIcons.close))
          ],
        ),
        content: SizedBox(
          width: double.minPositive,
          child: FormBuilder(
            key: fbEditRowKey,
            child: EditSaleDetailDataTableRow(
              rowType: rowType,
              index: index,
              item: item,
            ),
          ),
        ));
  }
}

class EditSaleDetailDataTableRow extends StatefulWidget {
  final SaleDetailDTRowType rowType;
  final int index;
  final SaleDetailModel item;

  const EditSaleDetailDataTableRow(
      {super.key,
      required this.rowType,
      required this.index,
      required this.item});

  @override
  State<EditSaleDetailDataTableRow> createState() =>
      _EditSaleDetailDataTableRowState();
}

class _EditSaleDetailDataTableRowState
    extends State<EditSaleDetailDataTableRow> {
  TextEditingController qtyController = TextEditingController();
  TextEditingController returnQtyController = TextEditingController();
  // TextEditingController priceController = TextEditingController();
  // TextEditingController disRateController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    qtyController.dispose();
    returnQtyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.rowType.name == 'price')
            FormBuilderTextField(
              name: 'price',
              // controller: priceController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // decoration: fbTextFieldStyle(label: 'Price', theme: theme),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              ],
              onChanged: (String? price) {
                // readProvider.saleOrderDetailRowChange(
                //     index: widget.index,
                //     onChangeValue: price,
                //     item: widget.item,
                //     type: 'price');
              },
            ),
          if (widget.rowType.name == 'discountRate')
            FormBuilderTextField(
              name: 'discountRate',
              // controller: priceController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // decoration: fbTextFieldStyle(label: 'Price', theme: theme),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              ],
              onChanged: (String? discountRate) {
                // readProvider.saleOrderDetailRowChange(
                //     index: widget.index,
                //     onChangeValue: price,
                //     item: widget.item,
                //     type: 'price');
              },
            ),
          if (widget.rowType.name == 'note')
            FormBuilderTextField(
              name: 'note',
              initialValue: widget.item.note,
              // decoration: fbTextFieldStyle(label: 'Memo', theme: theme),
              onChanged: (String? note) {
                // readProvider.saleOrderDetailRowChange(
                //     index: widget.index,
                //     onChangeValue: memo,
                //     item: widget.item,
                //     type: 'memo');
              },
              onTap: () {
                final FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
            ),
          if (widget.rowType.name == 'qty')
            FormBuilderTouchSpin(
              name: 'qty',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // decoration: fbTextFieldStyle(label: 'qty', theme: theme),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              ],
              minValue: 1,
              controller: qtyController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onTap: () {
                qtyController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: qtyController.value.text.length);
              },
              onChanged: (qty) {
                // readProvider.saleOrderDetailRowChange(
                //     index: widget.index,
                //     onChangeValue: '$qty',
                //     item: widget.item,
                //     type: 'qty');
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.min(1),
                FormBuilderValidators.required(),
              ]),
            ),
          if (widget.rowType.name == 'returnQty')
            FormBuilderTouchSpin(
              name: 'returnQty',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // decoration: fbTextFieldStyle(label: 'qty', theme: theme),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              ],
              minValue: 1,
              controller: returnQtyController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onTap: () {
                returnQtyController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: returnQtyController.value.text.length);
              },
              onChanged: (returnQty) {
                // readProvider.saleOrderDetailRowChange(
                //     index: widget.index,
                //     onChangeValue: '$qty',
                //     item: widget.item,
                //     type: 'qty');
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.min(1),
                FormBuilderValidators.required(),
              ]),
            ),
        ],
      ),
    );
  }
}
