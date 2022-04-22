import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {Key? key,
      required this.label,
      required this.controller,
      this.validator,
      required this.secureText,
      this.inputType = TextInputType.text})
      : super(key: key);

  final String label;
  final TextEditingController controller;
  final String? Function(String)? validator;
  final bool secureText;
  final TextInputType inputType;
  bool obsecureText = true;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            suffixIcon: widget.secureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.obsecureText = !widget.obsecureText;
                      });
                    },
                    icon: Icon(
                      widget.obsecureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ))
                : null,
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
