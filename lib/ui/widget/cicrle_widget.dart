import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  late Widget child;
  late Color colorArgs;
  late double size;

  CircleWidget(
      {Key? key,
      required this.child,
      required this.size,
      required this.colorArgs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      // padding: EdgeInsets.a,
      decoration: BoxDecoration(
        color: colorArgs,
        border: Border.all(
          color: colorArgs,
        ),
        shape: BoxShape.circle,
      ),
      // child: whiteSmallText('1'),
      child: child,
    );
  }
}
