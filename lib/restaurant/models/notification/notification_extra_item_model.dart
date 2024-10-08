import 'package:json_annotation/json_annotation.dart';
part 'notification_extra_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationExtraItemModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String itemId;
  final String itemName;
  final num price;
  final num discount;
  final num amount;

  const NotificationExtraItemModel(
      {required this.id,
      required this.itemId,
      required this.itemName,
      required this.price,
      required this.discount,
      required this.amount});

  factory NotificationExtraItemModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationExtraItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationExtraItemModelToJson(this);
}
