import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';
import '../../../../models/widgets/avatar_initial_widget_model.dart';
import '../../../../models/widgets/avatar_menu_widget_model.dart';
import '../../../../providers/app_provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../router/route_utils.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/avatar_widget.dart';
import '../../../models/department/department_model.dart';
import '../../../models/user/user_model.dart';
import '../../../providers/sale/categories/sale_categories_provider.dart';
import '../../../providers/sale/products/sale_products_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/debounce.dart';
import '../../badge_widget.dart';
import '../../department_widget.dart';
import '../../search_widget.dart';

class SaleAppBarSearchWidget extends StatelessWidget {
  const SaleAppBarSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Debounce debounce = Debounce();
    SaleProductsProvider readSaleProductsProvider =
        context.read<SaleProductsProvider>();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppStyleDefaultProperties.p),
      child: Row(
        children: [
          Expanded(
              child: SearchWidget(
            controller: readSaleProductsProvider.searchController,
            onChanged: (String? search) {
              if (search != null) {
                debounce.run(() {
                  String categoryId = context
                      .read<SaleCategoriesProvider>()
                      .selectedCategories
                      .last
                      .id;
                  String productGroupId =
                      readSaleProductsProvider.productGroupId;
                  bool showExtraFood = readSaleProductsProvider.showExtraFood;

                  readSaleProductsProvider.filter(
                      search: search,
                      categoryId: categoryId,
                      productGroupId: productGroupId,
                      showExtraFood: showExtraFood);
                });
              }
            },
          )),
          if (ResponsiveLayout.isTablet(context) ||
              ResponsiveLayout.isDesktop(context))
            Row(
              children: [
                const SizedBox(width: AppStyleDefaultProperties.w),
                DepartmentWidget(
                  isPressable: false,
                  style: theme.outlinedButtonTheme.style!.copyWith(
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.all(AppStyleDefaultProperties.p))),
                ),
              ],
            ),
          const SizedBox(width: AppStyleDefaultProperties.w),
          BadgeWidget(
            count: 8,
            child: SizedBox(
              width: 48.0,
              height: 48.0,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const Icon(RestaurantDefaultIcons.notification),
              ),
            ),
          ),
          const SizedBox(width: AppStyleDefaultProperties.w),
          Selector<
                  AppProvider,
                  ({
                    UserModel? currentUser,
                    DepartmentModel? selectedDepartment
                  })>(
              selector: (context, state) => (
                    currentUser: state.currentUser,
                    selectedDepartment: state.selectedDepartment
                  ),
              builder: (context, data, child) {
                String prefixLanguageOptions =
                    'screens.settings.children.language.options';
                String languageCode = context.locale.languageCode;
                return AvatarWidget(
                  initial: AvatarInitialWidgetModel(
                      label: data.currentUser?.username),
                  menu: [
                    AvatarMenuWidgetModel(
                      icon: AppDefaultIcons.profile,
                      title: data.currentUser?.username ?? '',
                    ),
                    if (ResponsiveLayout.isMobile(context))
                      AvatarMenuWidgetModel(
                        icon: RestaurantDefaultIcons.department,
                        title: data.selectedDepartment?.name ?? '',
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
        ],
      ),
    );
  }
}
