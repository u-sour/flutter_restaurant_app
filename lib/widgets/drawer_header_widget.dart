import 'package:flutter/material.dart';
import '../utils/constants.dart';

class DrawerHeaderWidget extends StatelessWidget {
  final String company;
  final String address;
  final String? telephone;
  final double height;
  const DrawerHeaderWidget({
    super.key,
    this.company = 'FLUTTER',
    this.address = 'Mountain View, California, United States',
    this.telephone,
    this.height = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: height,
      child: DrawerHeader(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            company,
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppStyleDefaultProperties.h),
          Text(
            address,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (telephone != null)
            Text(
              telephone!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
        ],
      )),
    );
  }
}
