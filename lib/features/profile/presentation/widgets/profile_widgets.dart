import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/feed/presentation/widgets/follow_unfollow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

Widget getUserStatsBar() {
  return [
    "155".toSubTitle2(
        color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
    4.toSizedBoxHorizontal,
    "Posts".toSubTitle2(),
    // 15.toSizedBoxHorizontal,
    Spacer(),
    "136".toSubTitle2(
        color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
    4.toSizedBoxHorizontal,
    "Followings".toSubTitle2(),
    // 15.toSizedBoxHorizontal,
    Spacer(),
    "1.5k".toSubTitle2(
        color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
    4.toSizedBoxHorizontal,
    "Followers".toSubTitle2(),
    Spacer()
  ].toRow();
}

Widget getUserSmallStatsBar() {
  return [
    "155".toCaption(color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
    4.toSizedBoxHorizontal,
    "Post".toCaption(),
    15.toSizedBoxHorizontal,
    "136".toCaption(color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
    4.toSizedBoxHorizontal,
    "Following".toCaption(),
    15.toSizedBoxHorizontal,
    "1.5k"
        .toCaption(color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
    4.toSizedBoxHorizontal,
    "Followers".toCaption()
  ].toRow();
}

Widget getTopAppBar(BuildContext context, {bool otherUser = false}) {
  String buttonText = otherUser ? "Unfollow" : "Profile Settings";
  return Stack(
    children: [
      [
        Container(
                child:
                    "https://images.pexels.com/photos/2739013/pexels-photo-2739013.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
                        .toNetWorkImage(
                            width: double.infinity, borderRadius: 0))
            .toExpanded(flex: 2),
        [
          40.toSizedBoxHorizontal,
          [
            40.toSizedBox,
            [
              "Micheal Doe".toHeadLine6(),
              5.toSizedBox,
              AppIcons.verifiedIcons,
              20.toSizedBox,
              if (otherUser)
                "Following"
                    .toCaption()
                    .toSymmetricPadding(8, 2)
                    .toContainer(color: Colors.grey.shade200)
            ].toRow(crossAxisAlignment: CrossAxisAlignment.center),
            [
              "@micheal.01".toSubTitle1(),
              5.toSizedBoxHorizontal,
              Icon(
                FontAwesomeIcons.link,
                size: 10,
                color: Colors.black54,
              ),
              5.toSizedBoxHorizontal,
              "https://www.google.com".toCaption(maxLines: 1)
            ].toRow(crossAxisAlignment: CrossAxisAlignment.center),
            5.toSizedBox,
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child:
                  "Michael Doe aka John Doe..well, you can call me I stick to what I believe in. We are all does"
                      .toSubTitle2(fontWeight: FontWeight.bold),
            ),
            13.toSizedBox,
            [
              Icon(
                Icons.language,
                size: 15,
                color: Colors.black54,
              ),
              5.toSizedBoxHorizontal,
              "Living in - United States".toCaption(),
              5.toSizedBoxHorizontal,
              AppIcons.usIcon,
              5.toSizedBoxHorizontal,
            ].toRow(crossAxisAlignment: CrossAxisAlignment.center),
            // 8.toSizedBox,

            8.toSizedBox,
            [
              2.toSizedBoxHorizontal,
              AppIcons.folderIcon,
              5.toSizedBoxHorizontal,
              "Member since - May, 2020".toCaption()
            ].toRow(crossAxisAlignment: CrossAxisAlignment.center),
            13.toSizedBox,
            if (context.getScreenWidth > 320) getUserStatsBar(),
            if (context.getScreenWidth < 321) getUserSmallStatsBar(),
            13.toSizedBox,
          ].toColumn().toExpanded(),
          10.toSizedBoxHorizontal
        ].toRow().toExpanded(flex: 3),
      ].toColumn().toContainer(),
      Positioned(
        top: context.getScreenWidth > 320 ? 150.toHeight : 165.toHeight,
        left: 40.toWidth,
        child: Hero(
          tag: 1256,
          child: Stack(
            children: [
              "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
                  .toNetWorkImage(borderRadius: 4, height: 70, width: 70)
                  .toContainer(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4))),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle,
                        color: Colors.green),
                  )),
            ],
          ),
        ),
      ),
      Positioned(
        top: context.getScreenWidth > 320 ? 200.toHeight : 220.toHeight,
        right: 10.toWidth,
        child: [
          // [
          //   "Show Followings",
          //   "Show Followers",
          //   "Copy Profile Link"
          // ].toPopUpMenuButton((value) {},
          //     icon: RotatedBox(quarterTurns: 45, child: AppIcons.optionIcon)),
          // AppIcons.messageProfile,
          // 5.toSizedBoxHorizontal,
          if (otherUser)
            AppIcons.bellIcon.onTap(() {
              // ExtendedNavigator.root.push(Routes.chatScreen);
            }),
          10.toSizedBox,
          if (otherUser)
            AppIcons.messageProfile.onTap(() {
              ExtendedNavigator.root.push(Routes.chatScreen);
            }),

          if (otherUser) 10.toSizedBox,
          if(otherUser)
            FollowUnFollowBtn(),
          // buttonText
          //     .toCaption(
          //         color: AppColors.colorPrimary, fontWeight: FontWeight.bold)
          //     .toOutlinedBorder(() {
          //   if (!otherUser)
          //     BlocProvider.of<FeedCubit>(context)
          //         .changeCurrentPage(ScreenType.settings(true));
          // }).toContainer(height: 25),
          if(!otherUser)
            buttonText
                .toCaption(
                color: Colors.white, fontWeight: FontWeight.bold)
                .toMaterialButton(() {
              if (!otherUser)
                BlocProvider.of<FeedCubit>(context)
                    .changeCurrentPage(ScreenType.settings(true));
            }).toContainer(height: 25),
          // "Profile Settings"
          //     .toCaption(fontWeight: FontWeight.bold)
          //     .toma(() {
          //   BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.settings(true));
          // },
          //     border: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(24.0),
          //         side: BorderSide(color: Colors.black))
          // ).toContainer(height: 25)
        ].toRow(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center),
      ),
      Positioned(
        top: 10.toHeight,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            BlocProvider.of<FeedCubit>(context)
                .changeCurrentPage(ScreenType.home());
          },
        ),
      )
    ],
  );
}
