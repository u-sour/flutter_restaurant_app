import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/constants.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../format_currency_widget.dart';
import 'sale_invoice_data_table_widget.dart';

class SaleInvoiceWidget extends StatelessWidget {
  final List<SelectOptionModel> info;
  final List<SaleDetailModel> saleDetails;
  final List<SelectOptionModel> footer;
  const SaleInvoiceWidget({
    super.key,
    required this.info,
    required this.saleDetails,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      // shrinkWrap: true,
      children: [
        // Information
        SizedBox(
          height: ResponsiveLayout.isMobile(context) ? 135.0 : 80.0,
          child: DynamicHeightGridView(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: info.length,
            crossAxisCount: ResponsiveLayout.isMobile(context) ? 1 : 2,
            builder: (context, index) {
              return Row(
                children: [
                  Text(
                    info[index].label.tr(),
                    style: theme.textTheme.bodyMedium,
                  ),
                  Expanded(
                    child: Text(
                      info[index].value,
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        // Sale Details
        Expanded(child: SaleInvoiceDataTableWidget(saleDetails: saleDetails)),
        // Footer
        Column(
          children: [
            for (int i = 0; i < footer.length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    footer[i].label.tr(),
                    style: theme.textTheme.bodyMedium,
                  ),
                  FormatCurrencyWidget(
                      value: footer[i].value, color: AppThemeColors.primary),
                ],
              )
          ],
        )
      ],
    );
  }
}
