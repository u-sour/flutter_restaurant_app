import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../app_bar_widget.dart';
import '../../../drawer_widget.dart';
import '../../../../router/route_utils.dart';

class FormBuilderValidationScreen extends StatelessWidget {
  FormBuilderValidationScreen({super.key});
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final String _prefixFromLabel =
      'screens.formBuilder.children.validation.form';

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBarWidget(title: SCREENS.formBuilderValidation.toTitle),
      drawer:
          !ResponsiveLayout.isDesktop(context) ? const DrawerWidget() : null,
      body: Padding(
        padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: InputDecoration(
                        labelText: context.tr('$_prefixFromLabel.name'),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(4),
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderTextField(
                      name: 'phone_number',
                      decoration: InputDecoration(
                        labelText: context.tr('$_prefixFromLabel.phoneNumber'),
                      ),
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: InputDecoration(
                        labelText: context.tr('$_prefixFromLabel.email'),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.email(),
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderTextField(
                      name: 'password',
                      decoration: InputDecoration(
                        labelText: context.tr('$_prefixFromLabel.password'),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(6),
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderTextField(
                      name: 'confirmPassword',
                      decoration: InputDecoration(
                        labelText:
                            context.tr('$_prefixFromLabel.confirmPassword'),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(6),
                        FormBuilderValidators.required(),
                        (String? val) {
                          if (val !=
                              _formKey
                                  .currentState?.fields['password']?.value) {
                            return "The password and confirm password doesn't match.";
                          }
                          return null;
                        }
                      ]),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: FilledButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                  },
                  // style: theme.elevatedButtonTheme.style?.copyWith(),
                  child: Text(context.tr('$_prefixFromLabel.reset'))),
            ),
            const SizedBox(width: AppStyleDefaultProperties.w),
            Expanded(
              child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {}
                  },
                  child: Text(context.tr('$_prefixFromLabel.submit'))),
            )
          ],
        )
      ],
    );
  }
}
