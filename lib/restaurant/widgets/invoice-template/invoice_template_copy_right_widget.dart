import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

class InvoiceTemplateCopyRightWidget extends StatelessWidget {
  const InvoiceTemplateCopyRightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    double mpTop = 8.0;
    List<int> dashed = [5, 2];
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: mpTop),
                padding: EdgeInsets.only(top: mpTop),
                decoration: DottedDecoration(
                    linePosition: LinePosition.top,
                    color: baseColor,
                    dash: dashed),
                child: Text(
                  'Powered by Rabbit Technology',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall!.copyWith(color: baseColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
