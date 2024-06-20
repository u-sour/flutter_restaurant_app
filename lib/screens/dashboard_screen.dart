import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/widgets/dashboard/feature_widget.dart';
import 'package:flutter_template/utils/constants.dart';
import '../utils/responsive/responsive_layout.dart';
import '../widgets/app_bar_widget.dart';
import '../router/route_utils.dart';
import '../widgets/drawer_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: SCREENS.dashboard.toTitle),
      drawer:
          !ResponsiveLayout.isDesktop(context) ? const DrawerWidget() : null,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [FeatureWidget()]),
        ),
      ),
    );
  }
}
