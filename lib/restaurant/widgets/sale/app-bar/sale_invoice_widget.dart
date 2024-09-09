import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/models/sale/table-location/table_location_model.dart';
import 'package:flutter_template/restaurant/providers/sale/sale_provider.dart';
import 'package:flutter_template/restaurant/widgets/icon_with_text_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/sale/sale_model.dart';
import '../../../utils/constants.dart';
import 'sale_invoice_item_widget.dart';

class SaleInvoiceWidget extends StatelessWidget {
  const SaleInvoiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(
          left: AppStyleDefaultProperties.p,
          top: AppStyleDefaultProperties.p,
          right: AppStyleDefaultProperties.p),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Selector<SaleProvider, TableLocationModel>(
            selector: (context, state) => state.tableLocation,
            builder: (context, tableLocation, child) => IconWithTextWidget(
              icon: RestaurantDefaultIcons.tableLocation,
              dynamicText: '${tableLocation.floor} : ${tableLocation.table}',
            ),
          ),
          IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(AppDefaultIcons.close))
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        child: Selector<SaleProvider, List<SaleModel>>(
          selector: (context, state) => state.sales,
          builder: (context, sales, child) => ListView.builder(
            shrinkWrap: true,
            itemCount: sales.length,
            itemBuilder: (context, index) {
              final SaleModel sale = sales[index];
              return SaleInvoiceItemWidget(
                sale: sale,
                onTap: () async {
                  await context
                      .read<SaleProvider>()
                      .getCurrentSaleWithSaleDetail(invoiceId: sale.id);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
