import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import '../../models/invoice-template/description/description_left_right_schema_model.dart';
import '../../models/invoice-template/invoice_paper_model.dart';
import '../../models/invoice-template/invoice_template_model.dart';
import '../../models/sale/invoice/print/sale_invoice_content_model.dart';
import 'invoice_template_copy_right_widget.dart';
import 'invoice_template_description_widget.dart';
import 'invoice_template_footer_widget.dart';
import 'invoice_template_header_widget.dart';
import 'invoice_template_qr_code_widget.dart';
import 'invoice_template_signature_widget.dart';
import 'invoice_template_table_widget.dart';
import 'invoice_template_total_widget.dart';

class InvoiceTemplateWidget extends StatelessWidget {
  final PaperSize paperSize;
  final String ipAddress;
  final String? receiptId;
  final bool receiptPrint;
  final bool isRepaid;
  final InvoiceTemplateModel template;
  final SaleInvoiceContentModel saleInvoiceContent;

  const InvoiceTemplateWidget({
    super.key,
    required this.paperSize,
    required this.ipAddress,
    this.receiptId,
    required this.receiptPrint,
    required this.isRepaid,
    required this.template,
    required this.saleInvoiceContent,
  });

  @override
  Widget build(BuildContext context) {
    const Color baseColor = Colors.black;
    InvoicePaperModel invoicePaper = template.mini;
    List<DescriptionLeftRightSchemaModel> descriptionLeft =
        invoicePaper.descriptionSchema.left;
    List<DescriptionLeftRightSchemaModel> descriptionRight =
        invoicePaper.descriptionSchema.right;
    return Stack(
      children: [
        Column(
          children: [
            // Header
            InvoiceTemplateHeaderWidget(
              paperSize: paperSize,
              ipAddress: ipAddress,
              headerSchema: invoicePaper.headerSchema,
              sale: saleInvoiceContent.saleDoc,
            ),
            const Divider(color: baseColor),
            // Description
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description Left
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < descriptionLeft.length; i++)
                        InvoiceTemplateDescriptionWidget(
                          paperSize: paperSize,
                          showSubLabel:
                              invoicePaper.descriptionSchema.showSubLabel,
                          description: descriptionLeft[i],
                          labelStyle: invoicePaper.descriptionSchema.labelStyle,
                          subLabelStyle:
                              invoicePaper.descriptionSchema.subLabelStyle,
                          valueStyle: invoicePaper.descriptionSchema.valueStyle,
                          sale: saleInvoiceContent.saleDoc,
                          paymentBy:
                              saleInvoiceContent.receiptDoc?.paymentBy ?? '',
                          exchange: saleInvoiceContent.exchangeDoc,
                          receiptPrint: receiptPrint,
                        ),
                    ],
                  ),
                ),
                // Description Right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < descriptionRight.length; i++)
                        InvoiceTemplateDescriptionWidget(
                          paperSize: paperSize,
                          showSubLabel:
                              invoicePaper.descriptionSchema.showSubLabel,
                          description: descriptionRight[i],
                          labelStyle: invoicePaper.descriptionSchema.labelStyle,
                          subLabelStyle:
                              invoicePaper.descriptionSchema.subLabelStyle,
                          valueStyle: invoicePaper.descriptionSchema.valueStyle,
                          sale: saleInvoiceContent.saleDoc,
                          paymentBy:
                              saleInvoiceContent.receiptDoc?.paymentBy ?? '',
                          exchange: saleInvoiceContent.exchangeDoc,
                          receiptPrint: receiptPrint,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            // Table
            InvoiceTemplateTableWidget(
              paperSize: paperSize,
              tableSchema: invoicePaper.tableSchema,
              saleDetails: saleInvoiceContent.orderList,
            ),
            // Total
            InvoiceTemplateTotalWidget(
              paperSize: paperSize,
              totalSchema: invoicePaper.totalSchema,
              saleInvoiceContent: saleInvoiceContent,
              isPaid: saleInvoiceContent.receiptDoc != null ? true : false,
              isRepaid: isRepaid,
            ),
            // Signature
            InvoiceTemplateSignatureWidget(
                paperSize: paperSize,
                signatureSchema: invoicePaper.signatureSchema),
            // QrCode
            InvoiceTemplateQrCodeWidget(
              paperSize: paperSize,
              ipAddress: ipAddress,
              qrCodeSchema: invoicePaper.qrCodeSchema,
            ),
            // Footer
            InvoiceTemplateFooterWidget(
                paperSize: paperSize,
                footerSchema: invoicePaper.footerTextSchema),
            // Copyright
            InvoiceTemplateCopyRightWidget(paperSize: paperSize)
          ],
        ),
        if (saleInvoiceContent.saleDoc.status == 'Cancel')
          Positioned.fill(
              child: Image.asset('assets/images/invoice/canceled.png')),
      ],
    );
  }
}
