import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/models/invoice-template/footer/footer_text_list_schema_model.dart';
import 'package:flutter_template/restaurant/models/invoice-template/footer/footer_text_schema_model.dart';

class InvoiceTemplateFooterWidget extends StatelessWidget {
  final FooterTextSchemaModel footerSchema;
  const InvoiceTemplateFooterWidget({super.key, required this.footerSchema});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    List<FooterTextListSchemaModel> footers = footerSchema.list;

    return Column(
      children: [
        for (int i = 0; i < footers.length; i++)
          Padding(
            padding: EdgeInsets.only(
              top: footers[i].style.paddingTop ?? 0.0,
              bottom: footers[i].style.paddingBottom ?? 0.0,
            ),
            child: Row(
              mainAxisAlignment: footers[i].style.justifyContent != null &&
                      footers[i].style.justifyContent == 'start'
                  ? MainAxisAlignment.start
                  : footers[i].style.justifyContent != null &&
                          footers[i].style.justifyContent == 'center'
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
              children: [
                Text(
                  footers[i].value,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: baseColor,
                    fontSize: footers[i].style.fontSize,
                    fontWeight: footers[i].style.fontWeight != null &&
                            footers[i].style.fontWeight == 'bold'
                        ? FontWeight.bold
                        : null,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
