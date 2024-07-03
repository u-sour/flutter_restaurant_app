import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_template/utils/constants.dart';

class FormBuilderTouchSpin extends StatefulWidget {
  final String name;
  final String? initialValue;
  final AutovalidateMode autovalidateMode;
  final int minValue;
  final int maxValue;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String style;
  // final InputDecoration decoration;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final IconData decrementIcon;
  final IconData incrementIcon;
  final VoidCallback? onTap;
  final ValueChanged<num> onChanged;
  final bool enableButton;

  const FormBuilderTouchSpin({
    super.key,
    required this.name,
    this.initialValue,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.minValue = 0,
    this.maxValue = 10000,
    required this.controller,
    this.keyboardType,
    this.style = 'normal',
    // required this.decoration,
    this.inputFormatters,
    this.validator,
    this.onTap,
    required this.onChanged,
    this.enableButton = true,
    this.decrementIcon = Icons.remove,
    this.incrementIcon = Icons.add,
  });

  @override
  State<FormBuilderTouchSpin> createState() {
    return _FormBuilderTouchSpinState();
  }
}

class _FormBuilderTouchSpinState extends State<FormBuilderTouchSpin> {
  num _value = 0;
  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      _value = num.parse(widget.controller.text);
    }
  }

  void _setQtyTextField({required String value}) {
    widget.controller.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilledButton(
          style: FilledButton.styleFrom(
            elevation: 0.0,
            padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(2.0),
            // ),
          ),
          onPressed: widget.enableButton
              ? () {
                  if (_value > widget.minValue && _value <= widget.maxValue) {
                    _value--;
                    //set qty text field
                    _setQtyTextField(value: '$_value');
                    //set onchange value text field
                    setState(() {
                      widget.onChanged(_value);
                    });
                  }
                }
              : null,
          child: Icon(widget.decrementIcon),
        ),
        const SizedBox(width: AppStyleDefaultProperties.w / 2),
        Expanded(
          child: FormBuilderTextField(
            name: widget.name,
            initialValue: widget.initialValue,
            autovalidateMode: widget.autovalidateMode,
            // decoration: widget.decoration,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            onTap: widget.onTap,
            onChanged: (String? value) {
              _value = (value != null ? num.tryParse(value) ?? 0 : 0);
              if (_value >= widget.minValue && _value < widget.maxValue) {
                setState(() {
                  widget.onChanged(_value);
                });
              }
            },
            validator: widget.validator,
          ),
        ),
        const SizedBox(width: AppStyleDefaultProperties.w / 2),
        FilledButton(
          style: FilledButton.styleFrom(
            elevation: 0.0,
            padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(2.0),
            // ),
          ),
          onPressed: widget.enableButton
              ? () {
                  if (_value < widget.maxValue) {
                    _value++;
                    //set qty text field
                    _setQtyTextField(value: '$_value');
                    //set onchange value text field
                    setState(() {
                      widget.onChanged(_value);
                    });
                  }
                }
              : null,
          child: Icon(widget.incrementIcon),
        ),
      ],
    );
  }
}
