import 'package:colibri/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:colibri/extensions.dart';
Widget getHastTagItem({title:String}) {
  return [
    // 10.toSizedBoxHorizontal,
    Icon(
      FontAwesomeIcons.hashtag,
      color: AppColors.colorPrimary,
      size: 22,
    ).toPadding(12)
        .toContainer(
            decoration: BoxDecoration(
              color: AppColors.colorPrimary.withOpacity(.2),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.colorPrimary, width: .3)))
        // .toExpanded(flex: 1)
        .toCenter(),
    20.toSizedBoxHorizontal,
    ["$title".toSubTitle2(fontWeight: FontWeight.bold), "21 Posts".toCaption(fontSize: 10.toSp)]
        .toColumn()
        // .toExpanded(flex: 4)
  ]
      .toRow(crossAxisAlignment: CrossAxisAlignment.center)
      .toPadding(12)

  .toFlatButton(() { }).toContainer(color: Colors.white).makeBottomBorder;
}
var dummyHashTags=["#dogs",
    "#instagramdogs",
"#dogstagram",
"#ilovedog",
"#ilovedogs",
"#doglover",
"#dogoftheday",
"#pet#pets",
"#dogsofinstagram",
"#ilovemydog",
"#doggy",
"#dog",
"#cute",
"#adorable",
"#precious",
"#nature",
"#animal",
"#animals",
"#puppy",
"#puppies",
"#pup",
"#petstagram",
"#picpets",
"#cutie",
"#life",
"#petsagram",
"#tagblender",
"#doglovers",
"#tail"];