import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/route_utils.dart';

class InvoiceAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String? tableId;
  final bool? isSkipTable;
  final bool fromReceiptForm;
  final bool fromDashboard;
  const InvoiceAppBarWidget(
      {super.key,
      required this.title,
      required this.tableId,
      this.isSkipTable,
      required this.fromReceiptForm,
      required this.fromDashboard});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: BackButton(onPressed: () {
          if (fromReceiptForm &&
              !fromDashboard &&
              (isSkipTable != null && isSkipTable == true) &&
              tableId != null) {
            context.goNamed(SCREENS.sale.toName,
                queryParameters: {'table': tableId, 'fastSale': 'false'});
          } else if (fromReceiptForm &&
              !fromDashboard &&
              (isSkipTable != null && isSkipTable == false)) {
            context.goNamed(SCREENS.saleTable.toName);
          } else if (fromReceiptForm && fromDashboard) {
            context.goNamed(SCREENS.dashboard.toName);
          } else {
            context.pop();
          }
        }),
        title: Text(title.tr()),
        centerTitle: false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
