import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../utils/constants.dart';
import '../Icon_with_text_widget.dart';

class TableWidget extends StatelessWidget {
  final int countCustomer;
  final int maxChair;
  final String name;
  final Function()? onTap;
  const TableWidget(
      {super.key,
      required this.countCustomer,
      required this.maxChair,
      required this.name,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppThemeColors.primary),
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0)),
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: AppThemeColors.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconWithTextWidget(
                                icon: RestaurantDefaultIcons.customer,
                                data: '$countCustomer'),
                            IconWithTextWidget(
                                icon: RestaurantDefaultIcons.chair,
                                data: '$maxChair'),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            // Content
            Expanded(
              flex: 2,
              child: Center(
                child: Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
