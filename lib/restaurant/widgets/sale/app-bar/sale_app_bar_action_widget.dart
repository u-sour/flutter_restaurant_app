import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../models/servers/response_model.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/alert/alert.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/sale/app-bar/sale_app_bar_action_model.dart';
import '../../../models/sale/sale/sale_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../services/user_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../badge_widget.dart';
import 'sale_invoice_widget.dart';

class SaleAppBarActionWidget extends StatelessWidget {
  const SaleAppBarActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    SaleProvider readSaleProvider = context.read<SaleProvider>();
    const double btnSize = 48.0;
    final List<SelectOptionModel> operations = [
      // SelectOptionModel(
      //   icon: SaleDetailOperationType.customerCount.toIcon,
      //   label: SaleDetailOperationType.customerCount.toTitle,
      //   value: SaleDetailOperationType.customerCount.name,
      // )
    ];
    // Note: Merge, Transfer, Split & Cancel បង្ហាញពេល user role != tablet-orders
    if (!UserService.userInRole(roles: ['tablet-orders'])) {
      operations.insertAll(0, [
        SelectOptionModel(
          icon: SaleDetailOperationType.merge.toIcon,
          label: SaleDetailOperationType.merge.toTitle,
          value: SaleDetailOperationType.merge.name,
        ),
        SelectOptionModel(
          icon: SaleDetailOperationType.transfer.toIcon,
          label: SaleDetailOperationType.transfer.toTitle,
          value: SaleDetailOperationType.transfer.name,
        ),
        SelectOptionModel(
          icon: SaleDetailOperationType.split.toIcon,
          label: SaleDetailOperationType.split.toTitle,
          value: SaleDetailOperationType.split.name,
        ),
      ]);
      operations.add(SelectOptionModel(
        icon: SaleDetailOperationType.cancel.toIcon,
        label: SaleDetailOperationType.cancel.toTitle,
        value: SaleDetailOperationType.cancel.name,
      ));
    }
    return Padding(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      child: Row(
        children: [
          // Sale List
          Selector<SaleProvider, List<SaleModel>>(
            selector: (context, state) => state.sales,
            builder: (context, sales, child) => BadgeWidget(
              count: sales.length,
              child: SizedBox(
                width: btnSize,
                height: btnSize,
                child: FilledButton(
                  onPressed: sales.isNotEmpty
                      ? () => GlobalService.openDialog(
                          contentWidget: const SaleInvoiceWidget(),
                          context: context)
                      : null,
                  style: FilledButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Icon(RestaurantDefaultIcons.invoiceList),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppStyleDefaultProperties.w),
          // Operation
          MenuAnchor(
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return SizedBox(
                width: btnSize,
                height: btnSize,
                child: FilledButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  style: FilledButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Icon(RestaurantDefaultIcons.operations),
                ),
              );
            },
            menuChildren: operations
                .map(
                  (o) => MenuItemButton(
                    leadingIcon: Icon(o.icon),
                    onPressed: () async {
                      ResponseModel? result;
                      if (o.value == SaleDetailOperationType.merge.name) {
                        result =
                            await readSaleProvider.mergeSale(context: context);
                      } else if (o.value ==
                          SaleDetailOperationType.transfer.name) {
                        result = await readSaleProvider.transferSaleDetailItems(
                            context: context);
                      } else if (o.value ==
                          SaleDetailOperationType.split.name) {
                        result = await readSaleProvider.splitSaleDetailItems(
                            context: context);
                      } else if (o.value ==
                          SaleDetailOperationType.customerCount.name) {
                        result = await readSaleProvider.updateSaleCustomerCount(
                            context: context);
                      } else {
                        result =
                            await readSaleProvider.cancelSale(context: context);
                      }
                      if (result != null) {
                        Alert.show(
                            description: result.description, type: result.type);
                      }
                    },
                    child: Selector<SaleProvider, SaleModel?>(
                      selector: (context, state) => state.currentSale,
                      builder: (context, currentSale, child) {
                        return o.value ==
                                SaleDetailOperationType.customerCount.name
                            ? RichText(
                                text: TextSpan(
                                    text: o.label.tr(),
                                    style: theme.textTheme.bodyMedium,
                                    children: [
                                    TextSpan(
                                      text: ' (${currentSale?.numOfGuest})',
                                      style:
                                          theme.textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    )
                                  ]))
                            : Text(o.label).tr();
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          // Title
          Expanded(
              child: Selector<SaleProvider,
                  ({SaleAppBarActionModel? appBarTitle, bool isLoading})>(
            selector: (context, state) => (
              appBarTitle: state.saleActionAppBarTitle,
              isLoading: state.isLoading
            ),
            builder: (context, data, child) => data.isLoading
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: theme.colorScheme.primary,
                      size: btnSize,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppStyleDefaultProperties.p),
                    child: Column(
                      children: [
                        if (data.appBarTitle?.title != null)
                          FittedBox(
                            child: Text(
                              data.appBarTitle!.title,
                              style: ResponsiveLayout.isMobile(context)
                                  ? theme.textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.bold)
                                  : theme.textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        if (data.appBarTitle?.date != null)
                          Text(
                            data.appBarTitle!.date!,
                            style: theme.textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
          )),
          // Add new sale (Invoice)
          // Note: បិទមិនអោយ ថែម invoice បានបើ user role != insert-invoice
          if (UserService.userInRole(roles: ['insert-invoice']))
            SizedBox(
              width: btnSize,
              height: btnSize,
              child: FilledButton(
                onPressed: () async {
                  final result =
                      await context.read<SaleProvider>().addNewSale();
                  if (result != null) {
                    Alert.show(
                        description: result.description, type: result.type);
                  }
                },
                style: FilledButton.styleFrom(padding: EdgeInsets.zero),
                child: const Icon(RestaurantDefaultIcons.addInvoice),
              ),
            ),
        ],
      ),
    );
  }
}
