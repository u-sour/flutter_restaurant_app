import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_template/providers/setting_provider.dart';
import 'package:flutter_template/router/route_utils.dart';
import 'package:flutter_template/storages/printer_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';

class ChangePrinterFontSizeFormWidget extends StatefulWidget {
  const ChangePrinterFontSizeFormWidget({super.key});

  @override
  State<ChangePrinterFontSizeFormWidget> createState() =>
      _ChangePrinterFontSizeFormWidgetState();
}

class _ChangePrinterFontSizeFormWidgetState
    extends State<ChangePrinterFontSizeFormWidget> {
  final PrinterStorage printerStorage = PrinterStorage();
  static final GlobalKey<FormBuilderState> _fbKey =
      GlobalKey<FormBuilderState>();
  final String prefixSettingForm = "screens.settings.form";
  late Future<double> _getAsyncMethods;

  @override
  void initState() {
    super.initState();
    _getAsyncMethods = _asyncMethods();
  }

  Future<double> _asyncMethods() async {
    return await printerStorage.getPrinterFontSize();
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
          FutureBuilder<double>(
            future: _getAsyncMethods,
            builder: (context, AsyncSnapshot<double> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              double printerFontSize = snapshot.data ?? 20.0;
              return FormBuilder(
                key: _fbKey,
                initialValue: {"printerFontSize": printerFontSize.toString()},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: FormBuilderTextField(
                        name: "printerFontSize",
                        decoration: InputDecoration(
                          labelText:
                              '$prefixSettingForm.printer.printerFontSize.title'
                                  .tr(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric()
                        ]),
                      ),
                    ),
                    const SizedBox(width: AppStyleDefaultProperties.w),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          if (_fbKey.currentState!.saveAndValidate()) {
                            double fontSize = double.parse(_fbKey.currentState!
                                .fields['printerFontSize']!.value);
                            context
                                .read<SettingProvider>()
                                .setPrinterFontSize(fontSize: fontSize);
                            context.pop();
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
        ],
      ),
    );
  }
}
