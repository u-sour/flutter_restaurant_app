import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../screens/app_screen.dart';
import '../models/department/department_model.dart';

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

    final List<String> allowModules = context.read<AppProvider>().allowModules;

    List<String> mods = [];
    if (modules is String) {
      mods.add(modules);
    } else if (modules is List) {
      mods = [...mods, ...modules];
    }

    final result = mods.firstWhere(
      (el) => allowModules.contains(el),
      orElse: () => '',
    );

    return result.isNotEmpty ? true : false;
  }

  static Future<bool> isDataEnoughToEnterSale(
      {required BuildContext context}) async {
    // check if data department, exchange rate & department exist
    bool result = false;
    final AppProvider readAppProvider = context.read<AppProvider>();
    final List<DepartmentModel> departments = readAppProvider.departments;
    final Map<String, dynamic>? exchangeDoc =
        await meteor.call('app.findOneExchange', args: [{}]);
    Map<String, dynamic> selector = {
      'branchId': readAppProvider.selectedBranch!.id,
      'departments.depId': readAppProvider.selectedDepartment!.id,
      'type': {
        '\$in': ['Product', 'Dish', 'Catalog', 'Service']
      },
      'status': 'Active',
    };
    final Map<String, dynamic>? productDoc =
        await meteor.call('rest.findOneProduct', args: [
      {'selector': selector}
    ]);

    if (departments.isNotEmpty && exchangeDoc != null && productDoc != null) {
      result = true;
    }
    return result;
  }
}
