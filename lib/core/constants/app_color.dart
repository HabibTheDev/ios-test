import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Light Theme
  static const Color primaryColor = Color(0xff2D65F2);
  static const Color lightBgColor = Color(0xffF5F9FC);
  static const Color errorColor = Color(0xffFF0000);
  static const Color warningColor = Color(0xffD35500);
  static const Color deleteBgColor = Color(0xffFFE0E0);
  static const Color emojiColor = Colors.amber;
  static const Color newDamageBlockColor = Color(0xffFFEDEE);
  static const Color lightCardColor = Colors.white;
  static const Color lightAppBarIconColor = Colors.white;
  static const Color lightOutlineButtonColor = Color(0xffDDDDDD);
  static const Color lightProgressColor = Colors.green;
  static const Color lightDialogGreenColor = Color(0xff4DB429);
  static const Color lightProgressTrackColor = Colors.white;
  static const Color awaitingColor = Color(0xff02636F);
  static const Color inProgressColor = Color(0xff939607);
  static const Color disablePrimaryColor = Color(0xff82A6ED);
  static const Color lightCardProgressTrackColor = Color(0xffF6F6F6);

  // Text
  static const Color lightTextColor = Colors.black;
  static const Color lightSecondaryTextColor = Color(0xff6F6464);
  static const Color buttonTextColor = Colors.white;
  // Textfield
  static const Color lightTextFieldHintColor = Color(0xff999999);
  static const Color lightTextFieldFillColor = Color(0xffF6F6F6);
  static const Color lightBorderColor = Color(0xffF6F6F6);
  static const Color lightCursorColor = primaryColor;

  //chat
  static const Color lightCurrentUserChatColor = Color(0xffD8D8D8);
  static const Color lightOtherUserChatColor = Color(0xffF5F9FC);

  static const damageColorList = [
    Color(0xffFFE0E0),
    Color(0xffFFC2C2),
    Color(0xffFFA3A3),
    Color(0xffFF8585),
    Color(0xffFF6666),
  ];

  // Primary swatch
  static const int primarySwatch = 0xff2196f3;
  static const Map<int, Color> primaryColorMap = {
    50: Color.fromRGBO(45, 101, 242, .1),
    100: Color.fromRGBO(45, 101, 242, .2),
    200: Color.fromRGBO(45, 101, 242, .3),
    300: Color.fromRGBO(45, 101, 242, .4),
    400: Color.fromRGBO(45, 101, 242, .5),
    500: Color.fromRGBO(45, 101, 242, .6),
    600: Color.fromRGBO(45, 101, 242, .7),
    700: Color.fromRGBO(45, 101, 242, .8),
    800: Color.fromRGBO(45, 101, 242, .9),
    900: Color.fromRGBO(45, 101, 242, 1),
  };
}
