import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:provider/provider.dart';
import '../../providers/printer_provider.dart';
import '../../router/route_utils.dart';
import '../../services/global_service.dart';
import '../../widgets/printer/printing_progress_widget.dart';
import '../models/invoice-template/invoice_template_model.dart';
import '../models/sale/invoice/print/sale_invoice_content_model.dart';
import '../providers/invoice-template/invoice_template_provider.dart';
import '../providers/invoice/invoice_provider.dart';
import '../widgets/invoice-template/invoice_template_widget.dart';
import '../widgets/invoice/app-bar/invoice_app_bar_widget.dart';
import '../widgets/loading_widget.dart';

class InvoiceScreen extends StatefulWidget {
  final String invoiceId;
  final String? receiptId;
  final bool fromReceiptForm;
  final bool fromDashboard;
  final bool receiptPrint;
  final bool isTotal;
  final bool isRepaid;
  const InvoiceScreen({
    super.key,
    required this.invoiceId,
    this.receiptId,
    required this.fromReceiptForm,
    required this.fromDashboard,
    required this.receiptPrint,
    required this.isTotal,
    required this.isRepaid,
  });

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late InvoiceProvider readInvoiceProvider;
  late PrinterProvider readPrinterProvider;
  late InvoiceTemplateProvider readInvoiceTemplateProvider;
  late Future<InvoiceTemplateModel> invoiceTemplate;
  late Future<SaleInvoiceContentModel> saleInvoiceContent;

  @override
  void initState() {
    super.initState();
    readInvoiceProvider = context.read<InvoiceProvider>();
    readPrinterProvider = context.read<PrinterProvider>();
    readInvoiceTemplateProvider = context.read<InvoiceTemplateProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readInvoiceProvider.initData(context: context);
    });
    invoiceTemplate =
        readInvoiceTemplateProvider.getInvoiceTemplate(context: context);
    saleInvoiceContent = readInvoiceProvider.fetchInvoiceContentData(
        invoiceId: widget.invoiceId,
        receiptId: widget.receiptId,
        receiptPrint: widget.receiptPrint,
        isTotal: widget.isTotal,
        isRepaid: widget.isRepaid,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InvoiceAppBarWidget(
        title: SCREENS.printer.toTitle,
        fromReceiptForm: widget.fromReceiptForm,
        fromDashboard: widget.fromDashboard,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Receipt(
                backgroundColor: Colors.grey.shade200,
                onInitialized: (controller) {
                  readPrinterProvider.controller = controller;
                },
                builder: (context) => FutureBuilder(
                    future: Future.wait([
                      invoiceTemplate,
                      saleInvoiceContent,
                      // exchange, saleDetails
                    ]),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final String ipAddress = readInvoiceProvider.ipAddress;
                        final InvoiceTemplateModel template = snapshot.data![0];
                        final SaleInvoiceContentModel saleInvoiceContent =
                            snapshot.data![1];
                        return InvoiceTemplateWidget(
                          ipAddress: ipAddress,
                          receiptPrint: widget.receiptPrint,
                          isRepaid: widget.isRepaid,
                          receiptId: widget.receiptId,
                          template: template,
                          saleInvoiceContent: saleInvoiceContent,
                        );
                      } else {
                        return const LoadingWidget();
                      }
                    })),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        GlobalService.openDialog(
                          contentWidget: const PrintingProgressWidget(),
                          context: context,
                        );
                      },
                      child: Text('screens.printer.btn'.tr()),
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
