import 'dart:wasm';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:colibri/core/datasource/local_data_source.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/core/widgets/slider.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:colibri/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
class PostItem extends StatefulWidget {
  final bool showThread;
  final bool showArrowIcon;
  final bool otherUser;
   bool isLiked;
  final bool isInterest;
  final bool isPostView;
   PostItem({Key key,
    this.isPostView=false,
    this.isInterest=false, this.showThread=true, this.showArrowIcon=false, this.otherUser=false,this.isLiked=false}) : super(key: key);
  @override
  _PostItemState createState() => _PostItemState(otherUser: otherUser);
}

class _PostItemState extends State<PostItem> {
  final bool otherUser;

  _PostItemState({this.otherUser=false});
  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return _postItem(otherUser: this.otherUser);
  }
  Widget _postItem({showThread = true,showArrowIcon=true,otherUser=false}) {
    return InkWell(
      onTap: (){
        if(!widget.isPostView)
        ExtendedNavigator.root.push(Routes.postViewScreen);
      },
      child: Container(

        // decoration: BoxDecoration(  color: Colors.white,border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3),width: 1.5))),
        child: Column(children: [
          16.toSizedBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              [
                "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
                    .toNetWorkImage(borderRadius: 4)
                    .toContainer(
                  alignment: Alignment.topRight,
                ).toVerticalPadding(8).onTap(() {
                  BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.profile(ProfileScreenArguments(otherUser: true)));
                }),
                10.toSizedBoxHorizontal,
              ].toRow(mainAxisAlignment: MainAxisAlignment.end).toExpanded(flex: 2),
              [
                12.toSizedBox,
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
                ]
                    .toRow(crossAxisAlignment: CrossAxisAlignment.center)
                    .toContainer(),
                "@micheal1".toSubTitle1().onTap(() {
                  BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.profile(ProfileScreenArguments(otherUser: true)));
                }),
                // 20.toSizedBox,
              ]
                  .toColumn(mainAxisAlignment: MainAxisAlignment.center)
                  .toExpanded(flex: 8),
              if(!widget.isInterest)
              getPostOptionMenu(showThread,showArrowIcon,otherUser)
              else ["Follow @micheal","Block @micheal"].toPopUpMenuButton((value) { },icon:Icon(Icons.keyboard_arrow_down,color: Colors.grey.withOpacity(.8),))
            ],
          ).toHorizontalPadding(12),
          [
            // 10.toSizedBox,
            5.toSizedBox.toExpanded(flex: 1),
            [

              10.toSizedBox,
              CustomSlider(),

                // 10.toSizedBox,

                [
                  "1.5m".toCaption(color: AppColors.colorPrimary,fontWeight: FontWeight.bold),
                  4.toSizedBoxHorizontal,
                  "Views".toCaption(),
                  ["https://i.pravatar.cc/150?img=1".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),
                    "https://i.pravatar.cc/150?img=2".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),
                    "https://i.pravatar.cc/150?img=3".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),
                    "https://i.pravatar.cc/150?img=4".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),
                    "https://i.pravatar.cc/150?img=5".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),].toRow(mainAxisAlignment: MainAxisAlignment.end).toContainer(alignment: Alignment.centerRight).toExpanded()
                ].toRow(),
              10.toSizedBox,
              "Lorem ipsum, or lipsum as it is sometimes known,c"
                  .toSubTitle1(fontWeight: FontWeight.bold),
              // 10.toSizedBox,
              // AspectRatio(
              //   aspectRatio: 16 / 11,
              //   child:
              //   "https://images.pexels.com/photos/747964/pexels-photo-747964.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
              //       .toNetWorkImage(
              //       height: 150, width: double.infinity, borderRadius: 8),
              // ),
              // 15.toSizedBox,
              [
                [
                  buildPostButton(AppIcons.commentIcon, "265").toVerticalPadding(8).onTap(() {
                    showAnimatedDialog(

                        context: context, builder: (c)=> Dialog(

                      insetPadding: EdgeInsets.all(8),

                      // contentPadding: EdgeInsets.zero,
                      child: BlocProvider.value(
                          value: getIt<FeedCubit>(), child: CreatePostCard(title: "Replying to @tommy",)),
                    ));
                  }),
                  buildPostButton(AppIcons.repostIcon, "13").toPadding(8).onTap(() {
                    showModalBottomSheet(context: context, builder: (c){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Images.repost.toSvg(height: 18, width: 18,color: AppColors.colorPrimary),
                            10.toSizedBoxHorizontal,
                            "Repost".toSubTitle2()
                          ],
                        ),
                        10.toSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Images.repostComment.toSvg(height: 18, width: 18,color: AppColors.colorPrimary),
                            10.toSizedBoxHorizontal,
                            "Repost and Comment".toSubTitle2()
                          ],
                        ),
                      ],).toSymmetricPadding(12,24).onTap(() { ExtendedNavigator.root.pop();});
                    });
                  }),
                  buildPostButton(widget.isLiked?AppIcons.heartIcon:AppIcons.likeIcon, "3,469",isLiked: widget.isLiked).toPadding(8).onTap(() {
                    setState(() {
                      widget.isLiked=!widget.isLiked;
                    });
                  })
                ]
                    .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                    .toExpanded(flex: 4),
                getShareOptionMenu().toPadding(8)
                    .toContainer(alignment: Alignment.centerRight)
                    .toExpanded(flex: 1),
              ].toRow(),
              15.toSizedBox,
            ]
                .toColumn(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start)
                .toExpanded(flex: 18),
            10.toSizedBox.toExpanded(flex: 1)
          ].toRow(),
        ]),
      ),
    );
  }
}



class GetDrawerMenu extends StatefulWidget {
  @override
  _GetDrawerMenuState createState() => _GetDrawerMenuState();
}

class _GetDrawerMenuState extends State<GetDrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return getDrawerMenu();
  }
  Widget getDrawerMenu() {
    return Column(
      // Important: Remove any padding from the ListView.
      // padding: EdgeInsets.zero,
      children: <Widget>[
        // DrawerHeader(
        //   curve: Curves.bounceInOut,
        //   child:
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     border: Border(bottom: BorderSide(color: Colors.white,width: 0.0,style: BorderStyle.),),
        //   ),
        // ),
        // 10.toSizedBox,
        [
          [
            Hero(
              tag: 1256,
              child: "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
                  .toRoundNetworkImage(radius: 17),
            ).onTap(() {
              ExtendedNavigator.root.pop();
              BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.profile(ProfileScreenArguments(otherUser: false)));
            })
          ].toRow(crossAxisAlignment: CrossAxisAlignment.center),
          [
            "Michael Doe"
                .toSubTitle1(color: Colors.black, fontWeight: FontWeight.bold),
            5.toSizedBoxHorizontal,
            AppIcons.verifiedIcons
          ].toRow(crossAxisAlignment: CrossAxisAlignment.center),
          "@micheal.01".toBody2(),
          10.toSizedBox,
          [
            [
              "155".toCaption(
                  color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
              2.toSizedBox,
              "Posts".toCaption(),
              10.toSizedBoxHorizontal,
              "136".toCaption(
                  color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
              2.toSizedBox,
              "Followings".toCaption(),
              10.toSizedBoxHorizontal,
              "1.5k".toCaption(
                  color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
              2.toSizedBox,
              "Followers".toCaption()
            ].toRow().toContainer().toExpanded(),
          ].toRow(),
          15.toSizedBox,
          Divider(height: .3,),
        ].toColumn().toSymmetricPadding(16, 12),
        // 50.toContainer(color: Colors.blue),
        10.toSizedBox,
        [
          5.toSizedBoxHorizontal,
          AppIcons.drawerHome,
          20.toSizedBoxHorizontal,
          "Home".toBody2(fontWeight: FontWeight.bold)
        ].toRow().toFlatButton(() {
          ExtendedNavigator.root.pop();
          BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.home());
        }),
        // 0.toSizedBox,
        [
          5.toSizedBoxHorizontal,
          AppIcons.drawerMessage,
          20.toSizedBoxHorizontal,
          "Messages".toBody2(fontWeight: FontWeight.bold)
        ].toRow().toFlatButton(() {
          ExtendedNavigator.root.pop();
          BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.message());
        }),
        // 30.toSizedBox,
        [
          5.toSizedBoxHorizontal,
          AppIcons.drawerBookmark,
          22.toSizedBoxHorizontal,
          "Bookmarks".toBody2(fontWeight: FontWeight.bold)
        ].toRow().toFlatButton(() {
          ExtendedNavigator.root.pop();
          BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.bookmarks());
        }),
        // 30.toSizedBox,
        [
          5.toSizedBoxHorizontal,
          AppIcons.groupIcon,
          22.toSizedBoxHorizontal,
          "Groups".toBody2(fontWeight: FontWeight.bold)
        ].toRow().toFlatButton(() {
          ExtendedNavigator.root.pop();
          // ExtendedNavigator.root.push(Routes.groupScreen);
          BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.groups());
        }),
        [
          5.toSizedBoxHorizontal,
          AppIcons.drawerProfile,
          20.toSizedBoxHorizontal,
          "Profile".toBody2(fontWeight: FontWeight.bold)
        ].toRow().toFlatButton(() {
          ExtendedNavigator.root.pop();
          BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.profile(ProfileScreenArguments(otherUser: false)));
        }),
        [
          buildNavItem(name: "Ads", callback: (){
            ExtendedNavigator.root.push(Routes.webPageScreen,arguments: WebPageScreenArguments(title: "Ads",url:"https://blkem.com/ads"));
            // await launch("https://blkem.com/ads");
          },icon: AppIcons.adsIcon),
          buildNavItem(name: "Affiliates", callback: (){
            ExtendedNavigator.root.push(Routes.webPageScreen,arguments: WebPageScreenArguments(title: "Affiliates",url:"https://blkem.com/affiliates"));
            // await launch("https://blkem.com/affiliates");
          },icon: AppIcons.affiliatesIcon)
        ].toColumn().toContainer().makeVerticalBorders.toExpanded(),
       [ buildNavItem(name: "Settings", callback: (){
         BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.settings(false));
       }, icon: AppIcons.drawerSetting).toContainer(),
       ].toColumn(mainAxisAlignment: MainAxisAlignment.end).toContainer(alignment: Alignment.bottomLeft).toExpanded(),
        Divider(height: .3,),
        "Help Center".toSubTitle1(fontWeight: FontWeight.bold).toContainer(alignment: Alignment.centerLeft).toPadding(16),
        // Divider(height: .3,).toContainer(alignment: Alignment.bottomCenter).toHorizontalPadding(16).toExpanded(flex: 5),

        //     .toExpanded(flex: context.getScreenWidth<321?3:1)
      ],
    ).toContainer(color: Colors.white).toSafeArea;
  }
  Widget buildNavItem({@required String name, @required VoidCallback callback,@required Widget icon}){
    return [
      5.toSizedBoxHorizontal,
      icon,
      20.toSizedBoxHorizontal,
      name.toBody2(fontWeight: FontWeight.bold)
    ].toRow().toFlatButton(() {
      ExtendedNavigator.root.pop();
      callback.call();
      // BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.settings(false));
    });
  }
}


Widget buildPostButton(Widget icon, String count,{bool isLiked=false}) {
  return [icon, 5.toSizedBox, count.toBody2(fontWeight: FontWeight.bold,color: isLiked?Colors.red:AppColors.textColor)]
      .toRow(crossAxisAlignment: CrossAxisAlignment.center);
}

Widget getShareOptionMenu() {
  return [
    // "Share to FB",
    // "Share to Twitter",
    // "Share to Linkdin",
    // "Share to Pinterest",
    // "Share to Reddit",
    "Share to Blackshare",
    "Copy Link"
  ]
      .toPopUpMenuButton((value) {}, icon: AppIcons.shareIcon)
      .toContainer(height: 15, width: 15);
}

Widget getPostOptionMenu(bool showThread,bool showArrowIcon,bool otherUser) {
  return [
    if(!otherUser)
    "Not interested",
    "Bookmark",
    if(otherUser)
      "Unfollow",
    if(otherUser)
      "Block @micheal",
    // if (showThread&&!otherUser) "Show Thread",
    if(otherUser) "Report post",
    if(!otherUser)
    "Report post",
    if(!otherUser)
      "Pin to profile",
    if(!otherUser)
      "Delete"
    // if(!otherUser)
    // "Show repost",

    // if(!otherUser)
    // "Delete"
  ]
      .toPopUpMenuButton((value) {}, icon: showArrowIcon?Icon(Icons.keyboard_arrow_down,color: Colors.grey.withOpacity(.8),):AppIcons.optionIcon)
      .toContainer(
        alignment: Alignment.topCenter,
      )
      .toExpanded(flex: 1);
}
