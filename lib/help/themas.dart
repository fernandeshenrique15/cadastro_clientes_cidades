import 'package:flutter/material.dart';

class Themas {
  dark() {
    ThemeData newDark = ThemeData.from(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        onPrimary: Colors.green,
        primary: Colors.green,
        secondary: Colors.green,
        inversePrimary: Colors.white,
        onBackground: Color.fromARGB(255, 94, 93, 93),
        background: Color.fromARGB(255, 48, 48, 48),
      ),
    );

    return newDark;
  }

  light() {
    return ThemeData.light();
  }
}
