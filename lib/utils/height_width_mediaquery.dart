import 'package:flutter/material.dart';

class HeightWidth {
  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
