import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import '../../providers/app_provider.dart';
import '../../providers/printer_provider.dart';
import '../../router/route_utils.dart';
import '../../services/global_service.dart';
import '../../storages/printer_storage.dart';
import '../../utils/alert/alert.dart';
import '../../widgets/printer/printing_progress_widget.dart';
import '../models/department/department_model.dart';
import '../models/invoice-template/invoice_template_model.dart';
import '../models/sale/invoice/print/sale_invoice_content_model.dart';
import '../models/sale/setting/sale_setting_model.dart';
import '../providers/invoice-template/invoice_template_provider.dart';
import '../providers/invoice/invoice_provider.dart';
import '../providers/sale/sale_provider.dart';
import '../services/sale_service.dart';
import '../widgets/invoice-template/invoice_template_widget.dart';
import '../widgets/invoice/app-bar/invoice_app_bar_widget.dart';
import '../../widgets/loading_widget.dart';

class InvoiceScreen extends StatefulWidget {
  final String? tableId;
  final String invoiceId;
  final String branchId;
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
    required this.branchId,
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
  late AppProvider readAppProvider;
  late SaleProvider readSaleProvider;
  late InvoiceProvider readInvoiceProvider;
  late PrinterProvider readPrinterProvider;
  late InvoiceTemplateProvider readInvoiceTemplateProvider;
  late Future<InvoiceTemplateModel> invoiceTemplate;
  late Future<SaleInvoiceContentModel> saleInvoiceContent;
  final String prefixPrinterBtn = 'screens.printer.btn';
  late PaperSize paperSize;
  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    readAppProvider = context.read<AppProvider>();
    readSaleProvider = context.read<SaleProvider>();
    readInvoiceProvider = context.read<InvoiceProvider>();
    readPrinterProvider = context.read<PrinterProvider>();
    readInvoiceTemplateProvider = context.read<InvoiceTemplateProvider>();
    invoiceTemplate =
        readInvoiceTemplateProvider.getInvoiceTemplate(context: context);
    saleInvoiceContent = readInvoiceProvider.fetchInvoiceContentData(
        invoiceId: widget.invoiceId,
        branchId: widget.branchId,
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

  void multiPrinters({required int copyCount}) async {
    // alert prefix for multi printers
    const String prefixMultiPrinters = 'screens.multiPrinters.alert';

    // get printers by department
    final DepartmentModel? department = readAppProvider.selectedDepartment;
    if (department != null) {
      List<dynamic> printers = await readInvoiceProvider.fetchPrinterGroupByIP(
          printerIds: widget.fromReceiptForm
              ? department.printerForPayment!
              : department.printerForBill!);
      // get print info
      Map<String, dynamic> printInfo = (await saleInvoiceContent).toJson();
      printInfo['saleDoc']['date'] = printInfo['saleDoc']['date'].toString();
      printInfo['exchangeDoc']['exDate'] =
          printInfo['exchangeDoc']['exDate'].toString();
      if (printInfo['receiptDoc'] != null) {
        printInfo['receiptDoc']['date'] =
            printInfo['receiptDoc']['date'].toString();
      }

      for (dynamic printer in printers) {
        if (await socketConnection(printer: printer)) {
          await socket?.emitWithAckAsync('do-print', {
            'type': 'Invoice',
            'printers': printer['devices'],
            'copyCount': copyCount,
            'printInfo': {
              'data': jsonEncode(printInfo),
            },
          }, ack: (result) {
            clearConnection();
            if (result['status'] == 'Error') {
              Alert.show(
                  type: ToastificationType.error,
                  description: '$prefixMultiPrinters.notFound.message',
                  descriptionNamedArgs: {
                    'printerName': printer['devices'][0]['name']
                  });
            } else {
              Alert.show(
                type: ToastificationType.success,
                description: '$prefixMultiPrinters.success.message',
              );
            }
            closePrintDialog();
          });
        } else {
          clearConnection();
          Alert.show(
              type: ToastificationType.error,
              description: '$prefixMultiPrinters.noConnect.message',
              descriptionNamedArgs: {
                'printerName': printer['devices'][0]['name']
              });
        }
      }
    }
  }

  Future<bool> socketConnection({required printer}) async {
    clearConnection();
    socket = IO.io(
        "http://${printer['ipAddress']}:3222",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableReconnection()
            .build());

    Completer<bool> completer = Completer();

    socket?.on('connect', (data) {
      completer.complete(true);
    });

    socket?.on('connect_error', (data) {
      completer.complete(false);
    });

    return completer.future;
  }

  void clearConnection() {
    socket?.clearListeners();
    socket?.close();
    socket = null;
  }

  void closePrintDialog() {
    if (context.mounted && widget.autoCloseAfterPrinted) {
      if (widget.fromReceiptForm &&
          !widget.fromDashboard &&
          (readSaleProvider.isSkipTable != null &&
              readSaleProvider.isSkipTable == true) &&
          widget.tableId != null) {
        context.goNamed(SCREENS.sale.toName,
            queryParameters: {'table': widget.tableId, 'fastSale': 'false'});
      } else if (widget.fromReceiptForm &&
          !widget.fromDashboard &&
          (readSaleProvider.isSkipTable != null &&
              readSaleProvider.isSkipTable == false)) {
        context.goNamed(SCREENS.saleTable.toName);
      } else if (widget.fromReceiptForm && widget.fromDashboard) {
        context.goNamed(SCREENS.dashboard.toName);
      } else {
        context.pop();
      }
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
                                        Alert.show(
                                            description: result.description,
                                            type: result.type);
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
                          // Multi Printers
                          if (SaleService.isModuleActive(
                              modules: ['multi-printers'],
                              overpower: false,
                              context: context)) {
                            multiPrinters(
                                copyCount: widget.fromReceiptForm
                                    ? copyForPayment
                                    : copyForBill);
                          } else {
                            // Bluetooth Printer
                            await GlobalService.openDialog(
                              contentWidget: PrintingProgressWidget(
                                  copies: widget.fromReceiptForm
                                      ? copyForPayment
                                      : copyForBill),
                              context: context,
                            ).then((_) {
                              closePrintDialog();
                            });
                          }
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
