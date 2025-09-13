import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum FontFamily {
  Lexend_Bold,
  Lexend_Light,
  Lexend_Medium,
  Lexend_Regular,
  Lexend_SemiBold,
  Lexend_VariableWgt,
}

extension FontFamilyExtension on FontFamily {
  String get name {
    switch (this) {
      case FontFamily.Lexend_Bold:
        return "Lexend-Bold";
      case FontFamily.Lexend_Light:
        return "Lexend-Light";
      case FontFamily.Lexend_Medium:
        return "Lexend-Medium";
      case FontFamily.Lexend_Regular:
        return "Lexend-Regular";
      case FontFamily.Lexend_SemiBold:
        return "Lexend-SemiBold";
      case FontFamily.Lexend_VariableWgt:
        return "Lexend-VariableWeight";
    }
  }
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

void showFlutterToast(BuildContext context, String msg) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    textColor: Colors.white,
    fontAsset: "assets/fonts/Lexend-Regular.ttf"
  );
}
