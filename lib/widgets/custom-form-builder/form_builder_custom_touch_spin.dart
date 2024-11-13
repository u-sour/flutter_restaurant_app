import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../utils/constants.dart';

class FormBuilderCustomTouchSpin extends StatefulWidget {
  final String name;
  final num initialValue;
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

  const FormBuilderCustomTouchSpin({
    super.key,
    required this.name,
    this.initialValue = 0,
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
  State<FormBuilderCustomTouchSpin> createState() {
    return _FormBuilderCustomTouchSpinState();
  }
}

class _FormBuilderCustomTouchSpinState
    extends State<FormBuilderCustomTouchSpin> {
  num _value = 0;
  @override
  void initState() {
    super.initState();
    // init text field value
    _setQtyTextField(
        value: widget.minValue != 0 && widget.initialValue == 0
            ? '${widget.minValue}'
            : '${widget.initialValue}');

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
            padding: const EdgeInsets.all(AppStyleDefaultProperties.p + 4.0),
          ),
          onPressed: widget.enableButton
              ? () {
                  if (_value > widget.minValue && _value <= widget.maxValue) {
                    _value--;
                    //set qty text field
                    _setQtyTextField(value: '$_value');
                    //set onChanged value text field
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
            autovalidateMode: widget.autovalidateMode,
            textAlign: TextAlign.center,
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
            padding: const EdgeInsets.all(AppStyleDefaultProperties.p + 4.0),
          ),
          onPressed: widget.enableButton
              ? () {
                  if (_value < widget.maxValue) {
                    _value++;
                    //set qty text field
                    _setQtyTextField(value: '$_value');
                    //set onChanged value text field
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
