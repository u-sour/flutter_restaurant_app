import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../utils/constants.dart';

class LoadingWidget extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String title;
  final String description;
  const LoadingWidget(
      {super.key,
      this.icon = AppDefaultIcons.loading,
      this.iconSize = AppStyleDefaultProperties.h * 6,
      this.title = 'loading.title',
      this.description = 'loading.description'});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize),
            const SizedBox(height: AppStyleDefaultProperties.h),
            LoadingAnimationWidget.staggeredDotsWave(
              color: theme.colorScheme.primary,
              size: 48.0,
            ),
            const SizedBox(height: AppStyleDefaultProperties.h),
            Text(
              title.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppStyleDefaultProperties.h),
            Text(
              description.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
