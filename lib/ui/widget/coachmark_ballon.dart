import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_mobile_apps_dev/resources/colors.dart';
import 'package:test_mobile_apps_dev/resources/text_styles.dart';
import 'package:test_mobile_apps_dev/ui/widget/custom_button.dart';
import 'package:test_mobile_apps_dev/ui/widget/message_border.dart';

class CoachMarkBallon extends StatelessWidget {
  VoidCallback callback;
  final String descriptionLine1;
  final String descriptionLine2;

  CoachMarkBallon(
      {Key? key,
      required this.callback,
      required this.descriptionLine1,
      required this.descriptionLine2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 320,
      decoration: ShapeDecoration(
        color: ColorSource.blackBg,
        shape: MessageBorder(),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                descriptionLine1,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyleSource.fInter13White
                    .copyWith(fontWeight: FontWeight.w300, height: 1.3),
              ),
              Text(
                descriptionLine2,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyleSource.fInter13White
                    .copyWith(fontWeight: FontWeight.w300, height: 1.3),
              ),
            ],
          )),
          CustomButton(
            "Mengerti",
            heightButton: 32,
            widthButton: 72,
            outerPaddingHorizontal: 0,
            radius: 6,
            color: ColorSource.greenButton,
            padding: 7,
            textStyle: TextStyleSource.fInter13White
                .copyWith(fontWeight: FontWeight.w600),
            callback: () {
              callback();
              log("button pressed");
            },
          ),
        ],
      ),
    );
  }
}
