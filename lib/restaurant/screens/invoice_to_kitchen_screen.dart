import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:toastification/toastification.dart';
import '../../providers/app_provider.dart';
import '../../providers/printer_provider.dart';
import '../../router/route_utils.dart';
import '../../services/global_service.dart';
import '../../storages/printer_storage.dart';
import '../../utils/alert/alert.dart';
import '../../widgets/printer/printing_progress_widget.dart';
import '../models/sale/detail/sale_detail_model.dart';
import '../models/sale/invoice/print/order_list_by_station_model.dart';
import '../models/sale/invoice/print/printer_device_model.dart';
import '../models/sale/invoice/print/sale_invoice_to_kitchen_content_model.dart';
import '../providers/invoice/invoice_provider.dart';
import '../services/sale_service.dart';
import '../widgets/invoice-to-kitchen-template/invoice_to_kitchen_template_widget.dart';
import '../../widgets/loading_widget.dart';

class InvoiceToKitchenScreen extends StatefulWidget {
  final String invoiceId;
  final String branchId;
  final String orderNum;
  final String floorName;
  final String tableName;
  final List<String> saleDetailIds;
  final bool autoCloseAfterPrinted;
  const InvoiceToKitchenScreen({
    super.key,
    required this.invoiceId,
    required this.branchId,
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
  late AppProvider readAppProvider;
  late PrinterProvider readPrinterProvider;
  late InvoiceProvider readInvoiceProvider;
  late Future<SaleInvoiceToKitchenContentModel> saleInvoiceToKitchenContent;
  late PaperSize paperSize;
  socket_io.Socket? socket;
  @override
  void initState() {
    super.initState();
    readAppProvider = context.read<AppProvider>();
    readPrinterProvider = context.read<PrinterProvider>();
    readInvoiceProvider = context.read<InvoiceProvider>();
    saleInvoiceToKitchenContent = readInvoiceProvider.fetchPrintToKitchenInfo(
        branchId: widget.branchId,
        invoiceId: widget.invoiceId,
        saleDetailIds: widget.saleDetailIds,
        isMultiPrint: SaleService.isModuleActive(
            modules: ['multi-printers'], overpower: false, context: context));
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

    // get print info
    SaleInvoiceToKitchenContentModel printInfo =
        (await saleInvoiceToKitchenContent);
    if (printInfo.orderListByStation != null) {
      for (OrderListByStationModel station in printInfo.orderListByStation!) {
        final List<PrinterDeviceModel>? printers = station.devices;
        final String? ipAddress = station.ipAddress;
        if (printers == null || ipAddress == null) return;
        if (await socketConnection(ipAddress: ipAddress)) {
          if (!mounted) return;
          await socket?.emitWithAckAsync('do-print', {
            'type': 'Kitchen',
            'printers': printers,
            'copyCount': copyCount,
            'printInfo': {
              'data': {
                'orderNum': widget.orderNum,
                'tableName': widget.tableName,
                'templateMargin': printInfo.templateMargin,
                'orderList': station.details
              },
              'isSkipTable': SaleService.isModuleActive(
                  modules: ['skip-table'], overpower: false, context: context),
              'isShowOrderNum': SaleService.isModuleActive(
                  modules: ['order-number'],
                  overpower: false,
                  context: context),
            },
          }, ack: (result) {
            clearConnection();
            if (result['status'] == 'Error') {
              Alert.show(
                  type: ToastificationType.error,
                  description: '$prefixMultiPrinters.notFound.message',
                  descriptionNamedArgs: {
                    'printerName': station.devices![0].name
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
              descriptionNamedArgs: {'printerName': station.devices![0].name});
        }
      }
    }
  }

  Future<bool> socketConnection({required String ipAddress}) async {
    clearConnection();
    socket = socket_io.io(
        "http://$ipAddress:3222",
        socket_io.OptionBuilder()
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
      context.pop();
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
                      future: saleInvoiceToKitchenContent,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final List<SaleDetailModel> saleDetail =
                              snapshot.data?.orderList ?? [];
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
                        if (SaleService.isModuleActive(
                            modules: ['multi-printers'],
                            overpower: false,
                            context: context)) {
                          multiPrinters(copyCount: copyForChef);
                        } else {
                          GlobalService.openDialog(
                            contentWidget:
                                PrintingProgressWidget(copies: copyForChef),
                            context: context,
                          ).then((_) {
                            closePrintDialog();
                          });
                        }
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
