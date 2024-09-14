import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import '../../models/invoice-template/signature/signature_list_schema_model.dart';
import '../../models/invoice-template/signature/signature_schema_model.dart';

class InvoiceTemplateSignatureWidget extends StatelessWidget {
  final SignatureSchemaModel signatureSchema;
  const InvoiceTemplateSignatureWidget(
      {super.key, required this.signatureSchema});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    final List<SignatureListSchemaModel> signatures = signatureSchema.list;
    List<int> dotted = [1, 1];
    List<int> dashed = [5, 2];
    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < signatures.length; i++)
              if (signatures[i].visible)
                Expanded(
                  child: Column(
                    children: [
                      // Label
                      Container(
                          width: 60.0,
                          padding: EdgeInsets.only(
                              top: signatureSchema.wrapperStyle.paddingTop ??
                                  0.0,
                              bottom:
                                  signatureSchema.labelStyle.paddingBottom ??
                                      0.0),
                          decoration: signatureSchema
                                      .wrapperStyle.borderTopStyle ==
                                  'solid'
                              ? const BoxDecoration(
                                  border:
                                      Border(top: BorderSide(color: baseColor)))
                              : DottedDecoration(
                                  linePosition: LinePosition.top,
                                  color: baseColor,
                                  dash: signatureSchema
                                              .wrapperStyle.borderTopStyle ==
                                          'dotted'
                                      ? dotted
                                      : dashed,
                                ),
                          child: Text(signatures[i].label,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: baseColor,
                                fontSize: signatureSchema.labelStyle.fontSize,
                                fontWeight: signatureSchema
                                                .labelStyle.fontWeight !=
                                            null &&
                                        signatureSchema.labelStyle.fontWeight ==
                                            'bold'
                                    ? FontWeight.bold
                                    : null,
                              ))),
                      // SubLabel
                      Text(signatures[i].subLabel,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: baseColor,
                            fontSize: signatureSchema.subLabelStyle.fontSize,
                            fontWeight: signatureSchema
                                            .subLabelStyle.fontWeight !=
                                        null &&
                                    signatureSchema.subLabelStyle.fontWeight ==
                                        'bold'
                                ? FontWeight.bold
                                : null,
                          ))
                    ],
                  ),
                )
          ],
        )
      ],
    );
  }
}
