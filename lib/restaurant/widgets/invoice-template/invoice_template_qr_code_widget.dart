import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import '../../../utils/constants.dart';
import '../../models/invoice-template/qr-code/qr_code_list_schema_model.dart';
import '../../models/invoice-template/qr-code/qr_code_schema_model.dart';
import 'invoice_template_cached_img_widget.dart';

class InvoiceTemplateQrCodeWidget extends StatelessWidget {
  final PaperSize paperSize;
  final String ipAddress;
  final QrCodeSchemaModel qrCodeSchema;
  const InvoiceTemplateQrCodeWidget({
    super.key,
    required this.paperSize,
    required this.ipAddress,
    required this.qrCodeSchema,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    List<QrCodeListSchemaModel> qrCodes = qrCodeSchema.list;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: qrCodeSchema.containerStyle.marginTop ?? 0.0),
          child: Row(
            children: [
              for (int i = 0; i < qrCodes.length; i++)
                Expanded(
                    child: Column(
                  children: [
                    // Bank Name
                    Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              qrCodeSchema.bankNameStyle.paddingBottom ?? 0.0),
                      child: Text(
                        qrCodes[i].bankName,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: baseColor,
                          fontSize: paperSize == PaperSize.mm80 &&
                                  qrCodeSchema.bankNameStyle.fontSize != null
                              ? qrCodeSchema.bankNameStyle.fontSize! +
                                  AppStyleDefaultProperties.iefs
                              : qrCodeSchema.bankNameStyle.fontSize,
                          fontWeight:
                              qrCodeSchema.bankNameStyle.fontWeight != null &&
                                      qrCodeSchema.bankNameStyle.fontWeight ==
                                          'bold'
                                  ? FontWeight.bold
                                  : null,
                        ),
                      ),
                    ),
                    // Qr Code
                    InvoiceTemplateCachedImgWidget(
                      ipAddress: ipAddress,
                      imgUrl: qrCodes[i].imageUrl!,
                      width: qrCodeSchema.imagePanelStyle.width ?? 0.0,
                      height: qrCodeSchema.imagePanelStyle.width ?? 0.0,
                      margin: EdgeInsets.only(
                          bottom:
                              qrCodeSchema.imagePanelStyle.marginBottom ?? 0.0),
                    ),
                    // Account Name
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: qrCodeSchema.accountNameStyle.paddingBottom ??
                              0.0),
                      child: Text(
                        qrCodes[i].accountName,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: baseColor,
                          fontSize: paperSize == PaperSize.mm80 &&
                                  qrCodeSchema.accountNameStyle.fontSize != null
                              ? qrCodeSchema.accountNameStyle.fontSize! +
                                  AppStyleDefaultProperties.iefs
                              : qrCodeSchema.bankNameStyle.fontSize,
                          fontWeight: qrCodeSchema
                                          .accountNameStyle.fontWeight !=
                                      null &&
                                  qrCodeSchema.accountNameStyle.fontWeight ==
                                      'bold'
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    ),
                    // Account Number
                    Text(
                      qrCodes[i].accountNumber,
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: baseColor,
                        fontSize: paperSize == PaperSize.mm80 &&
                                qrCodeSchema.accountNumberStyle.fontSize != null
                            ? qrCodeSchema.accountNumberStyle.fontSize! +
                                AppStyleDefaultProperties.iefs
                            : qrCodeSchema.accountNumberStyle.fontSize,
                        fontWeight: qrCodeSchema
                                        .accountNumberStyle.fontWeight !=
                                    null &&
                                qrCodeSchema.accountNumberStyle.fontWeight ==
                                    'bold'
                            ? FontWeight.bold
                            : null,
                      ),
                    ),
                  ],
                ))
            ],
          ),
        )
      ],
    );
  }
}
