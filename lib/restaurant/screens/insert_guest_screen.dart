import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class InsertGuestScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> fbKey;
  const InsertGuestScreen({super.key, required this.fbKey});
  final String _prefixFromLabel = 'screens.guest.form';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.minPositive,
      child: FormBuilder(
        key: fbKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            FormBuilderTextField(
              name: 'name',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: '$_prefixFromLabel.name'.tr(),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: AppStyleDefaultProperties.h),
            FormBuilderTextField(
              name: 'telephone',
              decoration: InputDecoration(
                labelText: '$_prefixFromLabel.telephone'.tr(),
              ),
            ),
            const SizedBox(height: AppStyleDefaultProperties.h),
            FormBuilderTextField(
                name: 'address',
                decoration: InputDecoration(
                  labelText: '$_prefixFromLabel.address'.tr(),
                ),
                maxLines: 3)
          ],
        ),
      ),
    );
  }
}
