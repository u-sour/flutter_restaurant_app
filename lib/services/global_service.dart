import 'package:flutter/material.dart';
import '../utils/responsive/responsive_layout.dart';

class GlobalService {
  GlobalService._();
  static Future openDialog(
      {required Widget contentWidget, required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => ResponsiveLayout(
          mobileScaffold: contentWidget,
          tabletScaffold: Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 12,
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
          )),
    );
  }
}
