import 'package:flutter/material.dart';

class MessageBorder extends ShapeBorder {
  final bool usePadding;
  final double triangleXOffset;

  MessageBorder({this.usePadding = true, required this.triangleXOffset});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(
      bottom: usePadding ? 20 : 0,
      left: usePadding ? 16 : 0,
      right: usePadding ? 16 : 0);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - Offset(0, 20));
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(8)))
      // ..moveTo(rect.bottomCenter.dx - xCoordinate, rect.bottomCenter.dy)
      ..moveTo(triangleXOffset, rect.bottomCenter.dy)
      ..relativeLineTo(10, 20)
      ..relativeLineTo(15, -20)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }
}
