import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter/material.dart';

class PeopleItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return [
      20.toSizedBoxHorizontal,
      "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
          .toRoundNetworkImage(radius: 10),
      20.toSizedBoxHorizontal,
      [
        "Micheal Joe".toSubTitle2(fontWeight: FontWeight.bold),
        "@micheal.joe".toCaption(fontSize: 10.toSp)
      ].toColumn(),
      [
        "Follow".toCaption(color: AppColors.colorPrimary).toHorizontalPadding(12).toVerticalPadding(4).toContainer(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.colorPrimary, width: 1)),
            alignment: Alignment.centerRight).onTap(() { })
      ].toRow(mainAxisAlignment: MainAxisAlignment.end).toExpanded(),
      20.toSizedBoxHorizontal,
    ]
        .toRow(crossAxisAlignment: CrossAxisAlignment.center)
        .toVerticalPadding(12)
        .toContainer().makeBottomBorder;
  }
}
