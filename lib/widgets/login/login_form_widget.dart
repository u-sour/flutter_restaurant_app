import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../models/auth/login_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/login_form_provider.dart';
import '../../utils/alert/alert.dart';
import '../../utils/constants.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../../utils/alert/awesome_snack_bar_utils.dart';

class LoginFormWidget extends StatelessWidget {
  final double? formWidth;
  const LoginFormWidget({super.key, this.formWidth});
  final String _fromTitle = 'screens.login.children.formTitle';
  final String _prefixFromLabel = 'screens.login.children.form';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    final theme = Theme.of(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
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
                  style: theme.textTheme.headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: AppStyleDefaultProperties.h),
              orientation == Orientation.portrait
                  ? Column(
                      children: [
                        Selector<LoginFormProvider, String>(
                          selector: (_, state) => state.username,
                          builder: (context, username, child) =>
                              FormBuilderTextField(
                            name: 'username',
                            initialValue: username,
                            decoration: ResponsiveLayout.isDesktop(context)
                                ? InputDecoration(
                                    prefixIcon:
                                        const Icon(AppDefaultIcons.username),
                                    labelText: context
                                        .tr('$_prefixFromLabel.username'))
                                : InputDecoration(
                                    prefixIcon:
                                        const Icon(AppDefaultIcons.username),
                                    hintText: context
                                        .tr('$_prefixFromLabel.username'),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                          ),
                        ),
                        const SizedBox(height: AppStyleDefaultProperties.h),
                        Consumer<LoginFormProvider>(
                          builder: (context, state, child) =>
                              FormBuilderTextField(
                            name: 'password',
                            obscureText: state.showPassword,
                            decoration: ResponsiveLayout.isDesktop(context)
                                ? InputDecoration(
                                    prefixIcon:
                                        const Icon(AppDefaultIcons.password),
                                    labelText: context
                                        .tr('$_prefixFromLabel.password'),
                                    suffixIcon: IconButton(
                                      onPressed: () => state.switchShowPassword(
                                          !state.showPassword),
                                      splashRadius: 16.0,
                                      icon: Icon(state.showPassword
                                          ? AppDefaultIcons.hidePassword
                                          : AppDefaultIcons.showPassword),
                                    ),
                                  )
                                : InputDecoration(
                                    prefixIcon:
                                        const Icon(AppDefaultIcons.password),
                                    hintText: context
                                        .tr('$_prefixFromLabel.password'),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    suffixIcon: IconButton(
                                      onPressed: () => state.switchShowPassword(
                                          !state.showPassword),
                                      splashRadius: 16.0,
                                      icon: Icon(state.showPassword
                                          ? AppDefaultIcons.hidePassword
                                          : AppDefaultIcons.showPassword),
                                    ),
                                  ),
                            validator: FormBuilderValidators.required(),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            name: 'username',
                            decoration: ResponsiveLayout.isDesktop(context)
                                ? InputDecoration(
                                    prefixIcon:
                                        const Icon(AppDefaultIcons.username),
                                    labelText: context
                                        .tr('$_prefixFromLabel.username'))
                                : InputDecoration(
                                    prefixIcon:
                                        const Icon(AppDefaultIcons.username),
                                    hintText: context
                                        .tr('$_prefixFromLabel.username'),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                          ),
                        ),
                        const SizedBox(width: AppStyleDefaultProperties.w),
                        Expanded(
                          child: Consumer<LoginFormProvider>(
                            builder: (context, state, child) =>
                                FormBuilderTextField(
                              name: 'password',
                              obscureText: state.showPassword,
                              decoration: ResponsiveLayout.isDesktop(context)
                                  ? InputDecoration(
                                      prefixIcon:
                                          const Icon(AppDefaultIcons.password),
                                      labelText: context
                                          .tr('$_prefixFromLabel.password'),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            state.switchShowPassword(
                                                !state.showPassword),
                                        splashRadius: 16.0,
                                        icon: Icon(state.showPassword
                                            ? AppDefaultIcons.hidePassword
                                            : AppDefaultIcons.showPassword),
                                      ),
                                    )
                                  : InputDecoration(
                                      prefixIcon:
                                          const Icon(AppDefaultIcons.password),
                                      hintText: context
                                          .tr('$_prefixFromLabel.password'),
                                      filled: true,
                                      fillColor: Colors.white24,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            state.switchShowPassword(
                                                !state.showPassword),
                                        splashRadius: 16.0,
                                        icon: Icon(state.showPassword
                                            ? AppDefaultIcons.hidePassword
                                            : AppDefaultIcons.showPassword),
                                      ),
                                    ),
                              validator: FormBuilderValidators.required(),
                            ),
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
                              title: Text(
                                  context.tr('$_prefixFromLabel.rememberMe')),
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
                                      late SnackBar snackBar;
                                      final formDoc = LoginModel.fromJson(
                                          formKey.currentState!.value);
                                      final result = await context
                                          .read<AuthProvider>()
                                          .login(formDoc: formDoc);
                                      if (result.status == 201) {
                                        snackBar = Alert.awesomeSnackBar(
                                            message: result.message,
                                            type: AWESOMESNACKBARTYPE.success);
                                      } else {
                                        snackBar = Alert.awesomeSnackBar(
                                            message: result.message,
                                            type: AWESOMESNACKBARTYPE.failure);
                                      }
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(snackBar);
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
              // const SizedBox(height: AppStyleDefaultProperties.h),
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
