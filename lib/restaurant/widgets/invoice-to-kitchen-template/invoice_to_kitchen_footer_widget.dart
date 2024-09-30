import 'package:flutter/material.dart';

class InvoiceToKitchenFooterWidget extends StatelessWidget {
  const InvoiceToKitchenFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    return Text('Powered by Rabbit Technology',
        style: theme.textTheme.bodySmall!.copyWith(color: baseColor));
  }
}
