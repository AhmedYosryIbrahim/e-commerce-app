import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static void navigateNamedTo(
          {required BuildContext context,
          required String route,
          bool isRootNavigator = true,
          dynamic args}) =>
      Navigator.of(context, rootNavigator: isRootNavigator)
          .pushNamed(route, arguments: args);

  static void navigateNamedReplace(
          {required BuildContext context,
          required String route,
          dynamic args}) =>
      Navigator.pushReplacementNamed(context, route, arguments: args);

  static void navigateNamedFinish(
          {required BuildContext context,
          required String route,
          dynamic args}) =>
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);

  static void showToast(
      {required String message,
      required Toast toastLength,
      required ToastGravity gravity,
      required Color backgroundColor,
      required Color textColor,
      required double fontSize}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }
}
