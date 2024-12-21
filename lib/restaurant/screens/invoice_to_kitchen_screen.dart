import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../providers/printer_provider.dart';
import '../../router/route_utils.dart';
import '../../services/global_service.dart';
import '../../storages/printer_storage.dart';
import '../../widgets/printer/printing_progress_widget.dart';
import '../models/sale/detail/sale_detail_model.dart';
import '../providers/invoice/invoice_provider.dart';
import '../widgets/invoice-to-kitchen-template/invoice_to_kitchen_template_widget.dart';
import '../../widgets/loading_widget.dart';

class InvoiceToKitchenScreen extends StatefulWidget {
  final String invoiceId;
  final String orderNum;
  final String floorName;
  final String tableName;
  final List<String> saleDetailIds;
  final bool autoCloseAfterPrinted;
  const InvoiceToKitchenScreen({
    super.key,
    required this.invoiceId,
    required this.orderNum,
    required this.floorName,
    required this.tableName,
    required this.saleDetailIds,
    this.autoCloseAfterPrinted = false,
  });

  @override
  State<InvoiceToKitchenScreen> createState() => _InvoiceToKitchenScreenState();
}

class _InvoiceToKitchenScreenState extends State<InvoiceToKitchenScreen> {
  late PrinterProvider readPrinterProvider;
  late InvoiceProvider readInvoiceProvider;
  late Future<List<SaleDetailModel>> saleDetail;
  late PaperSize paperSize;

  @override
  void initState() {
    super.initState();
    readPrinterProvider = context.read<PrinterProvider>();
    readInvoiceProvider = context.read<InvoiceProvider>();
    saleDetail = readInvoiceProvider.fetchOrderListByIds(
        invoiceId: widget.invoiceId, saleDetailIds: widget.saleDetailIds);
    _asyncMethod();
  }

  Future<void> _asyncMethod() async {
    // Check & set printer paper size
    final PrinterStorage printerStorage = PrinterStorage();
    final String printerPaperSize = await printerStorage.getPrinterPaperSize();
    switch (printerPaperSize) {
      case '80mm':
        paperSize = PaperSize.mm80;
        break;
      default:
        paperSize = PaperSize.mm58;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(SCREENS.printer.toTitle.tr()),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Receipt(
                  backgroundColor: Colors.grey.shade200,
                  onInitialized: (controller) async {
                    controller.paperSize = paperSize;
                    readPrinterProvider.controller = controller;
                  },
                  builder: (context) => FutureBuilder(
                      future: saleDetail,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final List<SaleDetailModel> saleDetail =
                              snapshot.data!;
                          return InvoiceToKitchenTemplateWidget(
                            paperSize: paperSize,
                            invoiceId: widget.invoiceId,
                            orderNum: widget.orderNum,
                            floorName: widget.floorName,
                            tableName: widget.tableName,
                            saleDetail: saleDetail,
                          );
                        } else {
                          return const LoadingWidget();
                        }
                      }))),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Get copies sale setting from backend
                        AppProvider readAppProvider =
                            context.read<AppProvider>();
                        int copyForChef =
                            readAppProvider.saleSetting.invoice.copyForChef ??
                                1;
                        GlobalService.openDialog(
                          contentWidget:
                              PrintingProgressWidget(copies: copyForChef),
                          context: context,
                        ).then((_) {
                          if (context.mounted && widget.autoCloseAfterPrinted) {
                            context.pop();
                          }
                        });
                      },
                      child: Text('screens.printer.btn.print'.tr(),
                          style: theme.textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
