import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../utils/constants.dart';

class SearchWidget extends StatelessWidget {
  final IconData prefixIcon;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  const SearchWidget(
      {super.key,
      this.prefixIcon = RestaurantDefaultIcons.search,
      this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'search',
      controller: controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          hintText: 'screens.sale.search'.tr(),
          isDense: true),
      onChanged: onChanged,
    );
  }
}
