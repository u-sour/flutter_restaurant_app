import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../models/branch/branch_model.dart';
import '../utils/constants.dart';

class BranchWidget extends StatelessWidget {
  const BranchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppProvider readAppProvider = context.read<AppProvider>();
    return Selector<AppProvider, List<BranchModel>>(
        selector: (context, state) => state.branches,
        builder: (context, branches, child) => MenuAnchor(
              builder: (BuildContext context, MenuController controller,
                  Widget? child) {
                return TextButton.icon(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: const Icon(RestaurantDefaultIcons.branch),
                  label: Selector<AppProvider, BranchModel?>(
                      selector: (context, state) => state.selectedBranch,
                      builder: (context, sb, child) =>
                          Text(sb != null ? '${sb.id} : ${sb.localName}' : '')),
                );
              },
              menuChildren: branches
                  .map((b) => MenuItemButton(
                        onPressed: () => readAppProvider.setBranch(branch: b),
                        child: Text('${b.id} : ${b.localName}'),
                      ))
                  .toList(),
            ));
  }
}
