import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import '../../../utils/constants.dart';
import '../../../utils/debounce.dart';
import '../../badge_widget.dart';
import '../../search_widget.dart';

class SaleAppBarSearchWidget extends StatelessWidget {
  const SaleAppBarSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Debounce debounce = Debounce();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppStyleDefaultProperties.p),
      child: Row(
        children: [
          Expanded(child: SearchWidget(
            onChanged: (String? query) {
              if (query != null) {
                debounce.run(() {
                  print(query);
                });
              }
            },
          )),
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
