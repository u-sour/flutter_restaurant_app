import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants.dart';
import '../../../models/option/option_model.dart';
import '../../../providers/reports/sale_detail_profit_and_loss_by_item_report_provider.dart';

class SaleDetailProfitAndLossByItemReportFilterWidget extends StatelessWidget {
  final List<OptionModel> filters;
  const SaleDetailProfitAndLossByItemReportFilterWidget(
      {super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppStyleDefaultProperties.p),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < filters.length; i++)
            Selector<SaleDetailProfitAndLossByItemReportProvider, OptionModel>(
              selector: (context, state) => state.filters[i],
              builder: (context, filter, child) => RichText(
                  text: TextSpan(
                text: '${filter.label.tr()}: ',
                style: theme.textTheme.bodyMedium!.copyWith(),
                children: [
                  TextSpan(text: '${filter.value}'),
                ],
              )),
            )
        ],
      ),
    );
  }
}
