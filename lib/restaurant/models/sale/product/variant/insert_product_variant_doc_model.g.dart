// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_product_variant_doc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertProductVariantDocModel _$InsertProductVariantDocModelFromJson(
        Map<String, dynamic> json) =>
    InsertProductVariantDocModel(
      itemId: json['itemId'] as String,
      qty: json['qty'] as num,
      price: json['price'] as num,
      discount: json['discount'] as num,
      amount: json['amount'] as num,
      status: json['status'] as String,
      checkPrint: json['checkPrint'] as bool,
      invoiceId: json['invoiceId'] as String,
      branchId: json['branchId'] as String,
    );

Map<String, dynamic> _$InsertProductVariantDocModelToJson(
        InsertProductVariantDocModel instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'qty': instance.qty,
      'price': instance.price,
      'discount': instance.discount,
      'amount': instance.amount,
      'status': instance.status,
      'checkPrint': instance.checkPrint,
      'invoiceId': instance.invoiceId,
      'branchId': instance.branchId,
    };
