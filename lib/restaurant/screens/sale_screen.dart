import 'package:flutter/material.dart';
import '../../widgets/app_bar_widget.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: ""),
      body: Column(
        children: [Text('Sale')],
      ),
    );
  }
}
