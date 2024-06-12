import 'package:flutter/material.dart';

import '../utils/responsive/responsive_layout.dart';
import '../widgets/settings/change_printer_font_size_form_widget.dart';

class SettingsService {
  SettingsService._();
  static void showChangePrinterFontSizeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => const ResponsiveLayout(
            mobileScaffold: ChangePrinterFontSizeFormWidget(),
            tabletScaffold: Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 4,
                  child: ChangePrinterFontSizeFormWidget(),
                ),
                Spacer(),
              ],
            ),
            desktopScaffold: Row(
              children: [
                Spacer(),
                Expanded(
                  child: ChangePrinterFontSizeFormWidget(),
                ),
                Spacer()
              ],
            )));
  }
}
