import 'package:flutter/material.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';


class CustomContainerWidget extends StatelessWidget {
  Widget child;
  Color color;
  double radius;
  double paddingHorizontal;
  double paddingVertical;
  double width;
  Color? borderColor;

  CustomContainerWidget(
      {Key? key,
      required this.child,
      required this.radius,
      required this.color,
      required this.paddingHorizontal,
      required this.paddingVertical,
      this.borderColor,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor ?? ColorSource.gray, // red as border color
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          )),
      child: child,
    );
  }
}

class CustomContainerWithHeight extends StatelessWidget {
  Widget widget;
  Color color;
  double radius;
  double paddingHorizontal;
  double paddingVertical;
  double width;
  double height;
  Color? borderColor;

  CustomContainerWithHeight(
      {Key? key,
      required this.widget,
      required this.radius,
      required this.color,
      required this.paddingHorizontal,
      required this.paddingVertical,
      this.borderColor,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor ?? ColorSource.gray, // red as border color
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          )),
      child: widget,
    );
  }
}

class CustomBox extends StatelessWidget {
  Color color;
  double radius;
  double paddingHorizontal;
  double paddingVertical;
  VoidCallback? onTap;
  double? fontSize;
  Color? borderColor;
  FontWeight? fontWeight;
  Widget widget;

  CustomBox(
      {Key? key,
      required this.radius,
      required this.color,
      required this.paddingHorizontal,
      required this.paddingVertical,
      required this.widget,
      this.onTap,
      this.fontSize,
      this.borderColor,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: borderColor ?? ColorSource.gray, // red as border color
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            )),
        child: widget,
      ),
    );
  }
}
