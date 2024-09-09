import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/alert/alert.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/app-bar/sale_app_bar_action_model.dart';
import '../../../models/sale/sale/sale_model.dart';
import '../../../providers/sale/sale_provider.dart';
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
      SelectOptionModel(
        icon: SaleDetailOperationType.cancel.toIcon,
        label: SaleDetailOperationType.cancel.toTitle,
        value: SaleDetailOperationType.cancel.name,
      )
    ];
    return Padding(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      child: Row(
        children: [
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
                .map((o) => MenuItemButton(
                      leadingIcon: Icon(o.icon),
                      onPressed: () async {
                        SnackBar? snackBar;
                        if (o.value == "merge") {
                          final result = await readSaleProvider.mergeSale(
                              context: context);
                          if (result != null) {
                            snackBar = Alert.awesomeSnackBar(
                                message: result.message, type: result.type);
                          }
                        } else if (o.value == 'transfer') {
                          final result = await readSaleProvider
                              .transferSaleDetailItems(context: context);
                          if (result != null) {
                            snackBar = Alert.awesomeSnackBar(
                                message: result.message, type: result.type);
                          }
                        } else if (o.value == 'split') {
                          final result = await readSaleProvider
                              .splitSaleDetailItems(context: context);
                          if (result != null) {
                            snackBar = Alert.awesomeSnackBar(
                                message: result.message, type: result.type);
                          }
                        } else {
                          final result = await readSaleProvider.cancelSale(
                              context: context);
                          if (result != null) {
                            snackBar = Alert.awesomeSnackBar(
                                message: result.message, type: result.type);
                          }
                        }
                        if (!context.mounted) return;
                        if (snackBar != null) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      },
                      child: Text(o.label).tr(),
                    ))
                .toList(),
          ),
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
                : Column(
                    children: [
                      if (data.appBarTitle?.title != null)
                        Text(
                          data.appBarTitle!.title,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      if (data.appBarTitle?.date != null)
                        Text(
                          data.appBarTitle!.date!,
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
                  ),
          )),
          SizedBox(
            width: btnSize,
            height: btnSize,
            child: FilledButton(
              onPressed: () async {
                final result = await context.read<SaleProvider>().addNewSale();
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
              style: FilledButton.styleFrom(padding: EdgeInsets.zero),
              child: const Icon(RestaurantDefaultIcons.addInvoice),
            ),
          ),
        ],
      ),
    );
  }
}
