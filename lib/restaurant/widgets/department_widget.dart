import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../models/department/department_model.dart';
import '../services/sale_service.dart';
import '../utils/constants.dart';

class DepartmentWidget extends StatelessWidget {
  final bool isPressable;
  final ButtonStyle? style;
  const DepartmentWidget({super.key, this.isPressable = true, this.style});

  @override
  Widget build(BuildContext context) {
    final AppProvider readAppProvider = context.read<AppProvider>();
    bool isDepartmentModule =
        SaleService.isModuleActive(modules: ['department'], context: context);
    return isDepartmentModule
        ? Selector<AppProvider, List<DepartmentModel>>(
            selector: (context, state) => state.departments,
            builder: (context, departments, child) => MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return OutlinedButton.icon(
                      onPressed: isPressable
                          ? () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            }
                          : null,
                      style: style,
                      icon: const Icon(RestaurantDefaultIcons.department),
                      label: Selector<AppProvider, DepartmentModel?>(
                          selector: (context, state) =>
                              state.selectedDepartment,
                          builder: (context, sd, child) =>
                              Text(sd != null ? sd.name : '')),
                    );
                  },
                  menuChildren: departments
                      .map((d) => MenuItemButton(
                            onPressed: () =>
                                readAppProvider.setDepartment(department: d),
                            child: Text(d.name),
                          ))
                      .toList(),
                ))
        : const SizedBox.shrink();
  }
}
