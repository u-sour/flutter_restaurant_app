import 'package:flutter/material.dart';
import '../../models/sale/detail/sale_detail_model.dart';
import 'invoice_to_kitchen_footer_widget.dart';
import 'invoice_to_kitchen_header_widget.dart';
import 'invoice_to_kitchen_table_widget.dart';

class InvoiceToKitchenTemplateWidget extends StatelessWidget {
  final String invoiceId;
  final String orderNum;
  final String floorName;
  final String tableName;
  final List<SaleDetailModel> saleDetail;
  const InvoiceToKitchenTemplateWidget({
    super.key,
    required this.invoiceId,
    required this.orderNum,
    required this.floorName,
    required this.tableName,
    required this.saleDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        InvoiceToKitchenHeaderWidget(
            tableLocation: '$floorName ($tableName)', orderNum: orderNum),
        // Table
        InvoiceToKitchenTableWidget(saleDetail: saleDetail),
        // Footer
        const InvoiceToKitchenFooterWidget()
      ],
    );
  }
}
