import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InvoiceAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const InvoiceAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title.tr()), centerTitle: false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
