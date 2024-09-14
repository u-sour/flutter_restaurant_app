import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../models/invoice-template/total/total_list_schema_model.dart';
import '../../models/invoice-template/total/total_schema_model.dart';
import '../../models/sale/invoice/sale_invoice_for_print_model.dart';

class InvoiceTemplateTotalWidget extends StatelessWidget {
  final TotalSchemaModel totalSchema;
  final SaleInvoiceForPrintModel sale;
  const InvoiceTemplateTotalWidget(
      {super.key, required this.totalSchema, required this.sale});

  @override
  Widget build(BuildContext context) {
    print(sale.toJson());
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    List<TotalListSchemaModel> totals = totalSchema.list;
    return Column(
      children: [
        for (int i = 0; i < totals.length; i++)
          if (totals[i].isVisible)
            Padding(
              padding: EdgeInsets.only(
                  right: totalSchema.labelStyle.paddingRight ?? 0.0,
                  bottom: totalSchema.labelStyle.paddingBottom ?? 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${totals[i].label}:',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: baseColor,
                        fontSize: totals[i].labelStyle.fontSize,
                        fontWeight: totals[i].labelStyle.fontWeight != null &&
                                totals[i].labelStyle.fontWeight == 'bold'
                            ? FontWeight.bold
                            : null,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'data',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: baseColor,
                        fontSize: totals[i].valueStyle.fontSize,
                        fontWeight: totals[i].valueStyle.fontWeight != null &&
                                totals[i].valueStyle.fontWeight == 'bold'
                            ? FontWeight.bold
                            : null,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
            ),
        const SizedBox(height: AppStyleDefaultProperties.h * 3.5)
      ],
    );
  }
}
