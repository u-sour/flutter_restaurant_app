import 'package:flutter/material.dart';
import '../../../../services/global_service.dart';
import '../../../utils/constants.dart';
import '../../badge_widget.dart';
import 'sale_invoice_widget.dart';

class SaleAppBarActionWidget extends StatelessWidget {
  const SaleAppBarActionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          BadgeWidget(
            child: SizedBox(
              width: 48.0,
              height: 48.0,
              child: FilledButton(
                onPressed: () => GlobalService.openDialog(
                    contentWidget: const SaleInvoiceWidget(), context: context),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const Icon(RestaurantDefaultIcons.invoiceList),
              ),
            ),
          ),
          const Expanded(
              child: Column(
            children: [
              Text(
                'Floor( Table ) : Invoice ID',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Date Time',
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          )),
          SizedBox(
            width: 48.0,
            height: 48.0,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: const Icon(RestaurantDefaultIcons.addInvoice),
            ),
          ),
        ],
      ),
    );
  }
}
