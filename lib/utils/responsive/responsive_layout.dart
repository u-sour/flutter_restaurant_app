import 'package:flutter/material.dart';
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
  static const double _mobileBreakPoint = 600.0;
  static const double _tabletBreakPoint = 768.0;
  static const double _desktopBreakPoint = 1440.0;

  // isMobile, isTablet, isDesktop helper
  // isMobile Condition : orientation == portrait and device width smaller than tablet breakpoint
  // or orientation == landscape and device height smaller than mobile breakpoint
  static bool isMobile(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.portrait &&
          MediaQuery.sizeOf(context).width < _tabletBreakPoint ||
      MediaQuery.orientationOf(context) == Orientation.landscape &&
          MediaQuery.sizeOf(context).height < _mobileBreakPoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= _tabletBreakPoint &&
      MediaQuery.sizeOf(context).width < _desktopBreakPoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width > _desktopBreakPoint;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.orientationOf(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (orientation == Orientation.portrait &&
              constraints.maxWidth < _tabletBreakPoint ||
          orientation == Orientation.landscape &&
              constraints.maxHeight < _mobileBreakPoint) {
        return mobileScaffold;
      } else if (constraints.maxWidth >= _tabletBreakPoint &&
          constraints.maxWidth < _desktopBreakPoint) {
        return tabletScaffold;
      } else {
        return desktopScaffold;
      }
    });
  }
}
