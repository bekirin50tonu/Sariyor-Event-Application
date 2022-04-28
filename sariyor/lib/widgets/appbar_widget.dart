import 'package:flutter/material.dart';

AppBar buildAppBarWidget() => AppBar(
      backgroundColor: Colors.transparent,
      elevation: 1,
      centerTitle: true,
      title: const Image(
        height: 50,
        fit: BoxFit.scaleDown,
        image: AssetImage('images/image17.png'),
      ),
    );
