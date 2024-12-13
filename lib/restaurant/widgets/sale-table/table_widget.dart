import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/providers/sale-table/sale_table_provider.dart';
import 'package:provider/provider.dart';
import '../../../widgets/icon_with_text_widget.dart';
import '../../utils/constants.dart';

class TableWidget extends StatelessWidget {
  // final int currentGuestCountFromSale;
  final int currentInvoiceCount;
  final int maxChair;
  final String floor;
  final String name;
  final String status;
  final Function()? onTap;
  const TableWidget(
      {super.key,
      // required this.currentGuestCountFromSale,
      required this.currentInvoiceCount,
      required this.maxChair,
      required this.floor,
      required this.name,
      required this.status,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                                icon: RestaurantDefaultIcons.invoice,
                                dynamicText: '$currentInvoiceCount'),
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
              child: Selector<SaleTableProvider, String>(
                selector: (context, state) => state.activeFloor,
                builder: (context, activeFloor, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (activeFloor == 'All')
                      Text(floor, style: theme.textTheme.bodyLarge),
                    Text(name,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
