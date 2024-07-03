import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:restart_app/restart_app.dart';
import '../../router/route_utils.dart';
import '../../storages/connection_storage.dart';
import '../../utils/constants.dart';

class SetupIpAddressFormWidget extends StatefulWidget {
  const SetupIpAddressFormWidget({super.key});

  @override
  State<SetupIpAddressFormWidget> createState() =>
      _SetupIpAddressFormWidgetState();
}

class _SetupIpAddressFormWidgetState extends State<SetupIpAddressFormWidget> {
  final ConnectionStorage connectionStorage = ConnectionStorage();
  static final GlobalKey<FormBuilderState> _fbKey =
      GlobalKey<FormBuilderState>();
  final String prefixSettingForm = "screens.settings.form";
  late Future<String?> _getAsyncMethods;
  late String? currentIp;

  @override
  void initState() {
    super.initState();
    _getAsyncMethods = _asyncMethods();
  }

  Future<String?> _asyncMethods() async {
    return await connectionStorage.getIpAddress();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
      title: Text(
        context.tr(SCREENS.settings.toTitle),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder<String?>(
            future: _getAsyncMethods,
            builder: (context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              String? ip = snapshot.data ?? '';
              currentIp = ip;
              return FormBuilder(
                key: _fbKey,
                initialValue: {"ipAddress": ip},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: FormBuilderTextField(
                        name: "ipAddress",
                        decoration: InputDecoration(
                          labelText: '$prefixSettingForm.ipAddress.title'.tr(),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              FlutterBarcodeScanner.scanBarcode("#000000",
                                      "Cancel", true, ScanMode.DEFAULT)
                                  .then((result) async {
                                if (result != '-1') {
                                  connectionStorage.setIpAddress(ip: result);
                                  Restart.restartApp();
                                }
                              });
                            },
                            icon: const Icon(AppDefaultIcons.qrCodeScanner),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          (value) {
                            String? ipAddress = value;
                            if (ipAddress == currentIp) {
                              return "Please change to your new IP address.";
                            }

                            final splitted = ipAddress!.split(':');
                            String ip = splitted[0];
                            String port = "";

                            if (splitted.length >= 2) port = splitted[1];
                            RegExp exp = RegExp(
                              r"^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$",
                              caseSensitive: false,
                              multiLine: false,
                            );
                            if (!exp.hasMatch(ip)) return "Ip address invalid.";

                            if (port.isEmpty) return "Port is required.";

                            return null;
                          }
                        ]),
                      ),
                    ),
                    const SizedBox(width: AppStyleDefaultProperties.w),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          if (_fbKey.currentState!.saveAndValidate()) {
                            String ip =
                                '${_fbKey.currentState!.fields['ipAddress']!.value}';
                            connectionStorage.setIpAddress(ip: ip);
                            Restart.restartApp();
                          }
                        },
                        style: theme.filledButtonTheme.style!.copyWith(
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 16.0)),
                        ),
                        child: const Icon(AppDefaultIcons.submit),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              const Icon(AppDefaultIcons.info),
              const SizedBox(width: 5.0),
              Expanded(child: Text('$prefixSettingForm.ipAddress.info'.tr()))
            ],
          )
        ],
      ),
    );
  }
}
