import 'dart:math';

import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/widgets/feed_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThreadedPostItem extends StatefulWidget {
  final bool startingThread;
  final bool lastThread;

  const ThreadedPostItem(
      {Key key, this.startingThread = false, this.lastThread = false})
      : super(key: key);

  @override
  _ThreadedPostItemState createState() => _ThreadedPostItemState();
}

class _ThreadedPostItemState extends State<ThreadedPostItem> {
  bool isLiked=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getScreenWidth<321?220.toHeight:195.toHeight,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          25.toSizedBox,
          Stack(
            alignment: Alignment.center,
            children: [
              // Visibility(
              //     visible: !widget.lastThread,
              //     child: RotatedBox(quarterTurns: 45, child: Divider(thickness: 1.5))),
              "https://i.pravatar.cc/150?img=3"
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
                          "@micheal1".toSubTitle1(),
                          5.toSizedBox,
                          ["In response to".toCaption(fontSize: 13),
                            5.toSizedBoxHorizontal,
                            "Micheal Doe's".toButton(fontSize: 13,color: AppColors.colorPrimary),
                            5.toSizedBoxHorizontal,
                            "Post".toCaption(fontSize: 13)
                          ].toRow(),
                              Padding(
                                padding: const EdgeInsets.only(right:12.0),
                                child: "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print"
                                    .toSubTitle1(fontWeight: FontWeight.bold),
                              ),
                                 8.toSizedBox,
                                 [
                                   [
                                    buildPostButton(AppIcons.commentIcon, "265").onTap(() {}),
                                    buildPostButton(AppIcons.repostIcon, "13"),
                                    buildPostButton(isLiked?AppIcons.heartIcon:AppIcons.likeIcon, "3,469",isLiked: isLiked).onTap(() {
                                      setState(() {
                                        isLiked=!isLiked;
                                      });
                                    })
                                  ]
                                      .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                                      .toExpanded(flex: 4),
                                  getShareOptionMenu()
                                      .toContainer(alignment: Alignment(0.4,0))
                                      .toExpanded(flex: 1),
                                ].toRow(),
            if(!widget.lastThread)
            Expanded(child: Container(child: Divider(thickness: .4,),)),
            ["View all 8 comments".toCaption(fontWeight: FontWeight.bold),Icon(Icons.keyboard_arrow_down)].toRow(crossAxisAlignment: CrossAxisAlignment.center)
          ].toColumn(mainAxisAlignment: MainAxisAlignment.start).toHorizontalPadding(12).toExpanded(flex: 4)

        ],
      ),
    );
  }
}
