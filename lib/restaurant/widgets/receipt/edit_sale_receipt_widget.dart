import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/convert_date_time.dart';
import '../../../utils/responsive/responsive_layout.dart';
import '../../models/sale/receipt/edit_sale_receipt_model.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../../providers/sale/sale_provider.dart';
import '../../utils/constants.dart';
import '../empty_data_widget.dart';
import '../format_currency_widget.dart';
import '../loading_widget.dart';

class EditSaleReceiptWidget extends StatefulWidget {
  final GlobalKey<FormBuilderState> fbEditSaleReceiptKey;
  final EditSaleReceiptModel saleReceipt;
  final String baseCurrency;
  final int decimalNumber;
  const EditSaleReceiptWidget({
    super.key,
    required this.fbEditSaleReceiptKey,
    required this.saleReceipt,
    required this.baseCurrency,
    required this.decimalNumber,
  });

  @override
  State<EditSaleReceiptWidget> createState() => _EditSaleReceiptWidgetState();
}

class _EditSaleReceiptWidgetState extends State<EditSaleReceiptWidget> {
  late DashboardProvider readDashboardProvider;
  late SaleProvider readSaleProvider;
  late Future<List<SelectOptionModel>> guests;
  late Future<List<SelectOptionModel>> paymentMethods;
  final String prefixEditSaleReceipt =
      'screens.dashboard.dialog.confirm.editSaleReceipt.form';
  late TextEditingController receiveController;
  @override
  void initState() {
    super.initState();
    readDashboardProvider = context.read<DashboardProvider>();
    readSaleProvider = context.read<SaleProvider>();
    paymentMethods = readSaleProvider.fetchPaymentMethods(
        branchId: widget.saleReceipt.branchId);
    guests =
        readSaleProvider.fetchGuests(branchId: widget.saleReceipt.branchId);
    receiveController = TextEditingController(text: '0');
  }

  void selectInputText({required TextEditingController controller}) {
    controller.selection = TextSelection(
        baseOffset: 0, extentOffset: controller.value.text.length);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder(
        future: Future.wait([guests, paymentMethods]),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            return Text('$error');
          } else if (snapshot.hasData) {
            final guestOptions = snapshot.data![0];
            final paymentMethodOptions = snapshot.data![1];
            return FormBuilder(
              key: widget.fbEditSaleReceiptKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  DynamicHeightGridView(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: ResponsiveLayout.isMobile(context) ? 1 : 3,
                    shrinkWrap: true,
                    itemCount: 3,
                    builder: (context, index) {
                      late Widget returnWidget;
                      switch (index) {
                        case 0:
                          returnWidget = RichText(
                              text: TextSpan(
                                  text:
                                      '${"$prefixEditSaleReceipt.invoice".tr()}: ',
                                  style: theme.textTheme.bodySmall!.copyWith(),
                                  children: [
                                TextSpan(
                                    text: widget.saleReceipt.refNo,
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold))
                              ]));
                          break;
                        case 1:
                          returnWidget = RichText(
                              text: TextSpan(
                                  text:
                                      '${"$prefixEditSaleReceipt.saleDate".tr()}: ',
                                  style: theme.textTheme.bodySmall!.copyWith(),
                                  children: [
                                TextSpan(
                                    text:
                                        ConvertDateTime.formatTimeStampToString(
                                            widget.saleReceipt.saleDate, true),
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold))
                              ]));
                          break;
                        default:
                          returnWidget =
                              FormBuilderSearchableDropdown<SelectOptionModel>(
                            name: 'guestId',
                            initialValue: SelectOptionModel(
                                label: widget.saleReceipt.guestName,
                                value: widget.saleReceipt.guestId),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                        RestaurantDefaultIcons.search),
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
                            items: guestOptions,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          );
                          break;
                      }
                      return returnWidget;
                    },
                  ),
                  const SizedBox(height: AppStyleDefaultProperties.h),
                  DynamicHeightGridView(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: ResponsiveLayout.isMobile(context) ? 1 : 3,
                    shrinkWrap: true,
                    itemCount: 3,
                    builder: (context, index) {
                      late Widget returnWidget;
                      switch (index) {
                        case 0:
                          returnWidget = FormBuilderDateTimePicker(
                            name: 'date',
                            initialValue: widget.saleReceipt.date,
                            firstDate: widget.saleReceipt.saleDate,
                            decoration: InputDecoration(
                                labelText:
                                    '$prefixEditSaleReceipt.receiptDate'.tr()),
                          );
                          break;
                        case 1:
                          returnWidget = FormBuilderDropdown(
                              name: 'paymentBy',
                              initialValue: paymentMethodOptions
                                  .firstWhere((o) => o.label == "Cash",
                                      orElse: () => const SelectOptionModel(
                                          label: "", value: ""))
                                  .value,
                              decoration: InputDecoration(
                                  labelText:
                                      '$prefixEditSaleReceipt.paymentBy'.tr()),
                              onChanged: (value) {
                                final num fee = paymentMethodOptions
                                    .firstWhere((o) => o.value == value)
                                    .extra;
                                readDashboardProvider.setFee(fee: fee);
                                readDashboardProvider.getFeeAmount(
                                    fee: fee,
                                    openAmount: widget.saleReceipt.openAmount,
                                    receiveAmount:
                                        readDashboardProvider.receiveAmount,
                                    baseCurrency: widget.baseCurrency,
                                    decimalNumber: widget.decimalNumber);
                              },
                              items: paymentMethodOptions
                                  .map(
                                    (paymentMethod) => DropdownMenuItem<String>(
                                      value: paymentMethod.value,
                                      child: Text(paymentMethod.label),
                                    ),
                                  )
                                  .toList());
                          break;
                        default:
                          returnWidget = FormBuilderTextField(
                            name: 'memo',
                            decoration: InputDecoration(
                                labelText: '$prefixEditSaleReceipt.memo'.tr()),
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                          );
                          break;
                      }
                      return returnWidget;
                    },
                  ),
                  const SizedBox(height: AppStyleDefaultProperties.h),
                  Container(
                      padding: const EdgeInsetsDirectional.all(
                          AppStyleDefaultProperties.p),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppThemeColors.primary),
                          borderRadius: BorderRadius.circular(
                              AppStyleDefaultProperties.r)),
                      child: FormatCurrencyWidget(
                        value: widget.saleReceipt.openAmount,
                        enableRoundNumber: false,
                        color: AppThemeColors.primary,
                        priceFontSize: theme.textTheme.headlineLarge!.fontSize,
                        currencySymbolFontSize:
                            theme.textTheme.headlineLarge!.fontSize! + 6,
                      )),
                  const SizedBox(height: AppStyleDefaultProperties.h),
                  Selector<DashboardProvider, num>(
                      selector: (context, state) => state.fee,
                      builder: (context, fee, child) {
                        return DynamicHeightGridView(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: ResponsiveLayout.isMobile(context)
                              ? 1
                              : fee > 0
                                  ? 2
                                  : 1,
                          shrinkWrap: true,
                          itemCount: fee > 0 ? 2 : 1,
                          builder: (context, index) {
                            Widget returnWidget = FormBuilderTextField(
                              name: 'receiveAmount',
                              controller: receiveController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9.]")),
                              ],
                              decoration: InputDecoration(
                                  labelText:
                                      '$prefixEditSaleReceipt.receive'.tr()),
                              onTap: () => selectInputText(
                                  controller: receiveController),
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              onChanged: (value) {
                                num receiveAmount =
                                    num.tryParse(value ?? '0') ?? 0;
                                readDashboardProvider.setReceiveAmount(
                                    receiveAmount: receiveAmount);
                                readDashboardProvider.getFeeAmount(
                                    fee: fee,
                                    openAmount: widget.saleReceipt.openAmount,
                                    receiveAmount: receiveAmount,
                                    baseCurrency: widget.baseCurrency,
                                    decimalNumber: widget.decimalNumber);
                              },
                            );
                            if (index == 1 && fee > 0) {
                              returnWidget = Selector<DashboardProvider, num>(
                                selector: (context, state) => state.feeAmount,
                                builder: (context, feeAmount, child) =>
                                    RichText(
                                        text: TextSpan(
                                            text:
                                                '${"$prefixEditSaleReceipt.fee".tr()}: ',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(),
                                            children: [
                                      WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.baseline,
                                          baseline: TextBaseline.alphabetic,
                                          child: FormatCurrencyWidget(
                                            value: feeAmount,
                                            color: AppThemeColors.info,
                                          ))
                                    ])),
                              );
                            }
                            return returnWidget;
                          },
                        );
                      }),
                ],
              ),
            );
          } else {
            return const LoadingWidget();
          }
        });
  }
}
