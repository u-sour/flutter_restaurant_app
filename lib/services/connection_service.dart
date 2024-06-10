import 'package:flutter/material.dart';
import '../utils/responsive/responsive_layout.dart';
import '../widgets/connection/setup_ip_address_form_widget.dart';

class ConnectionService {
  ConnectionService._();
  static void showSetupIpAddressDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => const ResponsiveLayout(
            mobileScaffold: SetupIpAddressFormWidget(),
            tabletScaffold: Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 4,
                  child: SetupIpAddressFormWidget(),
                ),
                Spacer(),
              ],
            ),
            desktopScaffold: Row(
              children: [
                Spacer(),
                Expanded(
                  child: SetupIpAddressFormWidget(),
                ),
                Spacer()
              ],
            )));
  }
}
