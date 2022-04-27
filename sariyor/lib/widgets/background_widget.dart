import 'package:flutter/material.dart';

Widget backgroundImageWidget(Widget child) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.black,
      image: DecorationImage(
          image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
    ),
    child: child,
  );
}
