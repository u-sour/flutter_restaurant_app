import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:provider/provider.dart';
import '../../providers/printer_provider.dart';
import '../../router/route_utils.dart';
import '../../services/global_service.dart';
import '../../widgets/printer/printing_progress_widget.dart';
import '../models/exchange/exchange_model.dart';
import '../models/invoice-template/invoice_template_model.dart';
import '../models/sale/detail/sale_detail_model.dart';
import '../models/sale/invoice/sale_invoice_for_print_model.dart';
import '../providers/invoice-template/invoice_template_provider.dart';
import '../providers/invoice/invoice_provider.dart';
import '../providers/sale/products/sale_products_provider.dart';
import '../widgets/invoice-template/invoice_template_widget.dart';
import '../widgets/invoice/app-bar/invoice_app_bar_widget.dart';
import '../widgets/loading_widget.dart';

class InvoiceScreen extends StatefulWidget {
  final String invoiceId;
  final bool receiptPrint;
  const InvoiceScreen(
      {super.key, required this.invoiceId, required this.receiptPrint});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late InvoiceProvider readInvoiceProvider;
  late SaleProductsProvider readSaleProductProvider;
  late PrinterProvider readPrinterProvider;
  late InvoiceTemplateProvider readInvoiceTemplateProvider;
  late Future<SaleInvoiceForPrintModel> sale;
  late Future<ExchangeModel> exchange;
  late Future<List<SaleDetailModel>> saleDetails;
  late Future<InvoiceTemplateModel> invoiceTemplate;

  @override
  void initState() {
    super.initState();
    readInvoiceProvider = context.read<InvoiceProvider>();
    readSaleProductProvider = context.read<SaleProductsProvider>();
    readPrinterProvider = context.read<PrinterProvider>();
    readInvoiceTemplateProvider = context.read<InvoiceTemplateProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readInvoiceProvider.initData(context: context);
    });
    invoiceTemplate =
        readInvoiceTemplateProvider.getInvoiceTemplate(context: context);
    sale = readInvoiceProvider.fetchInvoiceData(
        invoiceId: widget.invoiceId,
        receiptPrint: widget.receiptPrint,
        context: context);
    exchange = readInvoiceProvider.findOneExchange();
    saleDetails =
        readInvoiceProvider.fetchSaleDetails(invoiceId: widget.invoiceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InvoiceAppBarWidget(title: SCREENS.printer.toTitle),
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
                    future: Future.wait(
                        [invoiceTemplate, sale, exchange, saleDetails]),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final String ipAddress =
                            readSaleProductProvider.ipAddress;
                        final InvoiceTemplateModel template = snapshot.data![0];
                        final SaleInvoiceForPrintModel sale = snapshot.data![1];
                        final ExchangeModel exchange = snapshot.data![2];
                        final List<SaleDetailModel> saleDetails =
                            snapshot.data![3];
                        return InvoiceTemplateWidget(
                          ipAddress: ipAddress,
                          receiptPrint: widget.receiptPrint,
                          template: template,
                          sale: sale,
                          exchange: exchange,
                          saleDetails: saleDetails,
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
