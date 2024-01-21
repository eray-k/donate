import 'package:flutter/material.dart';

extension on double {
  double w() {
    return this * 0.5;
  }
}

Widget verticalSpacer(double height) {
  return SizedBox(height: height);
}

Widget horizontalSpacer(double width) {
  return SizedBox(width: width);
}
