import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../icon_with_text_widget.dart';

class TableWidget extends StatelessWidget {
  final int currentGuestCountFromSale;
  final int maxChair;
  final String name;
  final String status;
  final Function()? onTap;
  const TableWidget(
      {super.key,
      required this.currentGuestCountFromSale,
      required this.maxChair,
      required this.name,
      required this.status,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    late Color tableColorByStatus;
    if (status == 'closed') {
      tableColorByStatus = RestaurantTableStatusColors.closed;
    } else if (status == 'isPrintBill') {
      tableColorByStatus = RestaurantTableStatusColors.isPrintBill;
    } else if (status == 'busy') {
      tableColorByStatus = RestaurantTableStatusColors.busy;
    } else {
      tableColorByStatus = RestaurantTableStatusColors.open;
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: tableColorByStatus),
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
                        color: tableColorByStatus,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconWithTextWidget(
                                icon: RestaurantDefaultIcons.customer,
                                dynamicText: '$currentGuestCountFromSale'),
                            IconWithTextWidget(
                                icon: RestaurantDefaultIcons.chair,
                                dynamicText: '$maxChair'),
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
