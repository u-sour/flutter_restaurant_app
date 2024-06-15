import '../../utils/alert/awesome_snack_bar_utils.dart';

class ResponseModel {
  final int status;
  final String? title;
  final String message;
  final AWESOMESNACKBARTYPE type;

  const ResponseModel(
      {required this.status,
      this.title,
      required this.message,
      required this.type});
}
