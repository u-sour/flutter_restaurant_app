import '../../widgets/screens/app_screen.dart';

class UserService {
  UserService._();
  static bool userInRole({dynamic roles, bool overpower = true}) {
    final Map<String, dynamic>? currentUser = meteor.userCurrentValue();
    final List<dynamic> currentUserRoles =
        currentUser?['profile']['roles'] ?? [];

    List<String> userRoles = [];
    // Allow user super
    if (overpower) userRoles = ['super'];

    if (roles is String) {
      userRoles.add(roles);
    } else if (roles is List) {
      userRoles = [...userRoles, ...roles];
    }

    final result = userRoles.firstWhere(
      (el) => currentUserRoles.contains(el),
      orElse: () => '',
    );

    return result.isNotEmpty ? true : false;
  }
}
