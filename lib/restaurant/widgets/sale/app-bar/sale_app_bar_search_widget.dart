import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_template/restaurant/widgets/badge_widget.dart';
import '../../../../utils/constants.dart';
import '../../../utils/constants.dart';

class SaleAppBarSearchWidget extends StatelessWidget {
  const SaleAppBarSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppStyleDefaultProperties.p),
      child: Row(
        children: [
          Expanded(
            child: FormBuilderTextField(
              name: 'search',
              decoration: InputDecoration(
                  prefixIcon: const Icon(RestaurantDefaultIcons.search),
                  hintText: 'screens.sale.search'.tr(),
                  isDense: true),
            ),
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
        ],
      ),
    );
  }
}
