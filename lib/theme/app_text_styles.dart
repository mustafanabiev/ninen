import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle styleF20WNormal({Color? color}) => TextStyle(
        fontFamily: 'Alata',
        fontSize: 20.0,
        color: color ?? Colors.black,
        fontWeight: FontWeight.normal,
      );

  static TextStyle styleF16W400 = const TextStyle(
    fontFamily: 'Alata',
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    height: 24.0 / 16.0,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle styleF14WNormal({Color? color}) => TextStyle(
        fontFamily: 'Alata',
        fontSize: 14.0,
        color: color ?? Colors.black,
        fontWeight: FontWeight.normal,
      );
  static TextStyle styleF13W400({Color? color}) => TextStyle(
        fontFamily: 'Alata',
        fontSize: 13.0,
        color: color ?? Colors.black,
        fontWeight: FontWeight.w400,
        height: 13.0 / 13.0,
      );
}
