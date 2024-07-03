import 'package:flutter/material.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import 'sale_app_bar_action_widget.dart';
import 'sale_app_bar_navigation_widget.dart';
import 'sale_app_bar_search_widget.dart';

class SaleAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const SaleAppBarWidget({super.key, required this.title});

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
        const SaleAppBarNavigationWidget(),
        // Search
        const Expanded(flex: 3, child: SaleAppBarSearchWidget()),
        // Actions
        if (orientation == Orientation.landscape)
          const Expanded(flex: 4, child: SaleAppBarActionWidget())
      ],
    );

    const Row desktop = Row(
      children: [
        // Navigation
        Expanded(child: SaleAppBarNavigationWidget()),
        // Search
        Expanded(flex: 2, child: SaleAppBarSearchWidget()),
        // Actions
        Expanded(flex: 2, child: SaleAppBarActionWidget())
      ],
    );
    return AppBar(
      titleSpacing: 0.0,
      title: ResponsiveLayout(
          mobileScaffold: mobile,
          tabletScaffold: tablet,
          desktopScaffold: desktop),
      automaticallyImplyLeading: ResponsiveLayout.isMobile(context) ||
              ResponsiveLayout.isTablet(context)
          ? true
          : false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
