import 'package:flutter/material.dart';

class ColorSource {
  // primary color
  static const Color primaryColor = Color(0xFF1484FF);
  static const Color primaryColorOpacity50 = Color(0x801484FF);
  static const Color primaryColorOpacity10 = Color(0x1A1484FF);
  static const Color red = Color(0xFFEB3B5A);
  static const Color green = Color(0xFF44BD32);
  static const Color blackOverlayBg = Color(0x99272A2A);
  static const Color blackBg = Color(0xFF272A2A);
  static const Color greenButton = Color(0xFF04C99E);

  //text color
  static const Color textColor = Color(0xFF2E3235);
  static const Color textGrey2 = Color(0xFFB4B4B4);
  static const Color textGrey = Color(0xFF979797);
  static const Color textGrey3 = Color(0xFF8C8C8C);
  static const Color textGrey4 = Color(0xFF787878);
  static const Color hintColor = Color(0xFFC8C8C8);
  static const lightGray = Color(0xFFF2F2F2);
  static const gray2 = Color(0xFFF4F6FA);
  static const black = Colors.black;
  static const Color gray = Color(0xFFDBDDE5);
  static const Color white = Colors.white;
  static const gray1 = Color(0xFF333333);
  static const Color dark = Color(0xFF31354B);
  static const black2 = Color(0xFF282828);
  static const grey1 = Color(0xFFA2A7C3);
  static const yellow = Color(0xFFB29917); // #B29917
  static const orange = Color(0xFFFFA500); // #FFA500
  static const milo = Color(0xFF73361C); // #73361C
  static const brown = Color(0xFF964B00); // #964B00
  static const navy = Color(0xFF010151); //#010151
  static const maroon = Color(0xFF800000); //#800000
  static const grey = Color(0xFF909497); //#909497
  static const lightPrimaryColor = Color(0xFFeb837a);

  static const brownHex = "#964B00";
  static const maroonHex = "#800000";
  static const navyHex = "#010151";
  static const orangeHex = "#FFA500";
  static const miloHex = "#73361C";

// static const grey = Color(0xFF909497);//#909497
}

//SAMPLE HEX COLOR #1484FF DIRUBAH KE FF1484FF
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// Following are some example transparency percentages and their hex values
//  table of percentages to hex values
//  100% — FF
//  95% — F2
//  90% — E6
//  85% — D9
//  80% — CC
//  75% — BF
//  70% — B3
//  65% — A6
//  60% — 99
//  55% — 8C
//  50% — 80
//  45% — 73
//  40% — 66
//  35% — 59
//  30% — 4D
//  25% — 40
//  20% — 33
//  15% — 26
//  10% — 1A
//  5% — 0D
//  0% — 00
//For an example if you want 50% transparent white color you have to use #80FFFFFF color code
