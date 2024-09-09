import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../form_builder_touch_spin.dart';
import '../../icon_with_text_widget.dart';

class EditSaleDetailDataTableRowWidget extends StatelessWidget {
  final GlobalKey<FormBuilderState> fbEditRowKey;
  final IconData titleIcon;
  final SaleDetailDTRowType rowType;
  final SaleDetailModel item;

  const EditSaleDetailDataTableRowWidget(
      {super.key,
      required this.fbEditRowKey,
      this.titleIcon = RestaurantDefaultIcons.edit,
      required this.rowType,
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
            IconWithTextWidget(
              icon: titleIcon,
              text: rowType.toTitle,
            ),
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
              item: item,
            ),
          ),
        ));
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

  @override
  void initState() {
    readProvider = context.read<SaleProvider>();
    priceController.value = TextEditingValue(text: '${widget.item.price}');
    disRateController.value = TextEditingValue(text: '${widget.item.discount}');
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
    return Padding(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.rowType.name == 'price')
            FormBuilderTextField(
              name: 'price',
              controller: priceController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
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
            FormBuilderTouchSpin(
              name: 'qty',
              initialValue: widget.item.totalQty,
              controller: qtyController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              ],
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
            FormBuilderTouchSpin(
              name: 'returnQty',
              initialValue: widget.item.returnQty,
              controller: returnQtyController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              ],
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
      ),
    );
  }
}
