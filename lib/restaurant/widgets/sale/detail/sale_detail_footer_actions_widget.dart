import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../providers/app_provider.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/alert/alert.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/company/company_accounting_model.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../models/sale/sale/sale_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../screens/insert_guest_screen.dart';
import '../../../utils/constants.dart';
import '../../../utils/format_currency.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../dialog_widget.dart';
import '../../format_currency_widget.dart';
import 'edit_sale_detail_footer_action_widget.dart';

class SaleDetailFooterActionsWidget extends StatelessWidget {
  const SaleDetailFooterActionsWidget({super.key});
  static final GlobalKey<FormBuilderState> _fbEditFooterKey =
      GlobalKey<FormBuilderState>();
  static final GlobalKey<FormBuilderState> _fbInsertGuestKey =
      GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SaleProvider readSaleProvider = context.read<SaleProvider>();
    const prefixSaleDetailFooterActions = "screens.sale.detail.footerActions";
    const prefixDataTableFooter = "screens.sale.detail.footer";
    final btnStyleNormalShape =
        TextButton.styleFrom(shape: const LinearBorder());
    final Color dividerColor = theme.focusColor;
    const double smallHeight = AppStyleDefaultProperties.h / 6;

    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Divider(height: 0.0, color: dividerColor),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              // Change Table
              TextButton.icon(
                  onPressed: () => GlobalService.openDialog(
                              contentWidget: EditSaleDetailFooterActionWidget(
                                  fbKey: _fbEditFooterKey,
                                  footerType: SaleDetailFooterType.changeTable,
                                  value: readSaleProvider.tableLocation.id),
                              context: context)
                          .then((_) async {
                        if (_fbEditFooterKey.currentState!.saveAndValidate()) {
                          final String tableId = _fbEditFooterKey
                              .currentState!.value['changeTable'];
                          // check if new table then update
                          if (tableId != readSaleProvider.tableLocation.id) {
                            await readSaleProvider.updateSaleTable(
                                tableId: tableId, context: context);
                          }
                        }
                      }),
                  icon: const Icon(RestaurantDefaultIcons.changeTable),
                  label:
                      const Text("$prefixSaleDetailFooterActions.changeTable")
                          .tr()),
              // Change Guest
              InkWell(
                onDoubleTap: () => GlobalService.openDialog(
                    contentWidget: DialogWidget(
                      titleIcon: RestaurantDefaultIcons.changeCustomer,
                      title: 'screens.guest.title',
                      content: InsertGuestScreen(fbKey: _fbInsertGuestKey),
                      onInsertPressed: () async {
                        if (_fbInsertGuestKey.currentState!.saveAndValidate()) {
                          Map<String, dynamic> form =
                              Map.of(_fbInsertGuestKey.currentState!.value);
                          final result =
                              await readSaleProvider.addGuest(form: form);
                          if (result != null) {
                            late SnackBar snackBar;
                            snackBar = Alert.awesomeSnackBar(
                                message: result.message, type: result.type);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                          if (context.mounted) {
                            context.pop();
                          }
                        }
                      },
                    ),
                    context: context),
                child: TextButton.icon(
                    onPressed: () => GlobalService.openDialog(
                                contentWidget: EditSaleDetailFooterActionWidget(
                                    fbKey: _fbEditFooterKey,
                                    footerType:
                                        SaleDetailFooterType.changeGuest,
                                    value: readSaleProvider.currentGuest),
                                context: context)
                            .then((_) async {
                          if (_fbEditFooterKey.currentState!
                              .saveAndValidate()) {
                            final String guestId = _fbEditFooterKey
                                .currentState!.value['changeGuest'];
                            // check if new guest then update
                            if (guestId !=
                                readSaleProvider.currentGuest.value) {
                              await readSaleProvider.updateSaleGuest(
                                  guestId: guestId);
                            }
                          }
                        }),
                    icon: const Icon(RestaurantDefaultIcons.changeCustomer),
                    label: Selector<SaleProvider, SelectOptionModel>(
                        selector: (context, state) => state.currentGuest,
                        builder: (context, guest, child) => Text(guest.label))),
              ),
              TextButton.icon(
                  onPressed: () async {
                    final result = await readSaleProvider.cancelSale(
                        context: context, copy: true);
                    if (result != null) {
                      late SnackBar snackBar;
                      snackBar = Alert.awesomeSnackBar(
                          message: result.message, type: result.type);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                  icon: const Icon(RestaurantDefaultIcons.cancelCopy),
                  label: const Text("$prefixSaleDetailFooterActions.cancelCopy")
                      .tr()),
            ],
          ),
          Divider(height: 0.0, color: dividerColor),
          // Print to Kitchen
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final result = await readSaleProvider.printToKitchen(
                          context: context);
                      if (result != null) {
                        late SnackBar snackBar;
                        snackBar = Alert.awesomeSnackBar(
                            message: result.message, type: result.type);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    },
                    style: btnStyleNormalShape,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(RestaurantDefaultIcons.chef),
                        if (!ResponsiveLayout.isMobile(context))
                          const Text("$prefixSaleDetailFooterActions.chef")
                              .tr(),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(width: 0.0, color: dividerColor),
                // Print Bill
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final result =
                          await readSaleProvider.printBill(context: context);
                      if (result != null) {
                        late SnackBar snackBar;
                        snackBar = Alert.awesomeSnackBar(
                            message: result.message, type: result.type);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    },
                    style: btnStyleNormalShape,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(RestaurantDefaultIcons.print),
                        if (!ResponsiveLayout.isMobile(context))
                          const Text("$prefixSaleDetailFooterActions.print")
                              .tr(),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(width: 0.0, color: dividerColor),
                // Preview
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final result =
                          await readSaleProvider.preview(context: context);
                      if (result != null) {
                        late SnackBar snackBar;
                        snackBar = Alert.awesomeSnackBar(
                            message: result.message, type: result.type);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    },
                    style: btnStyleNormalShape,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(RestaurantDefaultIcons.preview),
                        if (!ResponsiveLayout.isMobile(context))
                          const Text(
                            "$prefixSaleDetailFooterActions.preview",
                            overflow: TextOverflow.ellipsis,
                          ).tr(),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(width: 0.0, color: dividerColor),
                // Payment
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final result =
                          await readSaleProvider.payment(context: context);
                      if (result != null) {
                        late SnackBar snackBar;
                        snackBar = Alert.awesomeSnackBar(
                            message: result.message, type: result.type);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    },
                    style: btnStyleNormalShape,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(RestaurantDefaultIcons.payment),
                        if (!ResponsiveLayout.isMobile(context))
                          const Text(
                            "$prefixSaleDetailFooterActions.payment",
                            overflow: TextOverflow.ellipsis,
                          ).tr(),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(width: 0.0, color: dividerColor),
                Expanded(
                    flex: ResponsiveLayout.isMobile(context) ? 4 : 3,
                    child: Padding(
                      padding:
                          const EdgeInsets.all(AppStyleDefaultProperties.p),
                      child: Selector<
                              SaleProvider,
                              ({
                                SaleModel? currentSale,
                                List<SaleDetailModel> saleDetails
                              })>(
                          selector: (context, state) => (
                                currentSale: state.currentSale,
                                saleDetails: state.saleDetails
                              ),
                          builder: (context, data, child) {
                            String saleId = data.currentSale?.id ?? '';
                            num subTotal = readSaleProvider.calculateSubTotal(
                                saleDetails: data.saleDetails);
                            // return discount rate & discount value
                            Map<String, dynamic> discount =
                                readSaleProvider.calculateDiscount(
                                    currentSale: data.currentSale,
                                    subTotal: subTotal);
                            num discountRate = discount['rate'];
                            num discountValue = discount['value'];
                            num total = readSaleProvider.calculateTotal(
                                subTotal: subTotal,
                                discountValue: discountValue);
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Sub total
                                  RichText(
                                    text: TextSpan(
                                      text: '$prefixDataTableFooter.subTotal'
                                          .tr(),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                      children: [
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.baseline,
                                          baseline: TextBaseline.alphabetic,
                                          child: FormatCurrencyWidget(
                                            value: subTotal,
                                            color: AppThemeColors.primary,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: smallHeight),
                                  // Discount Percent
                                  InkWell(
                                      onTap: () => GlobalService.openDialog(
                                                  contentWidget:
                                                      EditSaleDetailFooterActionWidget(
                                                          fbKey:
                                                              _fbEditFooterKey,
                                                          footerType:
                                                              SaleDetailFooterType
                                                                  .discountRate,
                                                          value: discountRate),
                                                  context: context)
                                              .then((_) {
                                            if (_fbEditFooterKey.currentState!
                                                .saveAndValidate()) {
                                              final num disRate = num.tryParse(
                                                      _fbEditFooterKey
                                                              .currentState!
                                                              .value[
                                                          'discountRate']) ??
                                                  0;
                                              // check if new discount rate then update
                                              if (saleId.isNotEmpty &&
                                                  disRate !=
                                                      readSaleProvider
                                                          .currentSale!
                                                          .discountRate) {
                                                readSaleProvider
                                                    .updateSaleDiscountRate(
                                                        id: saleId,
                                                        discountRate: disRate);
                                              }
                                            }
                                          }),
                                      child: Text(
                                        '$prefixDataTableFooter.disRate'.tr(
                                            namedArgs: {
                                              "rate": "$discountRate"
                                            }),
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                      )),
                                  const SizedBox(height: smallHeight),
                                  // Discount Amount
                                  InkWell(
                                    onTap: () => GlobalService.openDialog(
                                            contentWidget:
                                                EditSaleDetailFooterActionWidget(
                                                    fbKey: _fbEditFooterKey,
                                                    footerType:
                                                        SaleDetailFooterType
                                                            .discountAmount,
                                                    value: discountValue),
                                            context: context)
                                        .then((_) {
                                      if (_fbEditFooterKey.currentState!
                                          .saveAndValidate()) {
                                        final num disAmount = num.tryParse(
                                                _fbEditFooterKey.currentState!
                                                    .value['discountAmount']) ??
                                            0;
                                        // check if new discount amount then update
                                        if (saleId.isNotEmpty &&
                                            disAmount !=
                                                readSaleProvider.currentSale!
                                                    .discountValue) {
                                          readSaleProvider
                                              .updateSaleDiscountAmount(
                                                  id: saleId,
                                                  discountAmount: disAmount);
                                        }
                                      }
                                    }),
                                    child: Selector<AppProvider,
                                            CompanyAccountingModel>(
                                        selector: (context, state) =>
                                            state.companyAccounting,
                                        builder: (context, companyAcc, child) {
                                          final String baseCurrency =
                                              companyAcc.baseCurrency;
                                          return RichText(
                                            text: TextSpan(
                                                text:
                                                    '$prefixDataTableFooter.disAmount'
                                                        .tr(),
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                children: [
                                                  TextSpan(
                                                    text: FormatCurrency
                                                        .getBaseCurrencySymbol(
                                                            baseCurrency:
                                                                baseCurrency),
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize:
                                                                baseCurrency ==
                                                                        'KHR'
                                                                    ? 18.0
                                                                    : null,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                  ),
                                                  const TextSpan(text: " : "),
                                                  WidgetSpan(
                                                    alignment:
                                                        PlaceholderAlignment
                                                            .baseline,
                                                    baseline:
                                                        TextBaseline.alphabetic,
                                                    child: FormatCurrencyWidget(
                                                      value: discountValue,
                                                      color: theme.textTheme
                                                          .bodyMedium!.color,
                                                      priceFontSize: 14.0,
                                                      currencySymbolFontSize:
                                                          16.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  )
                                                  // TextSpan(
                                                  //     text: ' : $discountValue')
                                                ]),
                                          );
                                        }),
                                  ),
                                  const SizedBox(height: smallHeight),
                                  // Total
                                  RichText(
                                    text: TextSpan(
                                      text: '$prefixDataTableFooter.total'.tr(),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                      children: [
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.baseline,
                                          baseline: TextBaseline.alphabetic,
                                          child: FormatCurrencyWidget(
                                            value: total,
                                            color: AppThemeColors.primary,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
