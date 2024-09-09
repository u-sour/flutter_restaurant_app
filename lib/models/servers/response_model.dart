import '../../utils/alert/awesome_snack_bar_utils.dart';

class ResponseModel {
  final int? status;
  final String? title;
  final String message;
  final AWESOMESNACKBARTYPE type;
  final dynamic data;

  const ResponseModel({
    this.status,
    this.title,
    required this.message,
    required this.type,
    this.data,
  });
}
