import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class ReportTemplateFooterWidget extends StatelessWidget {
  const ReportTemplateFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: AppStyleDefaultProperties.p),
      child: SizedBox.shrink(),
    );
  }
}
