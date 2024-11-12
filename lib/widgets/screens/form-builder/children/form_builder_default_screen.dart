import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../app_bar_widget.dart';
import '../../../drawer_widget.dart';
import '../../../../router/route_utils.dart';

class FormBuilderDefaultScreen extends StatelessWidget {
  FormBuilderDefaultScreen({super.key});
  final GlobalKey _formKey = GlobalKey<FormBuilderState>();
  final List<String> _langList = [
    'Dart',
    'Kotlin',
    'Java',
    'Swift',
    'Objective-C',
    'Other'
  ];
  final List<String> _databaseList = [
    'Mongo DB',
    'MySQL',
    'Firebase',
    'Appwrite',
    'Other'
  ];
  final List<String> _colorsList = ['Red', 'Blue', 'Green', 'Other'];
  final List<String> _filterChipList = [
    'Apple',
    'Samsung',
    'Google',
    'LG',
    'Sony',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: SCREENS.formBuilderDefault.toTitle),
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
                      name: 'text_field',
                      decoration:
                          const InputDecoration(labelText: 'Text Field'),
                      // textAlign: TextAlign.center,
                      // initialValue: 'Sour.Dev',
                      // onTap: () => {},
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderDateTimePicker(
                      name: 'date_time',
                      inputType: InputType.date,
                      format: DateFormat('yyyy-MM-dd'),
                      decoration:
                          const InputDecoration(labelText: 'DateTime Picker'),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderDateRangePicker(
                      name: 'date_range',
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2030),
                      format: DateFormat('yyyy-MM-dd'),
                      decoration:
                          const InputDecoration(labelText: 'DateRange Picker'),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderDropdown(
                        name: 'dropdown',
                        decoration:
                            const InputDecoration(labelText: 'DropDown'),
                        items: _colorsList
                            .map((opt) =>
                                DropdownMenuItem(value: opt, child: Text(opt)))
                            .toList(growable: false)),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderCheckboxGroup(
                      name: 'checkbox_group',
                      decoration:
                          const InputDecoration(labelText: 'Checkbox Group'),
                      // validator: FormBuilderValidators.required(),
                      options: _langList
                          .map((opt) => FormBuilderFieldOption(value: opt))
                          .toList(growable: false),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderRadioGroup(
                      name: 'radio_group',
                      decoration:
                          const InputDecoration(labelText: 'Radio Group'),
                      // validator: FormBuilderValidators.required(),
                      options: _langList
                          .map((opt) => FormBuilderFieldOption(value: opt))
                          .toList(growable: false),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderChoiceChip(
                      name: 'choice_chip',
                      decoration:
                          const InputDecoration(labelText: 'Choice Chip'),
                      alignment: WrapAlignment.spaceBetween,
                      // direction: Axis.vertical,
                      // spacing: AppStyleDefaultProperties.h,
                      // validator: FormBuilderValidators.required(),
                      options: _databaseList
                          .map((opt) => FormBuilderChipOption(value: opt))
                          .toList(growable: false),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderFilterChip(
                      name: 'filter_chip',
                      decoration:
                          const InputDecoration(labelText: 'Filter Chip'),
                      alignment: WrapAlignment.spaceBetween,
                      runSpacing: AppStyleDefaultProperties.h,
                      // validator: FormBuilderValidators.required(),
                      options: _filterChipList
                          .map((opt) => FormBuilderChipOption(value: opt))
                          .toList(growable: false),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderCheckbox(
                      name: 'checkbox',
                      decoration: const InputDecoration(labelText: 'Checkbox'),
                      title: const Text('Label'),
                      // validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderSwitch(
                      name: 'switch',
                      decoration: const InputDecoration(labelText: 'Switch'),
                      title: const Text('Label'),
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderRangeSlider(
                      name: 'range_slider',
                      decoration:
                          const InputDecoration(labelText: 'Range Slider'),
                      min: 1,
                      max: 100,
                    ),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    FormBuilderSlider(
                      name: 'slider',
                      decoration: const InputDecoration(labelText: 'Slider'),
                      initialValue: 75,
                      min: 1,
                      max: 100,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
