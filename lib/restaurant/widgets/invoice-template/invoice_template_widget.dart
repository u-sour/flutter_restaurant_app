import 'package:flutter/material.dart';
import '../../models/exchange/exchange_model.dart';
import '../../models/invoice-template/description/description_left_right_schema_model.dart';
import '../../models/invoice-template/invoice_paper_model.dart';
import '../../models/invoice-template/invoice_template_model.dart';
import '../../models/sale/detail/sale_detail_model.dart';
import '../../models/sale/invoice/sale_invoice_for_print_model.dart';
import 'invoice_template_copy_right_widget.dart';
import 'invoice_template_description_widget.dart';
import 'invoice_template_footer_widget.dart';
import 'invoice_template_header_widget.dart';
import 'invoice_template_qr_code_widget.dart';
import 'invoice_template_signature_widget.dart';
import 'invoice_template_table_widget.dart';
import 'invoice_template_total_widget.dart';

class InvoiceTemplateWidget extends StatelessWidget {
  final String ipAddress;
  final bool receiptPrint;
  final InvoiceTemplateModel template;
  final SaleInvoiceForPrintModel sale;
  final ExchangeModel exchange;
  final List<SaleDetailModel> saleDetails;
  const InvoiceTemplateWidget({
    super.key,
    required this.ipAddress,
    required this.receiptPrint,
    required this.template,
    required this.sale,
    required this.exchange,
    required this.saleDetails,
  });

  @override
  Widget build(BuildContext context) {
    const Color baseColor = Colors.black;
    InvoicePaperModel invoicePaper = template.mini;
    List<DescriptionLeftRightSchemaModel> descriptionLeft =
        invoicePaper.descriptionSchema.left;
    List<DescriptionLeftRightSchemaModel> descriptionRight =
        invoicePaper.descriptionSchema.right;
    return Column(
      children: [
        // Header
        InvoiceTemplateHeaderWidget(
          ipAddress: ipAddress,
          headerSchema: invoicePaper.headerSchema,
          sale: sale,
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
                      showSubLabel: invoicePaper.descriptionSchema.showSubLabel,
                      description: descriptionLeft[i],
                      labelStyle: invoicePaper.descriptionSchema.labelStyle,
                      subLabelStyle:
                          invoicePaper.descriptionSchema.subLabelStyle,
                      valueStyle: invoicePaper.descriptionSchema.valueStyle,
                      sale: sale,
                      exchange: exchange,
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
                      showSubLabel: invoicePaper.descriptionSchema.showSubLabel,
                      description: descriptionRight[i],
                      labelStyle: invoicePaper.descriptionSchema.labelStyle,
                      subLabelStyle:
                          invoicePaper.descriptionSchema.subLabelStyle,
                      valueStyle: invoicePaper.descriptionSchema.valueStyle,
                      sale: sale,
                      exchange: exchange,
                      receiptPrint: receiptPrint,
                    ),
                ],
              ),
            ),
          ],
        ),
        // Table
        InvoiceTemplateTableWidget(
          tableSchema: invoicePaper.tableSchema,
          saleDetails: saleDetails,
        ),
        // Total
        InvoiceTemplateTotalWidget(
          totalSchema: invoicePaper.totalSchema,
          sale: sale,
        ),
        // Signature
        InvoiceTemplateSignatureWidget(
            signatureSchema: invoicePaper.signatureSchema),
        // QrCode
        InvoiceTemplateQrCodeWidget(
          ipAddress: ipAddress,
          qrCodeSchema: invoicePaper.qrCodeSchema,
        ),
        // Footer
        InvoiceTemplateFooterWidget(
            footerSchema: invoicePaper.footerTextSchema),
        // Copyright
        const InvoiceTemplateCopyRightWidget()
      ],
    );
  }
}
