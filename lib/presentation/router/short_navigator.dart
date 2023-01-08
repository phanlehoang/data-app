import 'package:flutter/material.dart';

class Navi {
  void pushReplacementName(BuildContext context, String x) {
    Navigator.of(context, rootNavigator: true).pushReplacementNamed(x);

    void pushName(BuildContext context, String x) {
      Navigator.of(context, rootNavigator: true).pushNamed(x);
    }
  }
}
