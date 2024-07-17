import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive/responsive_layout.dart';
import '../../models/sale/invoice/sale_invoice_data_model.dart';
import '../../models/sale/invoice/sale_invoice_model.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import 'sale_invoice_card_list_widget.dart';

class SaleInvoiceCardWidget extends StatelessWidget {
  const SaleInvoiceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    late int crossAxisCount;
    if (ResponsiveLayout.isMobile(context)) {
      crossAxisCount = 2;
    } else if (ResponsiveLayout.isTablet(context)) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }
    return Selector<DashboardProvider, SaleInvoiceModel>(
      selector: (context, state) => state.saleInvoice,
      builder: (context, saleInvoice, child) => GridView.builder(
          padding: const EdgeInsets.only(
            left: AppStyleDefaultProperties.p,
            right: AppStyleDefaultProperties.p,
            bottom: AppStyleDefaultProperties.p,
          ),
          itemCount: saleInvoice.data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: AppStyleDefaultProperties.h,
              crossAxisSpacing: AppStyleDefaultProperties.w,
              mainAxisExtent: 180.0,
              crossAxisCount: crossAxisCount),
          itemBuilder: (context, index) {
            final SaleInvoiceDataModel saleInvoiceData =
                saleInvoice.data[index];
            return SaleInvoiceCardListWidget(
              data: saleInvoiceData,
              onTap: () {},
            );
          }),
    );
  }
}
