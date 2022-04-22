import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatefulWidget {
  CustomElevatedButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.disabled = false})
      : super(key: key);
  Function? onPressed;
  String label;
  bool disabled;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  _onPressed() {
    if (widget.onPressed != null) {
      return widget.onPressed!();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            widget.disabled ? null : _onPressed();
          });
        },
        child: Text(widget.label),
        style: ElevatedButton.styleFrom(
            disabledMouseCursor: MouseCursor.uncontrolled,
            minimumSize: const Size(350, 50),
            primary: const Color.fromARGB(255, 178, 102, 201),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90))));
  }
}
