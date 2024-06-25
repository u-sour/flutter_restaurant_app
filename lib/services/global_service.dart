import 'package:flutter/material.dart';
import '../utils/responsive/responsive_layout.dart';

class GlobalService {
  GlobalService._();
  static void openDialog({
    required BuildContext context,
    required Widget contentWidget,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) => ResponsiveLayout(
            mobileScaffold: contentWidget,
            tabletScaffold: Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: contentWidget,
                ),
                const Spacer(),
              ],
            ),
            desktopScaffold: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: contentWidget,
                ),
                const Spacer()
              ],
            )));
  }
}
