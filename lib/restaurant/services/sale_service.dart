import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../screens/app_screen.dart';

class SaleService {
  SaleService._();
  static bool isModuleActive(
      {dynamic modules, bool overpower = true, required BuildContext context}) {
    // Just check if needed for user super
    if (overpower) {
      final Map<String, dynamic>? currentUser = meteor.userCurrentValue();
      final List<dynamic> currentUserRoles =
          currentUser?['profile']['roles'] ?? [];

      if (currentUserRoles.contains('super')) return true;
    }

    final List<String> allowedModules =
        context.read<AppProvider>().allowedModules;

    List<String> mods = [];
    if (modules is String) {
      mods.add(modules);
    } else if (modules is List) {
      mods = [...mods, ...modules];
    }

    final result = mods.firstWhere(
      (el) => allowedModules.contains(el),
      orElse: () => '',
    );

    return result.isNotEmpty ? true : false;
  }
}
