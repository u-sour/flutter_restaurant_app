import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import '../../models/auth/login_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/login_form_provider.dart';
import '../../utils/alert/alert.dart';
import '../../utils/constants.dart';
import '../../utils/responsive/responsive_layout.dart';

class LoginFormWidget extends StatelessWidget {
  final double? formWidth;
  const LoginFormWidget({super.key, this.formWidth});
  static final GlobalKey<FormBuilderState> formKey =
      GlobalKey<FormBuilderState>();
  final String _fromTitle = 'screens.login.children.formTitle';
  final String _prefixFromLabel = 'screens.login.children.form';
  static final int _year = DateTime.now().year;
  final String _copyRightBy = 'appInfo.copyrightBy';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
        width: formWidth,
        child: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.tr(_fromTitle),
                  style: theme.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: AppStyleDefaultProperties.h),
              GridView(
                primary: false,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
                    crossAxisSpacing: AppStyleDefaultProperties.w,
                    mainAxisSpacing: AppStyleDefaultProperties.h,
                    mainAxisExtent: AppStyleDefaultProperties.h * 6),
                shrinkWrap: true,
                children: [
                  Selector<LoginFormProvider, String>(
                    selector: (_, state) => state.username,
                    builder: (context, username, child) => FormBuilderTextField(
                      name: 'username',
                      initialValue: username,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(color: Colors.white),
                      decoration: ResponsiveLayout.isDesktop(context)
                          ? InputDecoration(
                              prefixIcon: const Icon(AppDefaultIcons.username,
                                  color: Colors.white),
                              labelText:
                                  context.tr('$_prefixFromLabel.username'))
                          : InputDecoration(
                              prefixIcon: const Icon(AppDefaultIcons.username,
                                  color: Colors.white),
                              hintText:
                                  context.tr('$_prefixFromLabel.username'),
                              hintStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.white24,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                    ),
                  ),
                  Consumer<LoginFormProvider>(
                    builder: (context, state, child) => FormBuilderTextField(
                      name: 'password',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: state.showPassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: ResponsiveLayout.isDesktop(context)
                          ? InputDecoration(
                              prefixIcon: const Icon(AppDefaultIcons.password),
                              labelText:
                                  context.tr('$_prefixFromLabel.password'),
                              suffixIcon: IconButton(
                                onPressed: () => state
                                    .switchShowPassword(!state.showPassword),
                                splashRadius: 16.0,
                                icon: Icon(state.showPassword
                                    ? AppDefaultIcons.hidePassword
                                    : AppDefaultIcons.showPassword),
                              ),
                            )
                          : InputDecoration(
                              prefixIcon: const Icon(AppDefaultIcons.password,
                                  color: Colors.white),
                              hintText:
                                  context.tr('$_prefixFromLabel.password'),
                              hintStyle: const TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Colors.white24,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              suffixIcon: IconButton(
                                onPressed: () => state
                                    .switchShowPassword(!state.showPassword),
                                splashRadius: 16.0,
                                icon: Icon(
                                    state.showPassword
                                        ? AppDefaultIcons.hidePassword
                                        : AppDefaultIcons.showPassword,
                                    color: Colors.white),
                              ),
                            ),
                      validator: FormBuilderValidators.required(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Selector<LoginFormProvider, bool>(
                          selector: (_, state) => state.rememberMe,
                          builder: (context, rememberMe, child) {
                            return FormBuilderCheckbox(
                              initialValue: rememberMe,
                              name: 'rememberMe',
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                              title: Text(
                                context.tr('$_prefixFromLabel.rememberMe'),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          })),
                  // Expanded(
                  //   child: RichText(
                  //       textAlign: TextAlign.end,
                  //       text: TextSpan(
                  //         text: context.tr('$_prefixFromLabel.forgotPassword'),
                  //         recognizer: TapGestureRecognizer()..onTap = () {},
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: theme.colorScheme.primary),
                  //       )),
                  // )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Selector<AuthProvider, bool>(
                        selector: (_, state) => state.loading,
                        builder: (context, loading, child) {
                          return FilledButton(
                            onPressed: loading
                                ? null
                                : () async {
                                    if (formKey.currentState!
                                        .saveAndValidate()) {
                                      final formDoc = LoginModel.fromJson(
                                          formKey.currentState!.value);
                                      final result = await context
                                          .read<AuthProvider>()
                                          .login(formDoc: formDoc);
                                      Alert.show(
                                        type: result.status == 201
                                            ? ToastificationType.success
                                            : ToastificationType.error,
                                        description: result.description,
                                      );
                                    }
                                  },
                            child: Text(
                              loading
                                  ? context.tr('$_prefixFromLabel.submitting')
                                  : context.tr('$_prefixFromLabel.submit'),
                              style: theme.textTheme.labelLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          );
                        }),
                  )
                ],
              ),
              const SizedBox(height: AppStyleDefaultProperties.h),
              Text(
                context.tr(_copyRightBy, namedArgs: {
                  'company': 'appInfo.value.company'.tr(),
                  'year': '$_year',
                  'version': 'appInfo.value.latestVersion'.tr()
                }),
              ),
              // RichText(
              //   text: TextSpan(
              //     text: context.tr('$_prefixFromLabel.noAccount'),
              //     style: TextStyle(color: theme.textTheme.bodySmall!.color),
              //     children: [
              //       const WidgetSpan(child: SizedBox(width: 5.0)),
              //       TextSpan(
              //         text: context.tr('$_prefixFromLabel.createAccount'),
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: theme.colorScheme.primary),
              //         recognizer: TapGestureRecognizer()..onTap = () {},
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
