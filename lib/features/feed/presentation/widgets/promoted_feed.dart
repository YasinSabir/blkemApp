import 'package:colibri/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
class PromotedWidget extends StatefulWidget {
  @override
  _PromotedWidgetState createState() => _PromotedWidgetState();
}

class _PromotedWidgetState extends State<PromotedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(child: [
      "Promoted".toHeadLine6(fontWeight: FontWeight.bold).toHorizontalPadding(4),
        [
          "Donation".toCaption(fontWeight: FontWeight.bold),
            5.toSizedBox,
            "Many have asked us for a way to donate but, we are not relying on".toCaption(fontWeight: FontWeight.bold),
          5.toSizedBox,
          "https://www.fillmurray.com/640/360".toNetWorkImage(borderRadius: 0,width: context.getScreenWidth,height: 150),
          10.toSizedBox,
          [
            ["Anything helps".toCaption(),
              "www.dummy.com".toCaption(fontWeight: FontWeight.bold,color: AppColors.colorPrimary)].toColumn(),
            "Learn More".toCaption().toOutlinedBorder(() { },borderRadius: 2)
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
        ].toColumn().toPadding(12).toContainer(color: AppColors.lightSky)
    ].toColumn(),).toSymmetricPadding(30, 12);
  }
}
