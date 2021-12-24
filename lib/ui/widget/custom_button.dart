import 'package:flutter/material.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';

class CustomButton extends StatelessWidget {
  final String titleButton;
  final double heightButton;
  final double paddingHorizontal;
  final VoidCallback callback; // Notice the variable type

  CustomButton(
    this.titleButton, {
    required this.heightButton,
    required this.paddingHorizontal,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          width: double.infinity,
          height: heightButton,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ColorSource.primaryColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  color: const Color(0xffFDD5BB),
                ),
              ]),
          child: Text(
            titleButton,
            style: TextStyle(
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
