import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppColor {
  static const Color darkBlueColor = Color(0xff474c6f);
  static const Color lightBlueColor = Color(0xffb3b4c6);
}

DateTime now = DateTime.now();
String todayDate = DateFormat.yMMMd().format(now);
