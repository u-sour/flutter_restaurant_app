import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../router/route_utils.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../utils/constants.dart';
import '../../icon_with_text_widget.dart';

class SaleAppBarNavigationWidget extends StatelessWidget {
  const SaleAppBarNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.orientationOf(context);
    final List<SelectOptionModel> navigation = [
      const SelectOptionModel(
        icon: RestaurantDefaultIcons.table,
        label: "screens.sale.navigation.saleTable",
        value: "table",
      ),
      const SelectOptionModel(
        icon: RestaurantDefaultIcons.categories,
        label: "screens.sale.navigation.categories",
        value: "categories",
      ),
    ];
    // remove categories on desktop mode
    if (ResponsiveLayout.isDesktop(context)) navigation.removeLast();

    return ResponsiveLayout.isMobile(context) ||
            ResponsiveLayout.isTablet(context) &&
                orientation == Orientation.landscape
        ? MenuAnchor(
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.more_horiz),
                tooltip: 'Back',
              );
            },
            menuChildren: navigation
                .map((n) => MenuItemButton(
                      leadingIcon: Icon(n.icon),
                      onPressed: () => {
                        if (n.value == 'categories')
                          {Scaffold.of(context).openDrawer()}
                        else
                          {context.goNamed(SCREENS.saleTable.toName)}
                      },
                      child: Text(n.label).tr(),
                    ))
                .toList(),
          )
        : Row(
            children: [
              for (int i = 0; i < navigation.length; i++)
                IconButton(
                  onPressed: () {
                    if (navigation[i].value == 'categories') {
                      Scaffold.of(context).openDrawer();
                    } else {
                      context.goNamed(SCREENS.saleTable.toName);
                    }
                  },
                  icon: navigation[i].value == "categories"
                      ? Icon(navigation[i].icon)
                      : Column(
                          children: [
                            IconWithTextWidget(
                              icon: navigation[i].icon!,
                              data: navigation[i].label.tr(),
                            ),
                          ],
                        ),
                ),
            ],
          );
  }
}
