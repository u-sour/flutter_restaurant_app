import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../router/route_utils.dart';
import '../providers/auth_provider.dart';
import '../providers/route_provider.dart';
import '../utils/constants.dart';
import '../utils/responsive/responsive_layout.dart';
import 'drawer_header_widget.dart';
import 'drawer_list_tile_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SCREENS> screens = AppNavigation.drawer
        .where((screen) => screen != SCREENS.logout)
        .toList();
    final SCREENS logoutScreen = AppNavigation.drawer.last;
    return Drawer(
        child: Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const DrawerHeaderWidget(),
              Expanded(
                child: ListView.builder(
                    itemCount: screens.length,
                    itemBuilder: (context, index) {
                      final IconData icon = screens[index].toIcon;
                      final String pathName = screens[index].toName;
                      return DrawerListTileWidget(
                          index: index,
                          icon: icon,
                          title: screens[index].toTitle,
                          onTap: () {
                            // Close Drawer (Mobile & Tablet)
                            if (!ResponsiveLayout.isDesktop(context)) {
                              context.pop();
                            }
                            // Go To Screen
                            context
                                .read<RouteProvider>()
                                .changeRouteIndexState(index);
                            context.goNamed(pathName);
                          });
                    }),
              )
            ],
          ),
        ),
        DrawerListTileWidget(
            icon: logoutScreen.toIcon,
            title: logoutScreen.toTitle,
            onTap: () => context.read<AuthProvider>().logOut()),
      ],
    ));
  }
}
