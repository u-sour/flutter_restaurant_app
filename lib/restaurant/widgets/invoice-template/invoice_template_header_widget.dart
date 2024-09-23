import 'package:flutter/material.dart';
import '../../models/invoice-template/header/header_list_schema_model.dart';
import '../../models/invoice-template/header/header_schema_model.dart';
import '../../models/sale/invoice/print/sale_invoice_for_print_model.dart';
import '../../utils/sale/sale_utils.dart';
import 'invoice_template_cached_img_widget.dart';

class InvoiceTemplateHeaderWidget extends StatelessWidget {
  final String ipAddress;
  final HeaderSchemaModel headerSchema;
  final SaleInvoiceForPrintModel sale;
  const InvoiceTemplateHeaderWidget({
    super.key,
    required this.ipAddress,
    required this.headerSchema,
    required this.sale,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    List<HeaderListSchemaModel> headers = headerSchema.list;
    return Column(
      children: [
        for (int i = 0; i < headers.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Type : Logo
              if (headers[i].type == 'logo' && headers[i].imageUrl != null)
                InvoiceTemplateCachedImgWidget(
                  ipAddress: ipAddress,
                  imgUrl: headers[i].imageUrl!,
                  width: headers[i].valueStyle.width ?? 0.0,
                  height: headers[i].valueStyle.width ?? 0.0,
                  margin: EdgeInsetsDirectional.only(
                      top: headers[i].wrapperStyle?.marginTop ?? 0.0),
                  borderRadius: convertValueFromCSS(
                      value: headers[i].valueStyle.borderRadius!),
                ),
              // Type: Header
              if (headers[i].isVisible != null && headers[i].isVisible == true)
                RichText(
                  // Label
                  text: TextSpan(
                      text: headers[i].label,
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: baseColor,
                          fontSize: headers[i].labelStyle?.fontSize,
                          fontWeight: headers[i].labelStyle?.fontWeight !=
                                      null &&
                                  headers[i].labelStyle?.fontWeight == 'bold'
                              ? FontWeight.bold
                              : null),
                      children: [
                        // Value
                        WidgetSpan(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: headers[i].labelStyle?.marginRight ?? 0.0,
                                top: headers[i].valueStyle.marginTop ?? 0.0),
                            child: Text(
                              headers[i].field == 'tableName' ||
                                      headers[i].field == 'orderNum'
                                  ? sale.toJson()[headers[i].field]
                                  : headers[i].value ?? '',
                              style: theme.textTheme.bodySmall!.copyWith(
                                  color: baseColor,
                                  fontSize: headers[i].valueStyle.fontSize,
                                  fontWeight: headers[i]
                                                  .valueStyle
                                                  .fontWeight !=
                                              null &&
                                          headers[i].valueStyle.fontWeight ==
                                              'bold'
                                      ? FontWeight.bold
                                      : null),
                            ),
                          ),
                        ),
                      ]),
                ),
            ],
          ),
      ],
    );
  }
}
