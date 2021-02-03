import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/features/feed/presentation/widgets/feed_widgets.dart';
import 'package:colibri/features/search/presentation/widgets/ThreadedPostItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:colibri/extensions.dart';
class PostViewScreen extends StatefulWidget {
  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  bool keyboardVisibility=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // KeyboardVisibilityController().onChange.listen((event) {
    //   setState(() {
    //     keyboardVisibility=event;
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return Scaffold(
      appBar: VxAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:  "Post".text.xl.extraBold.black.make(),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          ListView(children: [

            PostItem(isPostView: true,),
            3.toSizedBox,
            Divider(thickness: 1,),
            3.toSizedBox,
          ["5:58pm, 20 Aug, 2020".toCaption(fontSize: 10,fontWeight: FontWeight.bold),
          [
            "13".toCaption(color: AppColors.colorPrimary,fontWeight: FontWeight.bold),
            2.toSizedBoxHorizontal,
            "Repost".toCaption(),
            20.toSizedBoxHorizontal,
            "1K ".toCaption(color: AppColors.colorPrimary,fontWeight: FontWeight.bold),
            2.toSizedBoxHorizontal,
            "Likes".toCaption(),
            20.toSizedBoxHorizontal
          ].toRow(mainAxisAlignment: MainAxisAlignment.end).toExpanded()
          ].toRow().toHorizontalPadding(22),
            3.toSizedBox,
            Divider(thickness: 1,),
            ThreadedPostItem(),
            Divider(thickness: 1,),
            ThreadedPostItem(),
            Divider(thickness: 1,),
            ThreadedPostItem(),
          ],).box.margin(EdgeInsets.only(bottom: 100)).make(),
          Align(
            alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  5.toSizedBox,
                  ["Replying to".toCaption(),
                    3.toSizedBoxHorizontal,
                    "@micheal".toCaption(color: AppColors.colorPrimary,fontWeight: FontWeight.bold)].toRow().toHorizontalPadding(16),
                  "Reply".toTextField(icon: Images.message,).onInkTap(() {
                    context.showToast(msg: "Tapped");
                  }),
                  [AppIcons.imageIcon(),
                    15.toSizedBoxHorizontal,
                    AppIcons.videoIcon(),
    15.toSizedBoxHorizontal,
                    AppIcons.smileIcon,
                    15.toSizedBoxHorizontal,
                    AppIcons.gifIcon(),
                    ["Reply".toCaption(color: Colors.white,fontWeight: FontWeight.bold).toMaterialButton(() { })].toRow(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.end).toContainer(height: 30).toExpanded(),
                  ].toRow(crossAxisAlignment: CrossAxisAlignment.center).toSymmetricPadding(12,8).toSteamVisibility(KeyboardVisibilityController().onChange)
                ],
              ).box.white.border(color: Colors.black12,width: 1).make())
        ],
      ),
    );
  }
}
