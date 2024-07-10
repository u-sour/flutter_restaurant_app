import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../models/department/department_model.dart';
import '../utils/constants.dart';

class DepartmentWidget extends StatelessWidget {
  const DepartmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AppProvider, List<DepartmentModel>>(
      selector: (context, state) => state.departments,
      builder: (context, departments, child) => MenuAnchor(
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return OutlinedButton.icon(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(RestaurantDefaultIcons.department),
            label: Selector<AppProvider, DepartmentModel?>(
                selector: (context, state) => state.selectedDepartment,
                builder: (context, sd, child) =>
                    Text(sd != null ? sd.name : '')),
          );
        },
        menuChildren: departments
            .map((d) => MenuItemButton(
                  onPressed: () =>
                      context.read<AppProvider>().setDepartment(department: d),
                  child: Text(d.name),
                ))
            .toList(),
      ),
    );
  }
}
