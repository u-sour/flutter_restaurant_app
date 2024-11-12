import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/utils/responsive/responsive_layout.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../router/route_utils.dart';
import '../../utils/constants.dart';
import 'report_list_widget.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<SelectOptionModel> reports = [
      SelectOptionModel(
          icon: RestaurantDefaultIcons.report,
          label: SCREENS.saleReport.toTitle,
          value: SCREENS.saleReport.toName),
      SelectOptionModel(
          icon: RestaurantDefaultIcons.report,
          label: SCREENS.saleDetailReport.toTitle,
          value: SCREENS.saleDetailReport.toName),
      SelectOptionModel(
          icon: RestaurantDefaultIcons.report,
          label: SCREENS.profitAndLossByItemReport.toTitle,
          value: SCREENS.profitAndLossByItemReport.toName),
      SelectOptionModel(
          icon: RestaurantDefaultIcons.report,
          label: SCREENS.saleReceiptReport.toTitle,
          value: SCREENS.saleReceiptReport.toName),
    ];
    return Padding(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      child: DynamicHeightGridView(
        itemCount: reports.length,
        crossAxisCount: ResponsiveLayout.isMobile(context) ? 1 : 2,
        builder: (context, index) {
          final SelectOptionModel report = reports[index];
          return ReportListWidget(report: report);
        },
      ),
    );
  }
}
