import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/route_utils.dart';

class InvoiceAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool fromReceiptForm;
  const InvoiceAppBarWidget(
      {super.key, required this.title, required this.fromReceiptForm});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: BackButton(
            onPressed: () => fromReceiptForm
                ? context.goNamed(SCREENS.saleTable.toName)
                : context.pop()),
        title: Text(title.tr()),
        centerTitle: false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
