import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../../utils/debounce.dart';
import '../search_widget.dart';
import 'sale_invoice_card_widget.dart';
import 'sale_invoice_data_table_widget.dart';

enum SaleInvoiceContentType { card, dataTable }

class SaleInvoiceContentWidget extends StatefulWidget {
  final SaleInvoiceContentType type;
  const SaleInvoiceContentWidget({
    super.key,
    this.type = SaleInvoiceContentType.card,
  });

  @override
  State<SaleInvoiceContentWidget> createState() =>
      _SaleInvoiceContentWidgetState();
}

class _SaleInvoiceContentWidgetState extends State<SaleInvoiceContentWidget> {
  final Debounce debounce = Debounce();
  late DashboardProvider _readDashboardProvider;
  @override
  void initState() {
    super.initState();
    _readDashboardProvider = context.read<DashboardProvider>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
        child: SearchWidget(
          onChanged: (String? query) {
            if (query != null) {
              debounce.run(() {
                final int selectedTab = _readDashboardProvider.selectedTab;
                _readDashboardProvider.filter(
                  tab: selectedTab,
                  filter: query,
                );
              });
            }
          },
        ),
      ),
      widget.type.name == 'card'
          ? const Expanded(child: SaleInvoiceCardWidget())
          : const Expanded(child: SaleInvoiceDataTableWidget())
    ]);
  }
}
