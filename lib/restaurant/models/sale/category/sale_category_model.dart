import 'package:flutter_template/models/select-option/select_option_model.dart';

class SaleCategoryModel {
  final SelectOptionModel parent;
  final List<SaleCategoryModel> children;
  const SaleCategoryModel({
    required this.parent,
    this.children = const [],
  });
}
