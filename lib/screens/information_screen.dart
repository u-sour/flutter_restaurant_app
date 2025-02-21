import 'package:flutter/material.dart';
import '../models/select-option/select_option_model.dart';
import '../router/route_utils.dart';
import '../utils/constants.dart';
import '../utils/responsive/responsive_layout.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/information/information_list_tile_widget.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: SCREENS.information.toTitle),
      drawer:
          !ResponsiveLayout.isDesktop(context) ? const DrawerWidget() : null,
      body: ListView.builder(
        itemCount: AppInfo.information.length,
        itemBuilder: (context, index) {
          SelectOptionModel info = AppInfo.information[index];
          return InformationListTileWidget(model: info);
        },
      ),
    );
  }
}
