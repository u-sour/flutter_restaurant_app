import 'package:flutter/material.dart';
import '../constants.dart';

enum SaleDetailDTRowType {
  price,
  discountRate,
  note,
  qty,
  returnQty,
}

const prefixSaleDetailDataTableContent =
    "screens.sale.detail.dataTable.content";

extension SaleDetailDTExtension on SaleDetailDTRowType {
  String get toTitle {
    switch (this) {
      case SaleDetailDTRowType.price:
        return '$prefixSaleDetailDataTableContent.price';
      case SaleDetailDTRowType.discountRate:
        return '$prefixSaleDetailDataTableContent.discountRateLabel';
      case SaleDetailDTRowType.note:
        return '$prefixSaleDetailDataTableContent.note';
      case SaleDetailDTRowType.qty:
        return '$prefixSaleDetailDataTableContent.qty';
      default:
        return '$prefixSaleDetailDataTableContent.returnQty';
    }
  }
}

enum SaleDetailOperationType { merge, transfer, split, customerCount, cancel }

const prefixSaleDetailOperation = "screens.sale.detail.operations.children";

extension SaleDetailOperationExtension on SaleDetailOperationType {
  String get toTitle {
    switch (this) {
      case SaleDetailOperationType.merge:
        return '$prefixSaleDetailOperation.merge';
      case SaleDetailOperationType.transfer:
        return '$prefixSaleDetailOperation.transfer';
      case SaleDetailOperationType.split:
        return '$prefixSaleDetailOperation.split';
      case SaleDetailOperationType.customerCount:
        return '$prefixSaleDetailOperation.customerCount';
      default:
        return '$prefixSaleDetailOperation.cancel';
    }
  }

  IconData get toIcon {
    switch (this) {
      case SaleDetailOperationType.merge:
        return RestaurantDefaultIcons.merge;
      case SaleDetailOperationType.transfer:
        return RestaurantDefaultIcons.transfer;
      case SaleDetailOperationType.split:
        return RestaurantDefaultIcons.split;
      case SaleDetailOperationType.customerCount:
        return RestaurantDefaultIcons.customerCount;
      default:
        return RestaurantDefaultIcons.cancel;
    }
  }
}

enum SaleDetailFooterType {
  changeTable,
  changeGuest,
  preview,
  payment,
  discountRate,
  discountAmount,
}

const prefixSaleDetailFooterAction = "screens.sale.detail.footerActions";
const prefixSaleDetailFooter = "screens.sale.detail.footer";

extension SaleDetailFooterExtension on SaleDetailFooterType {
  String get toTitle {
    switch (this) {
      case SaleDetailFooterType.changeTable:
        return '$prefixSaleDetailFooterAction.table';
      case SaleDetailFooterType.changeGuest:
        return '$prefixSaleDetailFooterAction.guest';
      case SaleDetailFooterType.preview:
        return '$prefixSaleDetailFooterAction.preview';
      case SaleDetailFooterType.payment:
        return '$prefixSaleDetailFooterAction.paymentLabel';
      case SaleDetailFooterType.discountRate:
        return '$prefixSaleDetailFooter.disRateLabel';
      default:
        return '$prefixSaleDetailFooter.disAmountLabel';
    }
  }
}

String getImgSrc({required String ipAddress, required String imgUrl}) =>
    'http://$ipAddress$imgUrl';

double convertValueFromCSS({required String value}) =>
    double.parse(value.substring(0, value.length - 1));
