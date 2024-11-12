import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../router/route_utils.dart';
import '../providers/route_provider.dart';
import '../utils/constants.dart';

class BottomNavBarWidget extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavBarWidget({super.key, required this.navigationShell});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  void _goToScreen(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<SCREENS> screens = AppNavigation.bottomNavBar;
    // Tabs
    final List<GButton> tabs = [];
    for (int i = 0; i < screens.length; i++) {
      final IconData icon = screens[i].toIcon;
      final String title = screens[i].toTitle;
      tabs.add(GButton(icon: icon, text: context.tr(title)));
    }
    return Container(
      color: theme.bottomNavigationBarTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Consumer<RouteProvider>(
          builder: (context, state, child) => GNav(
              color: theme.bottomNavigationBarTheme.unselectedLabelStyle?.color,
              activeColor:
                  theme.bottomNavigationBarTheme.selectedLabelStyle?.color,
              tabBackgroundColor:
                  theme.bottomNavigationBarTheme.selectedItemColor ??
                      Colors.transparent,
              gap: 8.0,
              padding: const EdgeInsets.all(16.0),
              selectedIndex: state.routeIndexState,
              onTabChange: (int index) {
                // Go To Screen
                state.changeRouteIndexState(index);
                _goToScreen(index);
              },
              tabs: tabs),
        ),
      ),
    );
  }
}
