import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../screens/app_screen.dart';
import '../../services/global_service.dart';
import '../../utils/constants.dart';
import 'setup_ip_address_form_widget.dart';

class ConnectionFormWidget extends StatelessWidget {
  const ConnectionFormWidget({super.key});
  final String prefix = "screens.connection";
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: IconButton(
                splashRadius: 35.0,
                icon: const Icon(AppDefaultIcons.noConnection),
                // splashColor: CommonColors.secondary.withOpacity(0.1),
                onPressed: () => GlobalService.openDialog(
                    contentWidget: const SetupIpAddressFormWidget(),
                    context: context),
                iconSize: 72.0,
                // color: CommonColors.secondary,
              ),
            ),
            const SizedBox(height: AppStyleDefaultProperties.h),
            LoadingAnimationWidget.staggeredDotsWave(
              color: theme.iconTheme.color!,
              size: 48.0,
            ),
            const SizedBox(height: AppStyleDefaultProperties.h),
            Text(
              '$prefix.title'.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppStyleDefaultProperties.h),
            Text(
              '$prefix.subTitle'.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: AppStyleDefaultProperties.h),
            Text(
              '$prefix.note'.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppStyleDefaultProperties.h * 3),
            SizedBox(
              child: FilledButton(
                onPressed: () {
                  meteor.reconnect();
                },
                child: Text(
                  '$prefix.btn'.tr(),
                  style: theme.textTheme.labelLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
