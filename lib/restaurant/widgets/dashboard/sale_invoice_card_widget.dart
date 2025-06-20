import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive/responsive_layout.dart';
import '../../models/sale/invoice/sale_invoice_data_model.dart';
import '../../models/sale/invoice/sale_invoice_model.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../../providers/sale/sale_provider.dart';
import '../../services/user_service.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/loading_widget.dart';
import 'sale_invoice_card_list_widget.dart';

class SaleInvoiceCardWidget extends StatelessWidget {
  const SaleInvoiceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SaleProvider readSaleProvider = context.read<SaleProvider>();
    Orientation orientation = MediaQuery.orientationOf(context);
    late int crossAxisCount;
    if (ResponsiveLayout.isMobile(context)) {
      crossAxisCount = 2;
    } else if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.portrait) {
      crossAxisCount = 3;
    } else if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.landscape) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 4;
    }
    return Selector<DashboardProvider,
            ({bool isFiltering, SaleInvoiceModel saleInvoice})>(
        selector: (context, state) =>
            (isFiltering: state.isFiltering, saleInvoice: state.saleInvoice),
        builder: (context, data, child) {
          if (data.saleInvoice.data.isNotEmpty) {
            return data.isFiltering
                ? const LoadingWidget()
                : GridView.builder(
                    itemCount: data.saleInvoice.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: AppStyleDefaultProperties.h,
                        crossAxisSpacing: AppStyleDefaultProperties.w,
                        mainAxisExtent: 200.0,
                        crossAxisCount: crossAxisCount),
                    itemBuilder: (context, index) {
                      final SaleInvoiceDataModel saleInvoiceData =
                          data.saleInvoice.data[index];
                      return SaleInvoiceCardListWidget(
                        data: saleInvoiceData,
                        onTap: UserService.userInRole(roles: ['cashier']) ||
                                (UserService.userInRole(
                                        roles: ['tablet-orders']) &&
                                    saleInvoiceData.requestPayment != true)
                            ? () {
                                readSaleProvider.handleEnterSale(
                                    context: context,
                                    invoiceId: saleInvoiceData.id,
                                    tableId: saleInvoiceData.tableId);
                              }
                            : null,
                        onBtnPressed: saleInvoiceData.status == 'Open' &&
                                UserService.userInRole(roles: ['cashier'])
                            ? () async {
                                await readSaleProvider.payment(
                                    context: context,
                                    invoiceId: saleInvoiceData.id,
                                    fromDashboard: true);
                              }
                            : null,
                      );
                    });
          } else {
            return const EmptyDataWidget();
          }
        });
  }
}
