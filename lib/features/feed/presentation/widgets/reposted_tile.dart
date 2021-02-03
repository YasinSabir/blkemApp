import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter/material.dart';
class RepostedTile extends StatefulWidget {
  @override
  _RepostedTileState createState() => _RepostedTileState();
}

class _RepostedTileState extends State<RepostedTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: context.getScreenWidth<321?210.toHeight:185.toHeight,
      alignment: Alignment.center,
      child: Column(
        children: [
          5.toSizedBox,
          [
            10.toSizedBox,
            AppIcons.repostIcon,
            10.toSizedBox,
            "YOU REPOSTED".toCaption(fontWeight: FontWeight.bold,fontSize: 9)].toRow().toHorizontalPadding(16),
          5.toSizedBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              25.toSizedBox,
              Stack(
                alignment: Alignment.center,
                children: [
                  // RotatedBox(quarterTurns: 45, child: Divider(thickness: 1.5)),
                  "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
                      .toNetWorkImage(borderRadius: 4)
                      .toContainer(
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
              [
                // 5.toSizedBox,
                [
                  "Michael Doe".toSubTitle1(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  20.toSizedBoxHorizontal,
                  Container(
                    height: 5,
                    width: 5,
                    decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  ),
                  5.toSizedBoxHorizontal,
                  "2hrs ago".toCaption(),
                  [ Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ).toContainer()
                      .toHorizontalPadding(4)
                      .toContainer(alignment: Alignment.centerRight,)].toRow(mainAxisAlignment: MainAxisAlignment.end).toExpanded()
                ]
                    .toRow(crossAxisAlignment: CrossAxisAlignment.center,)
                    .toContainer(alignment: Alignment.topCenter),
                "@micheal1".toSubTitle1(color: AppColors.colorPrimary),
                5.toSizedBox,
                // ["In response to".toCaption(fontSize: 13),
                //   5.toSizedBoxHorizontal,
                //   "Micheal Doe's".toButton(fontSize: 13,color: AppColors.colorPrimary),
                //   5.toSizedBoxHorizontal,
                //   "Post".toCaption(fontSize: 13)
                // ].toRow(),
                Padding(
                  padding: const EdgeInsets.only(right:12.0),
                  child: "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print"
                      .toSubTitle1(fontWeight: FontWeight.bold),
                ),
                8.toSizedBox,
                // [
                //   [
                //     // buildPostButton(AppIcons.commentIcon, "265").onTap(() {}),
                //     // buildPostButton(AppIcons.repostIcon, "13"),
                //     // buildPostButton(AppIcons.likeIcon, "3,469")
                //   ]
                //       .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                //       .toExpanded(flex: 4),
                //   getShareOptionMenu()
                //       .toContainer(alignment: Alignment(0.4,0))
                //       .toExpanded(flex: 1),
                // ].toRow(),
                // if(!widget.lastThread)
                //   Expanded(child: Container(child: Divider(thickness: .4,),))
              ].toColumn(mainAxisAlignment: MainAxisAlignment.start).toHorizontalPadding(12).toExpanded(flex: 4)

            ],
          ),
        ],
      ),
    );
  }
}
