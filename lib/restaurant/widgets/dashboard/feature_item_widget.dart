import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class FeatureItemWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onPressed;
  const FeatureItemWidget(
      {super.key, required this.label, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.tr(label),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          const SizedBox(height: AppStyleDefaultProperties.h),
          Icon(icon, size: 32.0),
        ],
      ),
    );
  }
}
