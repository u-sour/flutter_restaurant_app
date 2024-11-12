import 'package:flutter/material.dart';
import '../../../router/route_utils.dart';
import '../../widgets/report/report_app_bar_widget.dart';

class SaleDetailProfitAndLossByItemReportScreen extends StatelessWidget {
  const SaleDetailProfitAndLossByItemReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReportAppBarWidget(
          title: SCREENS.profitAndLossByItemReport.toReportTitle,
          onPressed: () {},
        ),
        body: const Placeholder());
  }
}
