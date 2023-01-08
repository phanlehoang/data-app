import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

late double widthDevide;
late double heightDevide;

double widthDevideMethod(BuildContext context, double i) {
  //width of device
  return MediaQuery.of(context).size.width * i;
}

double heightDevideMethod(BuildContext context, double i) {
  //height of device
  return MediaQuery.of(context).size.height * i;
}

// show toast infomation
