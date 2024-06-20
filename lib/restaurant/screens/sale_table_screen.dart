import 'package:flutter/material.dart';
import '../../router/route_utils.dart';
import '../../widgets/app_bar_widget.dart';

class SaleTableScreen extends StatelessWidget {
  const SaleTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: SCREENS.saleTable.toTitle),
        body: const Column(
          children: [Text('Sale Table')],
        ));
  }
}
