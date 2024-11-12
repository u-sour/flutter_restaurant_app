import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../bottom_nav_bar_widget.dart';
import '../drawer_widget.dart';
import '../no_internet_connection_widget.dart';

class MainWrapperScreen extends StatelessWidget {
  // route-view
  final StatefulNavigationShell navigationShell;
  const MainWrapperScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final Scaffold mobileAndTabletScaffold = Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavBarWidget(navigationShell: navigationShell),
      bottomSheet: Selector<AppProvider, bool>(
          selector: (_, state) => state.connected,
          builder: (context, connected, child) => !connected
              ? const NoInternetConnectionWidget()
              : const SizedBox.shrink()),
    );
    final Scaffold desktopScaffold = Scaffold(
      body: Row(children: [
        const DrawerWidget(),
        Expanded(child: navigationShell),
      ]),
      bottomSheet: Selector<AppProvider, bool>(
          selector: (_, state) => state.connected,
          builder: (context, connected, child) => !connected
              ? const NoInternetConnectionWidget()
              : const SizedBox.shrink()),
    );
    return ResponsiveLayout(
      mobileScaffold: mobileAndTabletScaffold,
      tabletScaffold: mobileAndTabletScaffold,
      desktopScaffold: desktopScaffold,
    );
  }
}
