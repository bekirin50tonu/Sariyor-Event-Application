import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomMultiTextFormField extends StatefulWidget {
  CustomMultiTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    required this.secureText,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final String? Function(String)? validator;
  final bool secureText;
  bool obsecureText = true;

  @override
  State<CustomMultiTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomMultiTextFormField> {
  _validator(String value) {
    if (widget.validator != null) {
      return widget.validator!(value);
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
          obscureText: widget.secureText ? widget.obsecureText : false,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          maxLength: 100,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: widget.label,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90)),
            ),
          ),
          controller: widget.controller,
          validator: (value) => _validator(value!)),
    );
  }
}
