import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../utils/constants.dart';
import '../../../utils/constants.dart';

class SaleDetailFooterActionsWidget extends StatelessWidget {
  const SaleDetailFooterActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const prefixSaleDetailFooterActions = "screens.sale.detail.footerActions";
    const prefixDataTableFooter = "screens.sale.detail.dataTable.footer";
    final btnStyleNormalShape =
        TextButton.styleFrom(shape: const LinearBorder());
    const double smallHeight = AppStyleDefaultProperties.h / 6;
    final List<SelectOptionModel> operations = [
      const SelectOptionModel(
        icon: RestaurantDefaultIcons.merge,
        label: "$prefixSaleDetailFooterActions.operations.children.merge",
        value: "merge",
      ),
      const SelectOptionModel(
        icon: RestaurantDefaultIcons.transfer,
        label: "$prefixSaleDetailFooterActions.operations.children.transfer",
        value: "transfer",
      ),
      const SelectOptionModel(
        icon: RestaurantDefaultIcons.split,
        label: "$prefixSaleDetailFooterActions.operations.children.split",
        value: "split",
      ),
      const SelectOptionModel(
        icon: RestaurantDefaultIcons.cancel,
        label: "$prefixSaleDetailFooterActions.operations.children.cancel",
        value: "cancel",
      )
    ];
    return Material(
      color: theme.hoverColor,
      child: Column(
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(RestaurantDefaultIcons.changeTable),
                  label:
                      const Text("$prefixSaleDetailFooterActions.changeTable")
                          .tr()),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(RestaurantDefaultIcons.changeCustomer),
                  label: const Text("General")),
              // TextButton.icon(
              //     onPressed: () {},
              //     icon: const Icon(RestaurantDefaultIcons.cancelCopy),
              //     label: const Text("$prefixSaleDetailFooterActions.cancelCopy")
              //         .tr()),
              MenuAnchor(
                builder: (BuildContext context, MenuController controller,
                    Widget? child) {
                  return TextButton.icon(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: const Icon(RestaurantDefaultIcons.operations),
                    label: const Text(
                            "$prefixSaleDetailFooterActions.operations.title")
                        .tr(),
                    // tooltip: 'Back',
                  );
                },
                menuChildren: operations
                    .map((o) => MenuItemButton(
                          leadingIcon: Icon(o.icon),
                          onPressed: () => {},
                          child: Text(o.label).tr(),
                        ))
                    .toList(),
              ),
            ],
          ),
          Divider(height: 0.0, color: theme.scaffoldBackgroundColor),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: btnStyleNormalShape,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(RestaurantDefaultIcons.chef),
                        const Text("$prefixSaleDetailFooterActions.chef").tr(),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                    width: 0.0, color: theme.scaffoldBackgroundColor),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: btnStyleNormalShape,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(RestaurantDefaultIcons.print),
                        const Text("$prefixSaleDetailFooterActions.print").tr(),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                    width: 0.0, color: theme.scaffoldBackgroundColor),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: btnStyleNormalShape,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(RestaurantDefaultIcons.preview),
                        const Text(
                          "$prefixSaleDetailFooterActions.preview",
                          overflow: TextOverflow.ellipsis,
                        ).tr(),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                    width: 0.0, color: theme.scaffoldBackgroundColor),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: btnStyleNormalShape,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(RestaurantDefaultIcons.payment),
                        const Text(
                          "$prefixSaleDetailFooterActions.payment",
                          overflow: TextOverflow.ellipsis,
                        ).tr(),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                    width: 0.0, color: theme.scaffoldBackgroundColor),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.all(AppStyleDefaultProperties.p),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '$prefixDataTableFooter.subTotal'.tr(),
                              style: TextStyle(
                                  color: theme.textTheme.bodySmall?.color,
                                  fontWeight: FontWeight.bold),
                              children: const [
                                TextSpan(
                                    text: '0 \$',
                                    style: TextStyle(
                                        color: AppThemeColors.primary)),
                              ],
                            ),
                          ),
                          const SizedBox(height: smallHeight),
                          InkWell(
                              onTap: () {},
                              child: Text(
                                '$prefixDataTableFooter.disPercent'
                                    .tr(namedArgs: {"percent": "0"}),
                              )),
                          const SizedBox(height: smallHeight),
                          InkWell(
                              onTap: () {},
                              child: Text(
                                '$prefixDataTableFooter.disAmount'.tr(
                                    namedArgs: {
                                      "amount": "0",
                                      "baseCurrency": "\$"
                                    }),
                              )),
                          const SizedBox(height: smallHeight),
                          RichText(
                            text: TextSpan(
                              text: '$prefixDataTableFooter.total'.tr(),
                              style: TextStyle(
                                  color: theme.textTheme.bodySmall?.color,
                                  fontWeight: FontWeight.bold),
                              children: const [
                                TextSpan(
                                    text: '0 \$',
                                    style: TextStyle(
                                        color: AppThemeColors.primary)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
