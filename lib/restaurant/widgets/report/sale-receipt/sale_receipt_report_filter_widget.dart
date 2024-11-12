import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants.dart';
import '../../../models/option/option_model.dart';
import '../../../providers/reports/sale_receipt_report_provider.dart';

class SaleReceiptReportFilterWidget extends StatelessWidget {
  final List<OptionModel> filters;
  const SaleReceiptReportFilterWidget({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppStyleDefaultProperties.p),
      child: DynamicHeightGridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: filters.length,
        crossAxisCount: 2,
        builder: (context, index) =>
            Selector<SaleReceiptReportProvider, OptionModel>(
          selector: (context, state) => state.filters[index],
          builder: (context, filter, child) => RichText(
              text: TextSpan(
            text: '${filter.label.tr()}: ',
            style: theme.textTheme.bodyMedium!.copyWith(),
            children: [
              TextSpan(text: '${filter.value}'),
            ],
          )),
        ),
      ),
    );
  }
}
