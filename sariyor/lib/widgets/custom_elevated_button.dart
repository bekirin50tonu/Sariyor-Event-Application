import 'package:flutter/material.dart';
import 'package:sariyor/features/events/pages/index_page.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatefulWidget {
  CustomElevatedButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.deactiveLabel = "",
      this.onPressedDisabled,
      this.disabled = true})
      : super(key: key);

  Function()? onPressed;
  Function()? onPressedDisabled;
  String label;
  String deactiveLabel;
  bool disabled;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.disabled
            ? null
            : true
                ? () {
                    setState(() {
                      widget.onPressed!();
                    });
                  }
                : () {
                    setState(() {
                      widget.onPressedDisabled!();
                    });
                  },
        child: Text(true ? widget.label : widget.deactiveLabel),
        style: ElevatedButton.styleFrom(
            disabledMouseCursor: MouseCursor.uncontrolled,
            minimumSize: const Size(350, 50),
            primary: const Color.fromARGB(255, 178, 102, 201),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90))));
  }
}
