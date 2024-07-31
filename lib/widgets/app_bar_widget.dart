import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/widgets/avatar_initial_widget_model.dart';
import '../models/widgets/avatar_menu_widget_model.dart';
import '../providers/app_provider.dart';
import '../providers/auth_provider.dart';
import '../restaurant/models/user/user_model.dart';
import '../restaurant/widgets/branch_widget.dart';
import '../router/route_utils.dart';
import '../utils/constants.dart';
import 'avatar_widget.dart';
// import 'toggle_switch_theme_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(context.tr(title)),
      actions: [
        // Container(
        //   width: 120.0,
        //   padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        //   child: const ToggleSwitchThemeWidget(),
        // ),
        const BranchWidget(),
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
