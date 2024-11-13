import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import '../../models/select-option/select_option_model.dart';
import '../empty_data_widget.dart';
import '../loading_widget.dart';

class FormBuilderSearchableDropdownMultiSelect extends StatefulWidget {
  final GlobalKey<DropdownSearchState<SelectOptionModel>> fbKey;
  final String name;
  final String hintText;
  final List<SelectOptionModel> initialValue;
  final AutovalidateMode autovalidateMode;
  final String? Function(List<dynamic>?)? validator;
  final InputDecoration decoration;
  final List<SelectOptionModel>? items;
  final Future<List<SelectOptionModel>> Function(String)? onFind;
  final Widget Function(BuildContext, SelectOptionModel, bool)? itemBuilder;
  final InputDecoration searchFieldPropsDecoration;
  final ValueChanged<List<SelectOptionModel>>? selectedItem;
  final ValueChanged<SelectOptionModel>? removedItem;
  final String submitButtonText;

  const FormBuilderSearchableDropdownMultiSelect(
      {super.key,
      required this.fbKey,
      this.hintText = 'screens.formBuilderInputDecoration.selectOne',
      this.initialValue = const [],
      this.autovalidateMode = AutovalidateMode.disabled,
      this.validator,
      required this.name,
      required this.decoration,
      this.items,
      this.onFind,
      this.itemBuilder,
      required this.searchFieldPropsDecoration,
      this.selectedItem,
      this.removedItem,
      this.submitButtonText = "SUBMIT"});
  @override
  State<FormBuilderSearchableDropdownMultiSelect> createState() =>
      _FormBuilderSearchableDropdownMultiSelectState();
}

class _FormBuilderSearchableDropdownMultiSelectState
    extends State<FormBuilderSearchableDropdownMultiSelect> {
  List<SelectOptionModel> _selectedItems = [];
  List<String> _initialValue = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialValue.isNotEmpty) {
      _selectedItems = widget.initialValue;
      // convert as list string
      _initialValue = _selectedItems.map((e) => e.value.toString()).toList();
    }
  }

  // set field value on change
  void setFieldValue({required FormFieldState<dynamic> field}) {
    // return selectedItem value
    if (widget.selectedItem != null) widget.selectedItem!(_selectedItems);
    //set selected items to form builder state
    // convert as list string
    List<String> value = _selectedItems.map((e) => e.value.toString()).toList();
    field.didChange(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormBuilderField(
      name: widget.name,
      initialValue: _initialValue,
      validator: widget.validator,
      builder: (FormFieldState<dynamic> field) {
        return DropdownSearch<SelectOptionModel>.multiSelection(
          key: widget.fbKey,
          selectedItems: _selectedItems,
          autoValidateMode: widget.autovalidateMode,
          validator: widget.validator,
          items: widget.items ?? [],
          asyncItems: widget.onFind,
          compareFn: (i, s) => i.value == s.value,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: widget.decoration,
          ),
          itemAsString: ((SelectOptionModel? item) {
            return item!.label;
          }),
          onChanged: (List<SelectOptionModel> selectedItems) {
            setState(() {
              _selectedItems = selectedItems;
            });
            setFieldValue(field: field);
          },
          dropdownBuilder: (context, selectedItems) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              child: selectedItems.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(widget.hintText.tr(),
                          style: TextStyle(color: theme.hintColor)),
                    )
                  : Row(
                      children: selectedItems
                          .map((item) => Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: InputChip(
                                  padding: EdgeInsets.zero,
                                  label: Text(item.label),
                                  onDeleted: () {
                                    widget.fbKey.currentState?.removeItem(item);
                                  },
                                ),
                              ))
                          .toList()),
            );
          },
          popupProps: PopupPropsMultiSelection.dialog(
            isFilterOnline: true,
            showSelectedItems: true,
            showSearchBox: true,
            searchFieldProps:
                TextFieldProps(decoration: widget.searchFieldPropsDecoration),
            loadingBuilder: (context, searchEntry) => const LoadingWidget(),
            emptyBuilder: (context, searchEntry) =>
                const Center(child: EmptyDataWidget()),
            disabledItemFn: (item) =>
                item.extra.runtimeType == bool ? item.extra ?? false : false,
            onItemAdded: (selectedItems, addedItem) {
              widget.fbKey.currentState!.changeSelectedItems(selectedItems);
            },
            onItemRemoved: (selectedItems, removedItem) {
              widget.fbKey.currentState!.changeSelectedItems(selectedItems);
              // return removedItem value
              if (widget.removedItem != null) {
                widget.removedItem!(removedItem);
              }
            },
            validationWidgetBuilder: (ctx, selectedItems) {
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
