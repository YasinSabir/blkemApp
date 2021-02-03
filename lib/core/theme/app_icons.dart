import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  static Image appLogo = Images.logo.toAssetImage(height: 80, width: 80);
  static Widget appName = Images.app_name.toAssetImage(height: 100, width: 100);
  // static Widget appName = [
  //   "Blkem".toHeadLine5(fontWeight: FontWeight.bold),
  //   Container(height: 5,width: 5,decoration: BoxDecoration(color: AppColors.colorPrimary,shape: BoxShape.circle),
  //   )].toRow(crossAxisAlignment: CrossAxisAlignment.center);
  // bottom app bar
  static const bottomBarSize=19;

  static Widget messageIcon({num height=bottomBarSize,num width=bottomBarSize,ScreenType screenType}) =>
      [
        Images.message.toSvg(height: height, width: width,color: screenType.maybeWhen(orElse: ()=>null,message: ()=>AppColors.colorPrimary)),
          Container(height: 5,width: 5,decoration: BoxDecoration(shape: BoxShape.circle,color: screenType==ScreenType.message()?AppColors.colorPrimary:Colors.transparent),).toVerticalPadding(4)
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.center);
  static Widget notificationIcon({ScreenType screenType}) =>
      [
        Images.notification.toSvg(height: bottomBarSize, width: bottomBarSize,color: screenType.maybeWhen(orElse: ()=>null,notification: ()=>AppColors.colorPrimary)),

        Container(height: 5,width: 5,decoration: BoxDecoration(shape: BoxShape.circle,color: screenType==ScreenType.notification()?AppColors.colorPrimary:Colors.transparent),).toVerticalPadding(4)
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.center);

  static Widget homeIcon({num height=bottomBarSize,num width=bottomBarSize,ScreenType screenType}) =>
      [
        Images.home.toSvg(height: height, width: width,color: screenType.maybeWhen(orElse: ()=>null,home: ()=>AppColors.colorPrimary)),
        Container(height: 5,width: 5,decoration: BoxDecoration(shape: BoxShape.circle,color: screenType==ScreenType.home()?AppColors.colorPrimary:Colors.transparent),).toVerticalPadding(4)
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.center);

  static Widget searchIcon({ScreenType screenType}) =>
      [
        Images.search.toSvg(height: bottomBarSize, width: bottomBarSize,color: screenType.maybeWhen(orElse: ()=>null,search: ()=>AppColors.colorPrimary)),
          Container(height: 5,width: 5,decoration: BoxDecoration(shape: BoxShape.circle,color: screenType==ScreenType.search()?AppColors.colorPrimary:Colors.transparent),).toVerticalPadding(4)
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.center);

  static SvgPicture addIcon = Images.add.toSvg(height: bottomBarSize, width: bottomBarSize);

  // create post icon
  static SvgPicture gifIcon({bool enabled=true}) =>
      Images.gif.toSvg(height: 13, width: 13,color: enabled?AppColors.colorPrimary:AppColors.colorPrimary.withOpacity(.5));

  static SvgPicture videoIcon({bool enabled=true}) =>
      Images.video.toSvg(height: 18, width: 18,color: enabled?AppColors.colorPrimary:AppColors.colorPrimary.withOpacity(.5));

  static SvgPicture smileIcon = Images.smile.toSvg(height: 18, width: 18,color: AppColors.colorPrimary);

  static SvgPicture imageIcon({bool enabled=true}) =>
      Images.image.toSvg(height: 18, width: 18,color: enabled?AppColors.colorPrimary:AppColors.colorPrimary.withOpacity(.5));

  // social bar
  static Widget drawerIcon({num height=5,num width=5}) => Images.drawer.toSvg(height: height.toHeight, width: width.toWidth).toPadding(8);
  static Widget likeIcon = Images.like.toSvg(height: 12, width: 12,);
  static Widget heartIcon = Images.heart.toSvg(height: 12, width: 12,color: Colors.red);
  static Widget commentIcon = Images.comment.toSvg(height: 14, width: 14);
  static Widget repostIcon = Images.repost.toSvg(height: 14, width: 14);
  static Widget shareIcon = Images.share.toSvg(height: 14, width: 14);

  //drawer
  static Widget drawerHome = Images.drawerHome.toSvg(height: drawerMenuSize, width: drawerMenuSize);
  static Widget drawerMessage = Images.drawerMessage.toSvg();
  static Widget drawerBookmark = Images.drawerBookmark.toSvg(height: drawerMenuSize, width: drawerMenuSize);
  static Widget drawerProfile = Images.drawerProfile.toSvg(height: drawerMenuSize, width: drawerMenuSize);
  static Widget drawerSetting = Images.drawerSetting.toSvg(height: drawerMenuSize, width: drawerMenuSize);
  static Widget verifiedIcons = Images.verified.toSvg(height: drawerMenuSize, width: drawerMenuSize);
  static Widget adsIcon = Images.ads.toSvg(height: drawerMenuSize, width: drawerMenuSize);
  static Widget affiliatesIcon = Images.affiliate.toSvg(height: drawerMenuSize, width: drawerMenuSize);
  static Widget groupIcon = Images.groups.toSvg(height: drawerMenuSize, width: drawerMenuSize);

  static Widget usIcon = Images.usIcon.toSvg(height: 10, width: 10);
  static Widget folderIcon = Images.folderIcon.toSvg(height: 10, width: 10);
  static Widget optionIcon = Images.optionsIcon.toSvg(height: 20, width: 20,color: Colors.black87);
  static Widget messageProfile = Images.messageProfileIcon.toSvg(height: 30, width: 30);
  static Widget bellIcon = Images.bellIcon.toSvg(height: 30, width: 30);

}

const drawerMenuSize=20.0;
