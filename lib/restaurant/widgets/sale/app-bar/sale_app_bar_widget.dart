import 'package:flutter/material.dart';
import 'package:flutter_template/router/route_utils.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import 'sale_app_bar_action_widget.dart';
import 'sale_app_bar_navigation_widget.dart';
import 'sale_app_bar_search_widget.dart';

class SaleAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const SaleAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.orientationOf(context);
    const Row mobile = Row(
      children: [
        // Navigation
        SaleAppBarNavigationWidget(),
        // Search
        Expanded(child: SaleAppBarSearchWidget()),
      ],
    );

    Row tablet = Row(
      children: [
        // Navigation
        const SizedBox(width: 150.0, child: SaleAppBarNavigationWidget()),
        // Search
        const Expanded(child: SaleAppBarSearchWidget()),
        // Actions
        if (orientation == Orientation.landscape)
          const Expanded(child: SaleAppBarActionWidget())
      ],
    );

    const Row desktop = Row(
      children: [
        // Navigation
        SaleAppBarNavigationWidget(),
        // Search
        Expanded(flex: 3, child: SaleAppBarSearchWidget()),
        // Actions
        Expanded(flex: 3, child: SaleAppBarActionWidget())
      ],
    );
    return AppBar(
        titleSpacing: 0.0,
        leading: Row(
          children: [
            BackButton(
              onPressed: () => context.goNamed(SCREENS.dashboard.toName),
            ),
          ],
        ),
        title: ResponsiveLayout(
          mobileScaffold: mobile,
          tabletScaffold: tablet,
          desktopScaffold: desktop,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
