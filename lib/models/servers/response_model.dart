import 'package:toastification/toastification.dart';

class ResponseModel {
  final int? status;
  final String? title;
  final String description;
  final ToastificationType type;
  final dynamic data;

  const ResponseModel({
    this.status,
    this.title,
    required this.description,
    required this.type,
    this.data,
  });
}
