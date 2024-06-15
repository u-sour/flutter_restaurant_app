import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:flutter_template/providers/printer_provider.dart';
import 'package:flutter_template/services/printer_service.dart';
import 'package:provider/provider.dart';
import '../../router/route_utils.dart';
import '../../widgets/app_bar_widget.dart';

class PrinterScreen extends StatelessWidget {
  final Widget child;
  const PrinterScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    PrinterProvider readProvider = context.read<PrinterProvider>();
    return Scaffold(
        appBar: AppBarWidget(title: SCREENS.printer.toTitle),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Receipt(
                  backgroundColor: Colors.grey.shade200,
                  onInitialized: (controller) {
                    readProvider.controller = controller;
                  },
                  builder: (context) => child),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          PrinterService.showPrintingProgressDialog(context);
                        },
                        child: Text(context.tr('screens.printer.btn')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
