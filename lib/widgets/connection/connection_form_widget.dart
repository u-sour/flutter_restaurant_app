import 'package:flutter/material.dart';
import 'package:flutter_template/services/connection_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../screens/app_screen.dart';
import '../../utils/constants.dart';
import '../../utils/responsive/responsive_layout.dart';
import 'setup_ip_address_form_widget.dart';

class ConnectionFormWidget extends StatelessWidget {
  const ConnectionFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: IconButton(
                splashRadius: 35.0,
                icon: const Icon(AppDefaultIcons.noConnection),
                // splashColor: CommonColors.secondary.withOpacity(0.1),
                onPressed: () =>
                    ConnectionService.showSetupIpAddressDialog(context),
                iconSize: 60.0,
                // color: CommonColors.secondary,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            LoadingAnimationWidget.staggeredDotsWave(
              color: theme.iconTheme.color!,
              size: 48.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Oops, Can\'t Connect To Server',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Please, config your IP Address to server',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Note: Check your Internet Connection and IP Address is correct',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 60.0),
            SizedBox(
              width: 100.0,
              child: ElevatedButton(
                onPressed: () {
                  meteor.reconnect();
                },
                child: const Text(
                  'Retry',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void openDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ResponsiveLayout(
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
            ));
      });
}

// void openModalBottomSheet(
//   BuildContext context,
// ) {
//   final ConnectionStorage connectionStorage = ConnectionStorage();
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return Wrap(
//           children: <Widget>[
//             ListTile(
//               leading: const Icon(AppDefaultIcons.ipAddress),
//               title: const Text(
//                 'IP Address',
//               ),
//               onTap: () async {
//                 Navigator.pop(context);
//                 showDialog(
//                     context: context,
//                     builder: (_) {
//                       return const ResponsiveLayout(
//                           mobileScaffold: SetupIpAddressFormWidget(),
//                           tabletScaffold: Row(
//                             children: [
//                               Spacer(),
//                               Expanded(
//                                 flex: 4,
//                                 child: SetupIpAddressFormWidget(),
//                               ),
//                               Spacer(),
//                             ],
//                           ),
//                           desktopScaffold: Row(
//                             children: [
//                               Spacer(),
//                               Expanded(
//                                 child: SetupIpAddressFormWidget(),
//                               ),
//                               Spacer()
//                             ],
//                           ));
//                     });
//               },
//             ),
//             ListTile(
//               leading: const Icon(AppDefaultIcons.qrCodeScanner),
//               title: const Text(
//                 'QR Code',
//               ),
//               onTap: () async {
//                 Navigator.pop(context);
//                 // FlutterBarcodeScanner.scanBarcode(
//                 //         "#000000", "Cancel", true, ScanMode.DEFAULT)
//                 //     .then((result) async {
//                 //   if (result != '-1') {
//                 //     connectionStorage.setIpAddress(ip: result);
//                 //     // Phoenix.rebirth(context);
//                 //   }
//                 // });
//               },
//             ),
//           ],
//         );
//       });
// }
