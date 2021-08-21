import 'package:flutter/material.dart';

class Commons {
  static double? deviceHeight, deviceWidth;
  static num s40 = 40, s41 = 41, s42 = 42;
  static num s415 = 41.5, s425 = 42.5;

  void build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
  }
}
