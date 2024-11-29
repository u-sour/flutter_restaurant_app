import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/convert_date_time.dart';
import '../../../utils/responsive/responsive_layout.dart';
import '../../models/company/company_accounting_model.dart';
import '../../models/sale/invoice/sale_invoice_data_model.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../format_currency_widget.dart';

class SaleInvoiceCardListWidget extends StatelessWidget {
  final SaleInvoiceDataModel data;
  final Function()? onTap;
  final Function()? onBtnPressed;
  const SaleInvoiceCardListWidget({
    super.key,
    required this.data,
    this.onTap,
    this.onBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final DashboardProvider readDashboardProvider =
        context.read<DashboardProvider>();
    final ThemeData theme = Theme.of(context);
    const String prefixSaleInvoiceContentCard =
        "screens.dashboard.saleInvoiceContent.card";
    Color cardColor = AppThemeColors.primary;
    if (data.requestPayment != null) {
      cardColor = AppThemeColors.failure;
    }
    if (data.billed > 0) {
      cardColor = AppThemeColors.warning;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
        decoration: BoxDecoration(
            border: Border.all(color: cardColor),
            borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '$prefixSaleInvoiceContentCard.table'
                        .tr(namedArgs: {'tableName': data.tableName}),
                    style: ResponsiveLayout.isMobile(context)
                        ? theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis)
                        : theme.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis))
              ],
            ),
            const SizedBox(height: AppStyleDefaultProperties.h),
            // Content
            Text(
                '$prefixSaleInvoiceContentCard.invoice'.tr(namedArgs: {
                  'invoice': readDashboardProvider.getInvoiceText(
                      invoice: data, context: context)
                }),
                style: theme.textTheme.bodyMedium!
                    .copyWith(overflow: TextOverflow.ellipsis)),
            Text(
                '$prefixSaleInvoiceContentCard.date'.tr(namedArgs: {
                  'date':
                      ConvertDateTime.formatTimeStampToString(data.date, true)
                }),
                style: theme.textTheme.bodyMedium!
                    .copyWith(overflow: TextOverflow.ellipsis)),
            const SizedBox(height: AppStyleDefaultProperties.h),
            FilledButton(
              onPressed: onBtnPressed,
              style: theme.filledButtonTheme.style?.copyWith(
                backgroundColor: WidgetStateProperty.all(cardColor),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.all(AppStyleDefaultProperties.bp / 3),
                ),
              ),
              child: Selector<AppProvider, CompanyAccountingModel>(
                selector: (context, state) => state.companyAccounting,
                builder: (context, companyAccounting, child) =>
                    FormatCurrencyWidget(
                  value: data.total,
                  enableRoundNumber: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
