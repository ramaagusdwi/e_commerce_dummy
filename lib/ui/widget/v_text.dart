import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/utils/utils.dart';

Widget vText(
  String title, {
  Color color = Colors.black,
  double? fontSize,
  FontWeight? fontWeight,
  TextOverflow overflow = TextOverflow.fade,
  TextAlign align = TextAlign.left,
  bool money = false,
  bool number = false,
  bool poppins = true,
  decoration,
  int maxLines = 1,
  letterSpacing,
  FontStyle? fontStyle,
}) {
  return Text(
    title != null && title != "null"
        ? money || number
            ? Utils.formatNumberToRupiah(int.parse(title))
            : title
        : title,
    style: GoogleFonts.poppins(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      fontStyle: fontStyle ?? FontStyle.normal,
      letterSpacing: letterSpacing ?? null,
    ),
    overflow: overflow,
    textAlign: align,
    maxLines: maxLines,
  );
}

Widget normalTextGray1Center(String title) {
  return vText(title,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorSource.gray1,
      align: TextAlign.center);
}

Widget largeTextBlackBold(String title) {
  return vText(title,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: ColorSource.dark,
      align: TextAlign.center,
      maxLines: 100);
}

Widget normalBlackBold(String title) {
  return vText(title,
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: ColorSource.dark,
      maxLines: 100);
}

Widget lightText(String title) {
  return vText(title,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorSource.black2,
      overflow: TextOverflow.ellipsis,
      maxLines: 100);
}

Widget lightTextNormal(String title) {
  return vText(title,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: ColorSource.black2,
      overflow: TextOverflow.ellipsis,
      maxLines: 100);
}

Widget mediumText(String title) {
  return vText(title,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: ColorSource.black2,
      maxLines: 100);
}

Widget largeText(String title) {
  return vText(title,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: ColorSource.black2,
      maxLines: 100);
}


Widget normalText(String title) {
  return vText(title,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorSource.black2,
      maxLines: 100);
}

Widget titleTextBig(String title) {
  return vText(title, fontWeight: FontWeight.w700, fontSize: 16);
}

Widget whiteSmallText(String title) {
  return vText(title,
      fontWeight: FontWeight.w500,
      fontSize: 10,
      align: TextAlign.center,
      color: ColorSource.white,
      maxLines: 100);
}

