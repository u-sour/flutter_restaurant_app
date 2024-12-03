import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../widgets/icon_with_text_widget.dart';
import '../providers/report-template/report_template_provider.dart';
import '../utils/constants.dart';
import '../widgets/report_template/report_template_toolbar_widget.dart';

class ReportTemplateScreen extends StatelessWidget {
  final Widget form;
  final Widget? toolBar;
  final List<Widget> reportTemplateLayouts;

  const ReportTemplateScreen({
    super.key,
    required this.form,
    this.toolBar = const ReportTemplateToolbarWidget(),
    required this.reportTemplateLayouts,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ReportTemplateProvider>().initData();
    return Padding(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      child: Column(
        children: [
          // Form
          ExpansionTile(
            initiallyExpanded: true,
            maintainState: true,
            title: const IconWithTextWidget(
                icon: RestaurantDefaultIcons.reportForm,
                text: 'screens.reports.customer.children.expansionFormTitle'),
            tilePadding: EdgeInsets.zero,
            childrenPadding:
                const EdgeInsets.only(top: AppStyleDefaultProperties.p / 2),
            shape: const Border(),
            children: <Widget>[form],
          ),
          // Toolbar
          const Divider(),
          toolBar!,
          // Report template layouts
          const Divider(),
          Expanded(
            child: DynamicHeightGridView(
              itemCount: reportTemplateLayouts.length,
              crossAxisCount: 1,
              builder: (context, index) {
                return Selector<ReportTemplateProvider, bool>(
                    selector: (context, state) =>
                        state.defaultRTLayouts[index].value,
                    builder: (context, isLayoutShow, child) => isLayoutShow
                        ? reportTemplateLayouts[index]
                        : const SizedBox.shrink());
              },
            ),
          ),
        ],
      ),
    );
  }
}
