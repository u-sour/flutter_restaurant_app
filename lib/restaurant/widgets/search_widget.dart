import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../utils/constants.dart';

class SearchWidget extends StatelessWidget {
  final IconData prefixIcon;
  final void Function(String?)? onChanged;
  const SearchWidget(
      {super.key,
      this.prefixIcon = RestaurantDefaultIcons.search,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'search',
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          hintText: 'screens.sale.search'.tr(),
          isDense: true),
      onChanged: onChanged,
    );
  }
}
