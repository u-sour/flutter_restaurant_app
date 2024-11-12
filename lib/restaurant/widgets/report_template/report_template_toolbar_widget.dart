import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/global_service.dart';
import '../../models/option/option_model.dart';
import '../../providers/report-template/report_template_provider.dart';
import '../../utils/constants.dart';
import '../dialog_widget.dart';
import '../icon_with_text_widget.dart';
import 'report_template_toolbar_list_widget.dart';

class ReportTemplateToolbarWidget extends StatelessWidget {
  const ReportTemplateToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const String prefixReportTemplateLayouts = 'screens.reportTemplate.layouts';
    final ReportTemplateProvider readReportTemplateProvider =
        context.read<ReportTemplateProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Layouts
        TextButton(
            onPressed: () async {
              await GlobalService.openDialog(
                  contentWidget: DialogWidget(
                    titleIcon: RestaurantDefaultIcons.templateLayouts,
                    title:
                        '${readReportTemplateProvider.prefixRTLayouts}.title',
                    content: SizedBox(
                      width: double.minPositive,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: readReportTemplateProvider
                              .defaultRTLayouts.length,
                          itemBuilder: (context, index) {
                            final OptionModel templateLayout =
                                readReportTemplateProvider
                                    .defaultRTLayouts[index];
                            return Selector<ReportTemplateProvider, bool>(
                              selector: (_, state) =>
                                  state.defaultRTLayouts[index].value,
                              builder: (context, value, child) =>
                                  ReportTemplateToolbarListWidget(
                                label: templateLayout.label,
                                value: value,
                                onChanged: (value) =>
                                    readReportTemplateProvider.toggleShowLayout(
                                        index: index, value: value),
                              ),
                            );
                          }),
                    ),
                    enableActions: false,
                  ),
                  context: context);
            },
            child: const IconWithTextWidget(
              icon: RestaurantDefaultIcons.templateLayouts,
              text: '$prefixReportTemplateLayouts.title',
            )),
        // Actions
        // for (int i = 0;
        //     i < readReportTemplateProvider.defaultRTActions.length;
        //     i++)
        //   TextButton(
        //     onPressed: () {},
        //     child: IconWithTextWidget(
        //       icon: readReportTemplateProvider.defaultRTActions[i].icon!,
        //       text: readReportTemplateProvider.defaultRTActions[i].label,
        //     ),
        //   ),
      ],
    );
  }
}
