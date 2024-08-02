import 'package:flutter/material.dart';
import '../restaurant/widgets/dashboard/feature_widget.dart';
import '../restaurant/widgets/dashboard/sale_invoice_widget.dart';
import '../restaurant/widgets/department_widget.dart';
import '../utils/constants.dart';
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DepartmentWidget(),
                SizedBox(height: AppStyleDefaultProperties.h),
              ],
            ),
            const Expanded(child: SaleInvoiceWidget()),
            const SizedBox(height: AppStyleDefaultProperties.h),
            FeatureWidget(),
          ]),
        ),
      ),
    );
  }
}
