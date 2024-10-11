import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/sale/sale/sale_model.dart';
import '../../../providers/sale/sale_provider.dart';

class SaleInvoiceItemWidget extends StatelessWidget {
  final SaleModel sale;
  final void Function()? onTap;
  const SaleInvoiceItemWidget({super.key, required this.sale, this.onTap});

  @override
  Widget build(BuildContext context) {
    SaleProvider readSaleProvider = context.read<SaleProvider>();
    return Selector<SaleProvider, String?>(
      selector: (context, state) => state.activeSaleInvoiceId,
      builder: (context, activeSaleInvoiceId, child) => ListTile(
        selected: sale.id == activeSaleInvoiceId,
        title:
            Text(readSaleProvider.getInvoiceText(sale: sale, context: context)),
        onTap: onTap,
      ),
    );
  }
}
