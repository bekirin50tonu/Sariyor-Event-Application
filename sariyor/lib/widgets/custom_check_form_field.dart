import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCheckFormField extends StatefulWidget {
  CustomCheckFormField(
      {Key? key,
      required this.onChanged,
      required this.text,
      required this.state})
      : super(key: key);
  final Function(bool) onChanged;
  final String text;
  bool state;
  @override
  State<CustomCheckFormField> createState() => _CustomCheckFormFieldState();
}

class _CustomCheckFormFieldState extends State<CustomCheckFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: CheckboxListTile(
        value: widget.state,
        onChanged: (value) {
          widget.onChanged(value!);
          setState(() {
            widget.state = value;
          });
        },
        title: Text(
          widget.text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
