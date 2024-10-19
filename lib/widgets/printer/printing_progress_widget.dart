import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/printer_provider.dart';
import '../../utils/alert/alert.dart';

class PrintingProgressWidget extends StatefulWidget {
  const PrintingProgressWidget({super.key});

  @override
  State<PrintingProgressWidget> createState() => _PrintingProgressWidgetState();
}

class _PrintingProgressWidgetState extends State<PrintingProgressWidget> {
  late PrinterProvider readPrinterProvider;
  final String dialogPrinterPrefix = 'screens.printer.dialog';
  @override
  void initState() {
    super.initState();
    readPrinterProvider = context.read<PrinterProvider>();
    readPrinterProvider.init();
    _asyncMethods();
  }

  _asyncMethods() async {
    late SnackBar snackBar;
    final result = await readPrinterProvider.btPrinterPrinting();
    if (!mounted) return;
    Navigator.of(context).pop();
    snackBar =
        Alert.awesomeSnackBar(message: result.message, type: result.type);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$dialogPrinterPrefix.title').tr(),
      content: Selector<PrinterProvider, double>(
          selector: (context, state) => state.progress,
          builder: (context, progress, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade200,
                ),
                const SizedBox(height: 4),
                Text('$dialogPrinterPrefix.Processing').tr(
                    namedArgs: {"progress": '${((progress) * 100).round()}'}),
              ],
            );
          }),
    );
  }
}
