import 'package:flutter/material.dart';
import '../utils/responsive/responsive_layout.dart';
import '../widgets/printer/printing_progress_widget.dart';

class PrinterService {
  PrinterService._();
  static void showPrintingProgressDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const ResponsiveLayout(
            mobileScaffold: PrintingProgressWidget(),
            tabletScaffold: Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 4,
                  child: PrintingProgressWidget(),
                ),
                Spacer(),
              ],
            ),
            desktopScaffold: Row(
              children: [
                Spacer(),
                Expanded(
                  child: PrintingProgressWidget(),
                ),
                Spacer()
              ],
            )));
  }
}
