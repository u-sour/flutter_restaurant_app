import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/utils/constants.dart';
import '../../../utils/constants.dart';

class ReportAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final void Function()? onPressed;
  const ReportAppBarWidget({
    super.key,
    required this.title,
    this.icon = RestaurantDefaultIcons.submitReportForm,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Text(context.tr(title)),
      centerTitle: false,
      actions: [
        FilledButton(
            onPressed: onPressed,
            style: theme.filledButtonTheme.style!.copyWith(
                padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
            child: Icon(icon)),
        const SizedBox(width: AppStyleDefaultProperties.w)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
