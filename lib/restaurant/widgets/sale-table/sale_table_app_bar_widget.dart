import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../models/widgets/avatar_initial_widget_model.dart';
import '../../../models/widgets/avatar_menu_widget_model.dart';
import '../../../providers/app_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/route_utils.dart';
import '../../../utils/constants.dart';
import '../../../widgets/avatar_widget.dart';
import '../../models/user/user_model.dart';
import '../branch_widget.dart';
import '../notification/notification_center_widget.dart';

class SaleTableAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const SaleTableAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Row(
        children: [
          BackButton(
            onPressed: () => context.goNamed(SCREENS.dashboard.toName),
          ),
        ],
      ),
      title: Text(context.tr(title)),
      titleSpacing: 0.0,
      actions: [
        // Branch
        const BranchWidget(),
        const SizedBox(width: AppStyleDefaultProperties.w),
        // Notification Center
        const NotificationCenterWidget(),
        const SizedBox(width: AppStyleDefaultProperties.w),
        // Avatar
        Selector<AppProvider, UserModel?>(
            selector: (context, state) => state.currentUser,
            builder: (context, currentUser, child) {
              String prefixLanguageOptions =
                  'screens.settings.children.language.options';
              String languageCode = context.locale.languageCode;
              return AvatarWidget(
                initial: AvatarInitialWidgetModel(label: currentUser?.username),
                menu: [
                  AvatarMenuWidgetModel(
                    icon: AppDefaultIcons.profile,
                    title: currentUser?.username ?? '',
                  ),
                  AvatarMenuWidgetModel(
                      icon: AppDefaultIcons.language,
                      title: languageCode == 'en'
                          ? '$prefixLanguageOptions.en'.tr()
                          : '$prefixLanguageOptions.km'.tr(),
                      onTap: () async {
                        await context.setLocale(languageCode == "en"
                            ? AppSupportedLocales.km
                            : AppSupportedLocales.en);
                      }),
                  AvatarMenuWidgetModel(
                    icon: AppDefaultIcons.logout,
                    title: SCREENS.logout.toTitle.tr(),
                    onTap: () => context.read<AuthProvider>().logOut(),
                  )
                ],
              );
            }),
        const SizedBox(width: AppStyleDefaultProperties.w)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
