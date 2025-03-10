import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class ReportTemplateContentTableCellWidget extends StatelessWidget {
  final bool isHeader;
  final String text;
  final dynamic dynamicText;
  final Color? textColor;
  final double padding;
  final BoxBorder? border;
  final AlignmentGeometry alignment;
  final FontWeight fontWeight;
  final TextDecoration? decoration;

  const ReportTemplateContentTableCellWidget(
      {super.key,
      this.isHeader = false,
      this.text = '',
      this.dynamicText,
      this.textColor,
      this.padding = AppStyleDefaultProperties.p,
      this.border,
      this.alignment = Alignment.centerLeft,
      this.fontWeight = FontWeight.normal,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      alignment: alignment,
      padding: EdgeInsetsDirectional.all(padding / 2),
      decoration: BoxDecoration(border: border),
      child: Text(
        dynamicText != null ? '$dynamicText' : text.tr(),
        style: isHeader
            ? theme.textTheme.bodyMedium!.copyWith(fontWeight: fontWeight)
            : theme.textTheme.bodySmall!.copyWith(
                fontWeight: fontWeight,
                decoration: decoration,
                decorationThickness: 2),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
