import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../models/servers/response_model.dart';
import '../../../../providers/app_provider.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/alert/alert.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/company/company_accounting_model.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../models/sale/sale/sale_model.dart';
import '../../../providers/sale/products/sale_products_provider.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../services/sale_service.dart';
import '../../../services/user_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/format_currency.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../format_currency_widget.dart';
import 'edit_sale_detail_footer_action_widget.dart';

class SaleDetailFooterActionsWidget extends StatelessWidget {
  const SaleDetailFooterActionsWidget({super.key});
  static final GlobalKey<FormBuilderState> _fbEditFooterKey =
      GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SaleProvider readSaleProvider = context.read<SaleProvider>();
    SaleProductsProvider readSaleProductsProvider =
        context.read<SaleProductsProvider>();
    const prefixSaleDetailFooterActions = "screens.sale.detail.footerActions";
    const prefixDataTableFooter = "screens.sale.detail.footer";
    final btnStyleNormalShape =
        TextButton.styleFrom(shape: const LinearBorder());
    final Color dividerColor = theme.focusColor;
    const double smallHeight = AppStyleDefaultProperties.h / 6;

    return Material(
      color: Colors.transparent,
      child: Selector<AppProvider, List<String>>(
        selector: (context, state) => state.allowModules,
        builder: (context, allowModules, child) => Column(
          children: [
            Divider(height: 0.0, color: dividerColor),
            Selector<SaleProvider, SaleModel?>(
              selector: (context, state) => state.currentSale,
              builder: (context, currentSale, child) => currentSale != null
                  ? Padding(
                      padding:
                          const EdgeInsets.all(AppStyleDefaultProperties.p / 2),
                      child: Row(
                        children: [
                          // Change Table
                          // Note: បង្ហាញពេល module skip-table មិន active
                          if (!SaleService.isModuleActive(
                              modules: allowModules
                                  .where((m) => m == 'skip-table')
                                  .toList(),
                              context: context))
                            TextButton(
                              onPressed: () => GlobalService.openDialog(
                                  contentWidget:
                                      EditSaleDetailFooterActionWidget(
                                    fbKey: _fbEditFooterKey,
                                    footerType:
                                        SaleDetailFooterType.changeTable,
                                    value: readSaleProvider.tableLocation.id,
                                    onInsertPressed: () async {
                                      if (_fbEditFooterKey.currentState!
                                          .saveAndValidate()) {
                                        final String tableId = _fbEditFooterKey
                                            .currentState!.value['changeTable'];
                                        // check if new table then update
                                        if (tableId !=
                                            readSaleProvider.tableLocation.id) {
                                          await readSaleProvider
                                              .updateSaleTable(
                                                  tableId: tableId,
                                                  context: context);
                                        }
                                        if (context.mounted) {
                                          context.pop();
                                        }
                                      }
                                    },
                                  ),
                                  context: context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                      RestaurantDefaultIcons.changeTable),
                                  if (ResponsiveLayout.isTablet(context))
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left:
                                              AppStyleDefaultProperties.p / 2),
                                      child: const Text(
                                              "$prefixSaleDetailFooterActions.changeTable")
                                          .tr(),
                                    ),
                                ],
                              ),
                            ),
                          // Change Guest
                          Expanded(
                            child: TextButton.icon(
                                onPressed: () => GlobalService.openDialog(
                                    contentWidget:
                                        EditSaleDetailFooterActionWidget(
                                      fbKey: _fbEditFooterKey,
                                      footerType:
                                          SaleDetailFooterType.changeGuest,
                                      value: readSaleProvider.currentGuest,
                                      onInsertPressed: () async {
                                        if (_fbEditFooterKey.currentState!
                                            .saveAndValidate()) {
                                          final String guestId =
                                              _fbEditFooterKey.currentState!
                                                  .value['changeGuest'];
                                          // check if new guest then update
                                          if (guestId !=
                                              readSaleProvider
                                                  .currentGuest.value) {
                                            await readSaleProvider
                                                .updateSaleGuest(
                                                    guestId: guestId);
                                            // fetch products again
                                            await readSaleProductsProvider
                                                .filter(
                                              search: readSaleProductsProvider
                                                  .search,
                                              categoryId:
                                                  readSaleProductsProvider
                                                      .categoryId,
                                              productGroupId:
                                                  readSaleProductsProvider
                                                      .productGroupId,
                                              showExtraFood:
                                                  readSaleProductsProvider
                                                      .showExtraFood,
                                              invoiceId: readSaleProvider
                                                  .currentSale!.id,
                                            );
                                          }
                                          if (context.mounted) {
                                            context.pop();
                                          }
                                        }
                                      },
                                    ),
                                    context: context),
                                icon: const Icon(
                                    RestaurantDefaultIcons.changeCustomer),
                                label: Selector<SaleProvider,
                                        SelectOptionModel>(
                                    selector: (context, state) =>
                                        state.currentGuest,
                                    builder: (context, guest, child) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              guest.label,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            if (guest.extra != null)
                                              Text(
                                                '${guest.extra}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                          ],
                                        ))),
                          ),
                          // Cancel & copy
                          // Note: បង្ហាញពេល module != tablet-orders || user role != tablet-orders
                          if (!SaleService.isModuleActive(
                                  modules: allowModules
                                      .where((m) => m == 'tablet-orders')
                                      .toList(),
                                  context: context) ||
                              !UserService.userInRole(roles: ['tablet-orders']))
                            TextButton(
                              onPressed: () async {
                                final result = await readSaleProvider
                                    .cancelSale(context: context, copy: true);
                                if (result != null) {
                                  Alert.show(
                                      description: result.description,
                                      type: result.type);
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(RestaurantDefaultIcons.cancelCopy),
                                  if (ResponsiveLayout.isTablet(context))
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left:
                                              AppStyleDefaultProperties.p / 2),
                                      child: const Text(
                                              "$prefixSaleDetailFooterActions.cancelCopy")
                                          .tr(),
                                    ),
                                ],
                              ),
                            )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Divider(height: 0.0, color: dividerColor),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Print to Kitchen (Sent selected item to Chef Monitor)
                        // Note: បង្ហាញពេល module != tablet-orders || user role != tablet-orders
                        if (!SaleService.isModuleActive(
                                modules: allowModules
                                    .where((m) => m == 'tablet-orders')
                                    .toList(),
                                context: context) ||
                            !UserService.userInRole(
                                roles: ['tablet-orders'])) ...[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Print invoice to kitchen
                                Expanded(
                                    child: FilledButton(
                                  onPressed: () async {
                                    ResponseModel? result =
                                        await readSaleProvider
                                            .printInvoiceToKitchen(
                                                context: context);
                                    if (result != null) {
                                      Alert.show(
                                          description: result.description,
                                          type: result.type);
                                    }
                                  },
                                  style: FilledButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: const LinearBorder()),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(RestaurantDefaultIcons
                                          .printChefItems),
                                      if (!ResponsiveLayout.isMobile(context))
                                        const Text(
                                                "$prefixSaleDetailFooterActions.printToChef")
                                            .tr(),
                                    ],
                                  ),
                                )),
                                // Note: បង្ហាញពេល module == chef-monitor
                                if (SaleService.isModuleActive(
                                    modules: allowModules
                                        .where((m) => m == 'chef-monitor')
                                        .toList(),
                                    context: context))
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () async {
                                        final result = await readSaleProvider
                                            .printToKitchen(context: context);
                                        if (result != null) {
                                          Alert.show(
                                              description: result.description,
                                              type: result.type);
                                        }
                                      },
                                      style: btnStyleNormalShape,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                              RestaurantDefaultIcons.chef),
                                          if (!ResponsiveLayout.isMobile(
                                              context))
                                            const Text(
                                                    "$prefixSaleDetailFooterActions.chef")
                                                .tr(),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          VerticalDivider(width: 0.0, color: dividerColor),
                        ],
                        // Preview
                        // Note: បង្ហាញពេល module == tablet-orders && user role == tablet-orders
                        if (SaleService.isModuleActive(
                                modules: allowModules
                                    .where((m) => m == 'tablet-orders')
                                    .toList(),
                                context: context) &&
                            UserService.userInRole(
                                roles: ['tablet-orders'])) ...[
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                final result = await readSaleProvider.preview(
                                    context: context);
                                if (result != null) {
                                  Alert.show(
                                      description: result.description,
                                      type: result.type);
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
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Print Bill
                      // Note: បង្ហាញពេល  module != tablet-orders || user role != tablet-orders
                      if (!SaleService.isModuleActive(
                              modules: allowModules
                                  .where((m) => m == 'tablet-orders')
                                  .toList(),
                              context: context) ||
                          !UserService.userInRole(
                              roles: ['tablet-orders'])) ...[
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              final result = await readSaleProvider.printBill(
                                  context: context);
                              if (result != null) {
                                Alert.show(
                                    description: result.description,
                                    type: result.type);
                              }
                            },
                            style: btnStyleNormalShape,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(RestaurantDefaultIcons.print),
                                if (!ResponsiveLayout.isMobile(context))
                                  const Text(
                                          "$prefixSaleDetailFooterActions.print")
                                      .tr(),
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(width: 0.0, color: dividerColor),
                      ],
                      // Payment
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            ResponseModel? result;
                            if (UserService.userInRole(
                                roles: ['tablet-orders'])) {
                              if (UserService.userInRole(
                                  roles: ['request-payment'])) {
                                result = await readSaleProvider.requestPayment(
                                    context: context);
                              }
                            } else {
                              result = await readSaleProvider.payment(
                                  context: context);
                            }
                            if (result != null) {
                              Alert.show(
                                  description: result.description,
                                  type: result.type);
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
                    ],
                  )),
                  VerticalDivider(width: 0.0, color: dividerColor),
                  Expanded(
                      flex: ResponsiveLayout.isMobile(context) ? 4 : 2,
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
                                                            value:
                                                                discountRate),
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
                                                          discountRate:
                                                              disRate);
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
                                                  _fbEditFooterKey
                                                          .currentState!.value[
                                                      'discountAmount']) ??
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
                                          builder:
                                              (context, companyAcc, child) {
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
                                                      baseline: TextBaseline
                                                          .alphabetic,
                                                      child:
                                                          FormatCurrencyWidget(
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
                                                  ]),
                                            );
                                          }),
                                    ),
                                    const SizedBox(height: smallHeight),
                                    // Total
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            '$prefixDataTableFooter.total'.tr(),
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
      ),
    );
  }
}
