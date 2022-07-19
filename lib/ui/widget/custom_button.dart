import 'package:flutter/material.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';

class CustomButton extends StatelessWidget {
  final String titleButton;
  final double heightButton;
  final double? widthButton;
  final double outerPaddingHorizontal;
  final VoidCallback callback; // Notice the variable type
  final double? radius;
  final Color? color;
  final double? padding;
  final TextStyle? textStyle;

  CustomButton(
    this.titleButton, {
    required this.heightButton,
    required this.outerPaddingHorizontal,
    required this.callback,
    this.widthButton,
    this.radius,
    this.color,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: outerPaddingHorizontal),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          padding: EdgeInsets.all(padding ?? 16),
          width: widthButton ?? double.infinity,
          height: heightButton,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 15),
            color: color ?? ColorSource.primaryColor,
          ),
          child: Text(
            titleButton,
            style: textStyle ??
                TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
          ),
        ),
      ),
    );
  }
}
