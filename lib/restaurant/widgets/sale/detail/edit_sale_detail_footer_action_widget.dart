import 'dart:async';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/convert_date_time.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/exchange/exchange_model.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../models/sale/receipt/sale_receipt_allow_currency_amount_model.dart';
import '../../../models/sale/receipt/sale_receipt_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../dialog_widget.dart';
import '../../empty_data_widget.dart';
import '../../format_currency_widget.dart';
import '../../loading_widget.dart';
import '../invoices/sale_invoice_widget.dart';

class EditSaleDetailFooterActionWidget extends StatelessWidget {
  final GlobalKey<FormBuilderState>? fbKey;
  final IconData titleIcon;
  final SaleDetailFooterType footerType;
  final dynamic value;
  final String insertLabel;
  final void Function()? onInsertPressed;
  final void Function()? onInsertAndPrintPressed;
  const EditSaleDetailFooterActionWidget({
    super.key,
    this.fbKey,
    this.titleIcon = RestaurantDefaultIcons.edit,
    required this.footerType,
    required this.value,
    this.insertLabel = 'dialog.actions.insert',
    this.onInsertPressed,
    this.onInsertAndPrintPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      title: footerType.toTitle,
      titleIcon: titleIcon,
      content: SizedBox(
        width: footerType.name == 'payment' || footerType.name == 'preview'
            ? double.maxFinite
            : double.minPositive,
        child: FormBuilder(
          key: fbKey,
          child: EditSaleDetailFooter(
            footerType: footerType,
            value: value,
          ),
        ),
      ),
      enableActions:
          footerType.name == 'preview' || footerType.name == 'payment',
      enableInsertAndPrintAction: footerType.name == 'payment',
      insertLabel: insertLabel,
      onInsertPressed: onInsertPressed,
      onInsertAndPrintPressed: onInsertAndPrintPressed,
    );
  }
}

class EditSaleDetailFooter extends StatefulWidget {
  final SaleDetailFooterType footerType;
  final dynamic value;

  const EditSaleDetailFooter(
      {super.key, required this.footerType, required this.value});

  @override
  State<EditSaleDetailFooter> createState() =>
      _EditSaleDetailDataTableRowState();
}

class _EditSaleDetailDataTableRowState extends State<EditSaleDetailFooter> {
  late SaleProvider readProvider;
  TextEditingController disRateController = TextEditingController();
  TextEditingController disAmountController = TextEditingController();
  Future<List<SelectOptionModel>>? tables;
  Future<List<SelectOptionModel>>? guests;
  // sale receipt
  final String prefixSaleReceipt =
      'screens.sale.detail.footerActions.form.saleReceipt';
  late SaleReceiptModel saleReceipt;
  late Future<List<SelectOptionModel>> paymentMethods;
  late List<String> allowedCurrencies;
  bool isAllowedTHB = false;
  int decimalNumber = 0;
  List<TextEditingController> receiveController = [];
  // preview (Invoice)
  List<SelectOptionModel> info = [];
  List<SaleDetailModel> saleDetails = [];
  List<SelectOptionModel> footer = [];

  @override
  void initState() {
    readProvider = context.read<SaleProvider>();
    if (widget.footerType.name == 'discountRate') {
      disRateController.value = TextEditingValue(text: '${widget.value}');
    }
    if (widget.footerType.name == 'discountAmount') {
      disAmountController.value = TextEditingValue(text: '${widget.value}');
    }

    if (widget.footerType.name == 'changeTable') {
      tables = readProvider.fetchTables();
    }

    if (widget.footerType.name == 'changeGuest') {
      guests = readProvider.fetchGuests();
    }

    if (widget.footerType.name == 'payment') {
      decimalNumber = readProvider.decimalNumber;
      paymentMethods = readProvider.fetchPaymentMethods();
      saleReceipt = widget.value['saleReceipt'];
      allowedCurrencies = widget.value['allowedCurrencies'];
      SaleReceiptAllowCurrencyAmountModel receiveAmount =
          readProvider.receiveAmount;
      if (allowedCurrencies.isNotEmpty) {
        // set receive controller
        for (int i = 0; i < allowedCurrencies.length; i++) {
          String currency = allowedCurrencies[i];
          receiveController.add(
            TextEditingController(
                text: '${receiveAmount.toJson()[currency.toLowerCase()]}'),
          );
        }
        // check allow thb currency or not
        isAllowedTHB = allowedCurrencies.contains('THB');
      }
    }

    if (widget.footerType.name == 'preview') {
      info = widget.value['info'];
      saleDetails = widget.value['saleDetails'];
      footer = widget.value['footer'];
    }
    super.initState();
  }

  void selectInputText({required TextEditingController controller}) {
    controller.selection = TextSelection(
        baseOffset: 0, extentOffset: controller.value.text.length);
  }

  void setReceiveTextFieldValue({
    required List<String> allowedCurrencies,
    required String textFieldCurrency,
    required BuildContext context,
  }) {
    SaleReceiptAllowCurrencyAmountModel receiveAmount =
        context.read<SaleProvider>().receiveAmount;
    for (int i = 0; i < allowedCurrencies.length; i++) {
      String currency = allowedCurrencies[i];
      if (currency != textFieldCurrency) {
        FormBuilder.of(context)!.fields['receive$currency']?.didChange(
            receiveAmount.toJson()[currency.toLowerCase()].toString());
      }
    }
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    disRateController.dispose();
    disAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return widget.footerType.name == 'preview'
        ? SaleInvoiceWidget(
            info: info,
            saleDetails: saleDetails,
            footer: footer,
          )
        : widget.footerType.name == 'payment'
            ? FutureBuilder(
                future: paymentMethods,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    final error = snapshot.error;
                    return Text('$error');
                  } else if (snapshot.hasData) {
                    final ExchangeModel exchange = saleReceipt.exchangeDoc;
                    final List<SelectOptionModel> paymentMethodOptions =
                        snapshot.data ?? [];
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        // Receipt Information
                        Card(
                          color: AppThemeColors.primary,
                          elevation: 0.0,
                          child: GridView(
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  ResponsiveLayout.isMobile(context) ? 1 : 2,
                              mainAxisExtent: AppStyleDefaultProperties.h * 2.2,
                            ),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(
                                AppStyleDefaultProperties.p),
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text:
                                          '${"$prefixSaleReceipt.invoice".tr()}: ',
                                      children: [
                                    TextSpan(
                                        text: readProvider.getInvoiceText(
                                            sale: saleReceipt.orderDoc,
                                            context: context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ])),
                              RichText(
                                  text: TextSpan(
                                      text:
                                          '${"$prefixSaleReceipt.date".tr()}: ',
                                      children: [
                                    TextSpan(
                                        text: ConvertDateTime
                                            .formatTimeStampToString(
                                                saleReceipt.orderDoc.date,
                                                true),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ))
                                  ])),
                              RichText(
                                  text: TextSpan(
                                      text:
                                          '${"$prefixSaleReceipt.customer".tr()}: ',
                                      children: [
                                    TextSpan(
                                        text: saleReceipt.orderDoc.guestName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ])),
                              RichText(
                                  text: TextSpan(
                                      text:
                                          '${"$prefixSaleReceipt.exchangeRate".tr()}: ',
                                      children: [
                                    TextSpan(
                                        text:
                                            '${exchange.khr}៛  = ${exchange.usd}\$',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    if (isAllowedTHB)
                                      TextSpan(
                                          text: ' = ${exchange.thb}฿',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold))
                                  ])),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppStyleDefaultProperties.h),
                        GridView(
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      ResponsiveLayout.isMobile(context)
                                          ? 1
                                          : 3,
                                  crossAxisSpacing: AppStyleDefaultProperties.w,
                                  mainAxisSpacing: AppStyleDefaultProperties.h,
                                  mainAxisExtent:
                                      AppStyleDefaultProperties.h * 4.5),
                          shrinkWrap: true,
                          children: [
                            FormBuilderDateTimePicker(
                              name: 'date',
                              initialValue: DateTime.now(),
                              firstDate: DateTime.now(),
                              decoration: InputDecoration(
                                  labelText: '$prefixSaleReceipt.date'.tr()),
                            ),
                            FormBuilderDropdown(
                                name: 'paymentBy',
                                initialValue: paymentMethodOptions
                                    .firstWhere((o) => o.label == "Cash",
                                        orElse: () => const SelectOptionModel(
                                            label: "", value: ""))
                                    .value,
                                decoration: InputDecoration(
                                    labelText:
                                        '$prefixSaleReceipt.paymentBy'.tr()),
                                onChanged: (value) {
                                  final num fee = paymentMethodOptions
                                      .firstWhere((o) => o.value == value)
                                      .extra;
                                  readProvider.getFeeAmount(fee: fee);
                                },
                                items: paymentMethodOptions
                                    .map(
                                      (paymentMethod) =>
                                          DropdownMenuItem<String>(
                                        value: paymentMethod.value,
                                        child: Text(paymentMethod.label),
                                      ),
                                    )
                                    .toList()),
                            FormBuilderTextField(
                              name: 'memo',
                              decoration: InputDecoration(
                                  labelText: '$prefixSaleReceipt.memo'.tr()),
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                            )
                          ],
                        ),
                        const SizedBox(height: AppStyleDefaultProperties.h),
                        DynamicHeightGridView(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: ResponsiveLayout.isMobile(context)
                              ? 1
                              : allowedCurrencies.length,
                          shrinkWrap: true,
                          itemCount: allowedCurrencies.length,
                          builder: (context, index) {
                            String allowedCurrency = allowedCurrencies[index];
                            SaleReceiptAllowCurrencyAmountModel openAmount =
                                readProvider.openAmount;
                            num open = 0;
                            switch (allowedCurrency) {
                              case 'KHR':
                                open = openAmount.khr;
                                break;
                              case 'USD':
                                open = openAmount.usd;
                                break;
                              default:
                                open = openAmount.thb;
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (ResponsiveLayout.isMobile(context))
                                  const Divider(),
                                // Total
                                Text(
                                  '${"$prefixSaleReceipt.total".tr()}: ',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: FormatCurrencyWidget(
                                      baseCurrency: allowedCurrency,
                                      prefixCurrencySymbol: true,
                                      value: open,
                                      color: AppThemeColors.primary),
                                ),
                                const SizedBox(
                                    height: AppStyleDefaultProperties.h),
                                // Receive
                                FormBuilderTextField(
                                  name: 'receive$allowedCurrency',
                                  controller: receiveController[index],
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[0-9.]")),
                                  ],
                                  decoration: InputDecoration(
                                      labelText:
                                          '$prefixSaleReceipt.receive.${allowedCurrency.toLowerCase()}'
                                              .tr()),
                                  onTap: () => selectInputText(
                                      controller: receiveController[index]),
                                  onTapOutside: (event) =>
                                      setReceiveTextFieldValue(
                                          allowedCurrencies: allowedCurrencies,
                                          textFieldCurrency: allowedCurrency,
                                          context: context),
                                  onChanged: (value) {
                                    num amount = num.tryParse(value!) ?? 0;
                                    readProvider.handleReceiveInputChange(
                                        amount: amount,
                                        currency: allowedCurrency,
                                        exchange: exchange);
                                  },
                                  onEditingComplete: () =>
                                      setReceiveTextFieldValue(
                                          allowedCurrencies: allowedCurrencies,
                                          textFieldCurrency: allowedCurrency,
                                          context: context),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                ),
                                const SizedBox(
                                    height: AppStyleDefaultProperties.h),
                                // Fee
                                Selector<
                                    SaleProvider,
                                    ({
                                      num fee,
                                      SaleReceiptAllowCurrencyAmountModel feeAmount
                                    })>(
                                  selector: (context, state) => (
                                    fee: state.fee,
                                    feeAmount: state.feeAmount
                                  ),
                                  builder: (context, data, child) {
                                    num fee = 0;
                                    switch (allowedCurrency) {
                                      case 'KHR':
                                        fee = data.feeAmount.khr;
                                        break;
                                      case 'USD':
                                        fee = data.feeAmount.usd;
                                        break;
                                      default:
                                        fee = data.feeAmount.thb;
                                    }
                                    return data.fee > 0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                '${"$prefixSaleReceipt.fee".tr()}: ',
                                                style:
                                                    theme.textTheme.bodyLarge,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: FormatCurrencyWidget(
                                                    baseCurrency:
                                                        allowedCurrency,
                                                    prefixCurrencySymbol: true,
                                                    value: fee,
                                                    color:
                                                        AppThemeColors.primary),
                                              ),
                                              const SizedBox(
                                                  height:
                                                      AppStyleDefaultProperties
                                                          .h),
                                            ],
                                          )
                                        : const SizedBox();
                                  },
                                ),
                                // Return
                                Text(
                                  '${"$prefixSaleReceipt.return".tr()}: ',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Selector<SaleProvider,
                                        SaleReceiptAllowCurrencyAmountModel>(
                                    selector: (context, state) =>
                                        state.returnAmount,
                                    builder: (context, returnAmount, child) {
                                      num return_ = 0;
                                      switch (allowedCurrency) {
                                        case 'KHR':
                                          return_ = returnAmount.khr;
                                          break;
                                        case 'USD':
                                          return_ = returnAmount.usd;
                                          break;
                                        default:
                                          return_ = returnAmount.thb;
                                      }
                                      return Align(
                                        alignment: Alignment.centerLeft,
                                        child: FormatCurrencyWidget(
                                            baseCurrency: allowedCurrency,
                                            prefixCurrencySymbol: true,
                                            value: return_,
                                            color: AppThemeColors.primary),
                                      );
                                    }),
                              ],
                            );
                          },
                        )
                      ],
                    );
                  } else {
                    return const LoadingWidget();
                  }
                })
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.footerType.name == 'changeTable')
                    FutureBuilder<List<SelectOptionModel>>(
                        future: tables,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            final error = snapshot.error;
                            return Text('$error');
                          } else if (snapshot.hasData) {
                            final SelectOptionModel selectedTable =
                                SelectOptionModel(
                                    label: readProvider.tableLocation.table,
                                    value: readProvider.tableLocation.id);
                            return FormBuilderSearchableDropdown<
                                SelectOptionModel>(
                              name: 'changeTable',
                              initialValue: selectedTable,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              popupProps: PopupProps.dialog(
                                showSelectedItems: true,
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                          RestaurantDefaultIcons.search),
                                      hintText: 'screens.sale.search'.tr(),
                                      isDense: true),
                                ),
                                disabledItemFn: (item) => item.extra == 'floor',
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
                              items: snapshot.data!,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            );
                          } else {
                            return const LoadingWidget();
                          }
                        }),
                  if (widget.footerType.name == 'changeGuest')
                    FutureBuilder<List<SelectOptionModel>>(
                        future: guests,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            final error = snapshot.error;
                            return Text('$error');
                          } else if (snapshot.hasData) {
                            return FormBuilderSearchableDropdown<
                                SelectOptionModel>(
                              name: 'changeGuest',
                              initialValue: widget.value,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              popupProps: PopupProps.dialog(
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
                              items: snapshot.data!,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            );
                          } else {
                            return const LoadingWidget();
                          }
                        }),
                  if (widget.footerType.name == 'discountRate')
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
                        if (discountRate != null) {}
                      },
                      onTap: () =>
                          selectInputText(controller: disRateController),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.min(0),
                        FormBuilderValidators.max(100),
                      ]),
                    ),
                  if (widget.footerType.name == 'discountAmount')
                    FormBuilderTextField(
                      name: 'discountAmount',
                      controller: disAmountController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                      ],
                      onChanged: (String? discountAmount) {
                        if (discountAmount != null) {}
                      },
                      onTap: () =>
                          selectInputText(controller: disAmountController),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.min(0)]),
                    ),
                ],
              );
  }
}
