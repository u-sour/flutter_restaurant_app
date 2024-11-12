import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/widgets/screen_list_tile_widget_model.dart';
import '../../../router/route_utils.dart';
import '../../../utils/responsive/responsive_layout.dart';
import '../../app_bar_widget.dart';
import '../../drawer_widget.dart';
import '../../screen_list_tile_widget.dart';

class FormBuilderScreen extends StatelessWidget {
  const FormBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ScreenListTileWidgetModel> models = [
      ScreenListTileWidgetModel(
        icon: SCREENS.formBuilderDefault.toIcon,
        title: context.tr(SCREENS.formBuilderDefault.toTitle),
        onTap: () => context.goNamed(SCREENS.formBuilderDefault.toName),
      ),
      ScreenListTileWidgetModel(
        icon: SCREENS.formBuilderValidation.toIcon,
        title: context.tr(SCREENS.formBuilderValidation.toTitle),
        onTap: () => context.goNamed(SCREENS.formBuilderValidation.toName),
      )
    ];
    return Scaffold(
      appBar: AppBarWidget(title: SCREENS.formBuilder.toTitle),
      drawer:
          !ResponsiveLayout.isDesktop(context) ? const DrawerWidget() : null,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: ListView.builder(
            itemCount: models.length,
            itemBuilder: (context, index) {
              final model = models[index];
              return ScreenListTileWidget(model: model);
            },
          ),
        ),
      ]),
    );
  }
}
