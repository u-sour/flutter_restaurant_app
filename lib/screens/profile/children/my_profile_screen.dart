import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_template/models/widgets/avatar_initial_widget_model.dart';
import 'package:flutter_template/widgets/avatar_widget.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../../providers/my_profile_provider.dart';
import '../../../router/route_utils.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive/responsive_layout.dart';
import '../../../widgets/drawer_widget.dart';
import '../../../widgets/toggle_switch_theme_widget.dart';

class MyProfileScreen extends StatelessWidget {
  final String? fullName;
  final String? username;
  final String? email;
  MyProfileScreen(
      {super.key,
      this.fullName = 'Unknown',
      this.username = 'Unknown',
      this.email = 'unknown@gmail.com'});
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final String _fromTitle = 'screens.profile.children.myProfile.formTitle';
  final String _prefixFromLabel = 'screens.profile.children.myProfile.form';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer:
          !ResponsiveLayout.isDesktop(context) ? const DrawerWidget() : null,
      body: CustomScrollView(
        physics: ResponsiveLayout.isDesktop(context)
            ? const NeverScrollableScrollPhysics()
            : null,
        slivers: [
          SliverAppBar(
            title: Text(context.tr(SCREENS.myProfile.toTitle)),
            pinned: true,
            actions: [
              Container(
                width: 120.0,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: const ToggleSwitchThemeWidget(),
              )
            ],
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AvatarWidget(
                      radius: 48.0,
                      initial: AvatarInitialWidgetModel(label: fullName)),
                  const SizedBox(height: AppStyleDefaultProperties.h),
                  Text(fullName!, style: theme.textTheme.titleLarge!),
                  Text(email!, style: theme.textTheme.titleLarge!)
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Consumer<MyProfileProvider>(
              builder: (context, state, child) => FormBuilder(
                key: _formKey,
                enabled: state.isFromEnabled,
                initialValue: {
                  'fullName': fullName,
                  'username': username,
                  'email': email
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.tr(_fromTitle),
                              style: theme.textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          // IconButton(
                          //     onPressed: () => {
                          //           state
                          //               .changeFormEnabled(!state.isFromEnabled)
                          //         },
                          //     icon: const Icon(AppDefaultIcons.edit))
                        ],
                      ),
                      const SizedBox(height: AppStyleDefaultProperties.h),
                      FormBuilderTextField(
                        name: 'fullName',
                        decoration: InputDecoration(
                          labelText: context.tr('$_prefixFromLabel.fullName'),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.minLength(4),
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(height: AppStyleDefaultProperties.h),
                      FormBuilderTextField(
                        name: 'username',
                        decoration: InputDecoration(
                          labelText: context.tr('$_prefixFromLabel.username'),
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(height: AppStyleDefaultProperties.h),
                      FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration(
                            labelText: context.tr('$_prefixFromLabel.email')),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.email(),
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Consumer<MyProfileProvider>(
          builder: (context, state, child) => state.isFromEnabled
              ? Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                          onPressed: () {
                            _formKey.currentState!.reset();
                          },
                          // style: theme.elevatedButtonTheme.style?.copyWith(),
                          child: Text(context.tr('$_prefixFromLabel.cancel'))),
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
              : const SizedBox.shrink(),
        )
      ],
    );
  }
}
