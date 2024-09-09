import 'package:flutter/material.dart';
import '../app-bar/sale_app_bar_action_widget.dart';
import 'sale_detail_data_table_widget.dart';
import 'sale_detail_footer_actions_widget.dart';

class SaleDetailWidget extends StatelessWidget {
  final bool enableSaleAppBarActionWidget;
  final void Function()? onTap;

  const SaleDetailWidget({
    super.key,
    this.enableSaleAppBarActionWidget = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // Header
        if (enableSaleAppBarActionWidget)
          Material(
            child: InkWell(
              onTap: onTap,
              child: const SaleAppBarActionWidget(),
            ),
          ),
        Divider(height: 0.0, color: theme.focusColor),
        // Data Table
        const Expanded(child: SaleDetailDataTableWidget()),
        // Footer
        const SizedBox(height: 202.0, child: SaleDetailFooterActionsWidget())
      ],
    );
  }
}
