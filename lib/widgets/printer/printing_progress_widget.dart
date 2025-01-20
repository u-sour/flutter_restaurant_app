import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../models/servers/response_model.dart';
import '../../providers/printer_provider.dart';
import '../../utils/alert/alert.dart';

class PrintingProgressWidget extends StatefulWidget {
  final int copies;
  const PrintingProgressWidget({super.key, this.copies = 1});

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
    late ResponseModel result;
    for (int i = 0; i < widget.copies; i++) {
      result = await readPrinterProvider.btPrinterPrinting();
    }
    if (!mounted) return;
    context.pop();
    Alert.show(description: result.description, type: result.type);
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
