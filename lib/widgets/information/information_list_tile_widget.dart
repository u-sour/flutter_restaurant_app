import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../models/select-option/select_option_model.dart';

class InformationListTileWidget extends StatelessWidget {
  final SelectOptionModel model;
  const InformationListTileWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
        leading: Icon(model.icon),
        title: Text(model.label.tr()),
        subtitle: Text(
          '${model.value}'.tr(),
          style:
              theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ));
  }
}
