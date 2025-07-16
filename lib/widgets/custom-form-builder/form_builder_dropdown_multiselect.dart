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

  const FormBuilderSearchableDropdownMultiSelect({
    super.key,
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
    this.submitButtonText = 'SUBMIT',
  });

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
      _initialValue = _selectedItems.map((e) => e.value.toString()).toList();
    }
  }

  // push selections back into FormBuilder
  void _setFieldValue(FormFieldState<dynamic> field) {
    widget.selectedItem?.call(_selectedItems);
    field.didChange(_selectedItems.map((e) => e.value.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<String>>(
      name: widget.name,
      initialValue: _initialValue,
      validator: widget.validator,
      builder: (field) {
        return DropdownSearch<SelectOptionModel>.multiSelection(
          key: widget.fbKey,
          selectedItems: _selectedItems,

          // NEW API (v6): one flexible items callback
          items: (String? filter, _) async {
            // Remote fetch has priority
            if (widget.onFind != null) {
              return await widget.onFind!(filter ?? '');
            }

            // Fallback to local list, optionally filter by label
            final local = widget.items ?? [];
            if (filter == null || filter.isEmpty) return local;
            return local
                .where(
                    (e) => e.label.toLowerCase().contains(filter.toLowerCase()))
                .toList();
          },

          compareFn: (a, b) => a.value == b.value,

          decoratorProps: DropDownDecoratorProps(
            decoration:
                widget.decoration.copyWith(hintText: widget.hintText.tr()),
          ),

          itemAsString: (item) => item.label,
          onChanged: (List<SelectOptionModel> newItems) {
            setState(() => _selectedItems = newItems);
            _setFieldValue(field);
          },
          dropdownBuilder: (context, selectedItems) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:
                //  selectedItems.isEmpty
                //     ? Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 14),
                //         child: Text(
                //           widget.hintText.tr(),
                //           style: TextStyle(color: theme.hintColor),
                //         ),
                //       )
                //     :
                Row(
              children: selectedItems
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InputChip(
                        label: Text(e.label),
                        onDeleted: () =>
                            widget.fbKey.currentState?.removeItem(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          popupProps: PopupPropsMultiSelection.dialog(
            showSearchBox: true,
            searchFieldProps:
                TextFieldProps(decoration: widget.searchFieldPropsDecoration),
            loadingBuilder: (_, __) => const LoadingWidget(),
            emptyBuilder: (_, __) => const Center(child: EmptyDataWidget()),
            disabledItemFn: (item) =>
                item.extra is bool ? (item.extra as bool) : false,
            onItemAdded: (sel, _) =>
                widget.fbKey.currentState?.changeSelectedItems(sel),
            onItemRemoved: (sel, removed) {
              widget.fbKey.currentState?.changeSelectedItems(sel);
              widget.removedItem?.call(removed);
            },
            validationBuilder: (_, __) => const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
