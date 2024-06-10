import 'package:flutter/widgets.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget tabletScaffold;
  final Widget desktopScaffold;

  const ResponsiveLayout({
    super.key,
    required this.mobileScaffold,
    required this.tabletScaffold,
    required this.desktopScaffold,
  });

  // Breakpoint Platform
  static const int _mobileBreakPoint = 500;
  static const int _tabletBreakPoint = 1100;

  // isMobile, isTablet, isDesktop helper
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < _mobileBreakPoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < _tabletBreakPoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > _tabletBreakPoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < _mobileBreakPoint) {
        return mobileScaffold;
      } else if (constraints.maxWidth < _tabletBreakPoint) {
        return tabletScaffold;
      } else {
        return desktopScaffold;
      }
    });
  }
}
