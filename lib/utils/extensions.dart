import 'package:flutter/material.dart';

extension GetOffset on GlobalKey {
  Offset position() {
    RenderBox box = currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    return position;
  }
}
