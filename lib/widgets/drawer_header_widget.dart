import 'package:flutter/material.dart';
import 'package:flutter_template/utils/constants.dart';

class DrawerHeaderWidget extends StatelessWidget {
  final String company;
  final String address;
  final String telephone;
  const DrawerHeaderWidget(
      {super.key,
      this.company = 'FLUTTER',
      this.address = 'Mountain View, California, United States',
      this.telephone = '(650) 253-0000'});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DrawerHeader(
        child: Center(
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
          Text(
            telephone,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
