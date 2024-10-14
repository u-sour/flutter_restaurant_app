import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/route_utils.dart';

class InvoiceAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool fromReceiptForm;
  final bool fromDashboard;
  const InvoiceAppBarWidget(
      {super.key,
      required this.title,
      required this.fromReceiptForm,
      required this.fromDashboard});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: BackButton(
            onPressed: () => fromReceiptForm && !fromDashboard
                ? context.goNamed(SCREENS.saleTable.toName)
                : fromReceiptForm && fromDashboard
                    ? context.goNamed(SCREENS.dashboard.toName)
                    : context.pop()),
        title: Text(title.tr()),
        centerTitle: false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
