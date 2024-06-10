import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/route_provider.dart';

class DrawerListTileWidget extends StatelessWidget {
  final int? index;
  final IconData icon;
  final String title;

  final void Function()? onTap;

  const DrawerListTileWidget(
      {super.key,
      this.index,
      required this.icon,
      required this.title,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteProvider>(builder: (context, state, child) {
      final bool selected = index == state.routeIndexState;
      return ListTile(
          selected: selected,
          leading: Icon(icon),
          title: Text(context.tr(title)),
          onTap: onTap);
    });
  }
}
