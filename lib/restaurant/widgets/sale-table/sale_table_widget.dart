import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/alert/alert.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive/responsive_layout.dart';
import '../../models/sale-table/table_model.dart';
import '../../providers/sale-table/sale_table_provider.dart';
import 'table_status_info.dart';
import 'table_widget.dart';

class SaleTableWidget extends StatelessWidget {
  final List<TableModel> tables;
  const SaleTableWidget({super.key, required this.tables});

  @override
  Widget build(BuildContext context) {
    SaleTableProvider saleTableProvider = context.read<SaleTableProvider>();
    Orientation orientation = MediaQuery.orientationOf(context);
    late int crossAxisCount;
    if (ResponsiveLayout.isMobile(context)) {
      crossAxisCount = 2;
    } else if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.portrait) {
      crossAxisCount = 4;
    } else if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.landscape) {
      crossAxisCount = 5;
    } else {
      crossAxisCount = 6;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TableStatusInfo(),
        Expanded(
          child: GridView.builder(
              padding: const EdgeInsets.only(
                left: AppStyleDefaultProperties.p,
                right: AppStyleDefaultProperties.p,
                bottom: AppStyleDefaultProperties.p,
              ),
              itemCount: tables.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: AppStyleDefaultProperties.h,
                  crossAxisSpacing: AppStyleDefaultProperties.w,
                  mainAxisExtent: 120.0,
                  crossAxisCount: crossAxisCount),
              itemBuilder: (context, index) {
                final table = tables[index];
                return TableWidget(
                  key: UniqueKey(),
                  // currentGuestCountFromSale: table.currentGuestCount ?? 0,
                  currentInvoiceCount: table.currentInvoiceCount ?? 0,
                  maxChair: table.numOfGuest,
                  floor: table.floorName,
                  name: table.name,
                  status: table.status ?? '',
                  onTap: () async {
                    final result = saleTableProvider.enterSale(
                        table: table, context: context);
                    if (result != null) {
                      late SnackBar snackBar;
                      snackBar = Alert.awesomeSnackBar(
                          message: result.message, type: result.type);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                );
              }),
        ),
      ],
    );
  }
}
