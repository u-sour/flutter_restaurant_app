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
import '../../utils/alert/alert.dart';
import '../../widgets/printer/printing_progress_widget.dart';
import '../models/invoice-template/invoice_template_model.dart';
import '../models/sale/invoice/print/sale_invoice_content_model.dart';
import '../models/sale/setting/sale_setting_model.dart';
import '../providers/invoice-template/invoice_template_provider.dart';
import '../providers/invoice/invoice_provider.dart';
import '../providers/sale/sale_provider.dart';
import '../widgets/invoice-template/invoice_template_widget.dart';
import '../widgets/invoice/app-bar/invoice_app_bar_widget.dart';
import '../../widgets/loading_widget.dart';

class InvoiceScreen extends StatefulWidget {
  final String? tableId;
  final String invoiceId;
  final String? receiptId;
  final bool fromReceiptForm;
  final bool fromDashboard;
  final bool receiptPrint;
  final bool isTotal;
  final bool isRepaid;
  final bool showEditInvoiceBtn;
  final bool autoCloseAfterPrinted;
  const InvoiceScreen({
    super.key,
    this.tableId,
    required this.invoiceId,
    this.receiptId,
    required this.fromReceiptForm,
    required this.fromDashboard,
    required this.receiptPrint,
    required this.isTotal,
    required this.isRepaid,
    required this.showEditInvoiceBtn,
    this.autoCloseAfterPrinted = false,
  });

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late SaleProvider readSaleProvider;
  late InvoiceProvider readInvoiceProvider;
  late PrinterProvider readPrinterProvider;
  late InvoiceTemplateProvider readInvoiceTemplateProvider;
  late Future<InvoiceTemplateModel> invoiceTemplate;
  late Future<SaleInvoiceContentModel> saleInvoiceContent;
  final String prefixPrinterBtn = 'screens.printer.btn';
  late PaperSize paperSize;

  @override
  void initState() {
    super.initState();
    readSaleProvider = context.read<SaleProvider>();
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: InvoiceAppBarWidget(
          title: SCREENS.printer.toTitle,
          tableId: widget.tableId,
          isSkipTable: readSaleProvider.isSkipTable,
          fromReceiptForm: widget.fromReceiptForm,
          fromDashboard: widget.fromDashboard,
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
                      future: Future.wait([
                        invoiceTemplate,
                        saleInvoiceContent,
                        // exchange, saleDetails
                      ]),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final String ipAddress =
                              readInvoiceProvider.ipAddress;
                          final InvoiceTemplateModel template =
                              snapshot.data![0];
                          final SaleInvoiceContentModel saleInvoiceContent =
                              snapshot.data![1];
                          return InvoiceTemplateWidget(
                            paperSize: paperSize,
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
                    // Edit invoice (cancel & copy)
                    // Note: enable when sale setting allow to edit Invoice 'active'
                    Selector<AppProvider, SaleSettingModel>(
                        selector: (context, state) => state.saleSetting,
                        builder: (context, saleSetting, child) {
                          return saleSetting.sale.editableInvoice != false &&
                                  widget.showEditInvoiceBtn
                              ? Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final result =
                                          await readSaleProvider.cancelSale(
                                              context: context,
                                              copy: true,
                                              editableInvoice: saleSetting
                                                      .sale.editableInvoice !=
                                                  false,
                                              invoiceId: widget.invoiceId);
                                      if (result != null) {
                                        late SnackBar snackBar;
                                        snackBar = Alert.awesomeSnackBar(
                                            message: result.message,
                                            type: result.type);
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(snackBar);
                                      }
                                    },
                                    child: Text('$prefixPrinterBtn.edit'.tr(),
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }),
                    // Print
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          // Get copies sale setting from backend and check invoice print from sale receipt form or normal
                          AppProvider readAppProvider =
                              context.read<AppProvider>();
                          int copyForBill =
                              readAppProvider.saleSetting.invoice.copyForBill ??
                                  1;
                          int copyForPayment = readAppProvider
                                  .saleSetting.invoice.copyForPayment ??
                              1;
                          await GlobalService.openDialog(
                            contentWidget: PrintingProgressWidget(
                                copies: widget.fromReceiptForm
                                    ? copyForPayment
                                    : copyForBill),
                            context: context,
                          ).then((_) {
                            if (context.mounted &&
                                widget.autoCloseAfterPrinted) {
                              if (widget.fromReceiptForm &&
                                  !widget.fromDashboard &&
                                  (readSaleProvider.isSkipTable != null &&
                                      readSaleProvider.isSkipTable == true) &&
                                  widget.tableId != null) {
                                context.goNamed(SCREENS.sale.toName,
                                    queryParameters: {
                                      'table': widget.tableId,
                                      'fastSale': 'false'
                                    });
                              } else if (widget.fromReceiptForm &&
                                  !widget.fromDashboard &&
                                  (readSaleProvider.isSkipTable != null &&
                                      readSaleProvider.isSkipTable == false)) {
                                context.goNamed(SCREENS.saleTable.toName);
                              } else if (widget.fromReceiptForm &&
                                  widget.fromDashboard) {
                                context.goNamed(SCREENS.dashboard.toName);
                              } else {
                                context.pop();
                              }
                            }
                          });
                        },
                        child: Text('$prefixPrinterBtn.print'.tr(),
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
      ),
    );
  }
}
