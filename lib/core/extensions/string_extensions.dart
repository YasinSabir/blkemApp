

import 'package:cached_network_image/cached_network_image.dart';
import 'package:colibri/core/common/validators.dart';
import 'package:colibri/core/common/widget/searc_bar.dart';
import 'package:colibri/core/theme/app_theme.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_compress/video_compress.dart';
import 'package:i18n_extension/default.i18n.dart';
extension StringExtensions on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.-_]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (this == null && this.isEmpty)
      return false;
    else
      return emailRegExp.hasMatch(this);
  }
  Future<MediaInfo> get compressVideo async => await VideoCompress.compressVideo(
    this,
    quality: VideoQuality.DefaultQuality,
    includeAudio: true,
    deleteOrigin: false, // It's false by default
  );
}

extension StringExtension on String {
  bool get isValidPass {
    if (this == null && this.isEmpty)
      return false;
    else if(this.length != 0) return this.length > 7;
    else return  nameRegExp.hasMatch(this) && numberRegExp.hasMatch(this);
    // else if(numberRegExp.hasMatch(string))
  }
//   if (string.length < 8) {
//   print("FIRST");
// //      sink.addError("Req min 8 Chars");
//   sink.addError("Choose a password wisely");
//   }
//   else if(nameRegExp.hasMatch(string).not){
//   print("SECOND");
//   sink.addError("Choose a password wisely");
// //      sink.addError("Req min 1 alphabet");
//   }
//   else if(numberRegExp.hasMatch(string).not){
//   print("THIRD");
//   sink.addError("Choose a password wisely");
// //      sink.addError("Req min 1 number");
//   }
//   else {
//   print("FOURTH");
//   sink.add(string);
//   }
  Text get toText => Text(
        this,
        style: TextStyle(),
      );

  Text toHeadLine6(
          {num fontSize = AppFontSize.headLine6,
            FontWeight fontWeight=FontWeight.w400,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        style:
            AppTheme.headline6.copyWith(fontSize: fontSize.toSp, color: color,fontWeight: fontWeight),
        textAlign: TextAlign.start,
      );

  Text toHeadLine5(
          {num fontSize = AppFontSize.headLine5,
            FontWeight fontWeight=FontWeight.w400,
          Color color = AppColors.textColor}) =>
      Text(
        this.i18n,
        style:
            AppTheme.headline5.copyWith(fontSize: fontSize.toSp, color: color,fontWeight: fontWeight),
      );

  Text toHeadLine4(
          {num fontSize = AppFontSize.headLine4,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        style:
            AppTheme.headline4.copyWith(fontSize: fontSize.toSp, color: color),
      );

  Text toHeadLine3(
          {num fontSize = AppFontSize.headLine3,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        style:
            AppTheme.headline3.copyWith(fontSize: fontSize.toSp, color: color),
      );

  Text toHeadLine2(
          {num fontSize = AppFontSize.headLine2,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        style:
            AppTheme.headline2.copyWith(fontSize: fontSize.toSp, color: color),
      );

  Text toHeadLine1(
          {num fontSize = AppFontSize.headLine1,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        style:
            AppTheme.headline1.copyWith(fontSize: fontSize.toSp, color: color),
      );

  Text toBody1(
          {num fontSize = AppFontSize.bodyText1,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        style:
            AppTheme.bodyText1.copyWith(fontSize: fontSize.toSp, color: color),
      );

  Text toBody2(
          {
            int maxLines,
            num fontSize = AppFontSize.bodyText2,
            FontWeight fontWeight=FontWeight.w400,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        maxLines: maxLines,
        style:
            AppTheme.bodyText2.copyWith(fontSize: fontSize.toSp, color: color,fontWeight: fontWeight),
      );

  Text toSubTitle1(
          {num fontSize = AppFontSize.subTitle1,
          FontWeight fontWeight = FontWeight.w400,
          Color color = AppColors.textColor}
          ) =>
      Text(
        this,
        style: AppTheme.subTitle1.copyWith(
            fontSize: fontSize.toSp, color: color, fontWeight: fontWeight),
      );

  Text toSubTitle2(
          {num fontSize = AppFontSize.subTitle2,
            FontWeight fontWeight = FontWeight.w500,
          TextAlign align,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        textAlign: align,
        style:
            AppTheme.subTitle2.copyWith(fontSize: fontSize.toSp, color: color,fontWeight: fontWeight),
      );

  Text toButton(
          {num fontSize = AppFontSize.button,
          FontWeight fontWeight = FontWeight.w600,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        style: AppTheme.button.copyWith(
            fontSize: fontSize.toSp, color: color, fontWeight: fontWeight),
      );

  Text toCaption(
          {num fontSize = AppFontSize.caption,
            int maxLines,
            TextAlign textAlign,
          FontWeight fontWeight = FontWeight.w400,
          Color color = AppColors.textColor}) =>
      Text(
        this,
        textAlign: textAlign,
        maxLines: maxLines,
        style: AppTheme.caption.copyWith(
            fontSize: fontSize.toSp, color: color, fontWeight: fontWeight),
      );

  TextField toTextField({StringToVoidFunc onSubmit,String icon}) => TextField(
        style: AppTheme.button.copyWith(fontWeight: FontWeight.w500),
        onSubmitted: (value){
         onSubmit(value);
        },

        decoration: InputDecoration(
//                disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: .1)),

            contentPadding: EdgeInsets.symmetric(
                vertical: 16.toVertical, horizontal: 6.toHorizontal),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            // suffix: Icon(Icons.email),
            prefixIcon: SvgPicture.asset(icon,height: 12,width: 12,).toContainer(height: 20,width: 20,alignment: Alignment.center),
            // focusedErrorBorder: OutlineInputBorder(
            //     borderSide:
            //         BorderSide(width: 1, color: Colors.red.withOpacity(.8))),
            // errorBorder: OutlineInputBorder(
            //     borderSide:
            //         BorderSide(width: .8, color: Colors.red.withOpacity(.8))),
            // enabledBorder:
            //     OutlineInputBorder(borderSide: BorderSide(width: .5)),
            // focusedBorder: OutlineInputBorder(
            //     borderSide:
            //         BorderSide(width: .5, color: AppColors.colorPrimary)),
            // border: OutlineInputBorder(),
            hintText: this,
            hintStyle: AppTheme.caption.copyWith(fontWeight: FontWeight.bold),
            errorStyle: AppTheme.caption
                .copyWith(color: Colors.red, fontWeight: FontWeight.bold)),
      );
  Widget toSearchBarField({fieldValidator})=>SearchBar(this,fieldValidator);
  TextField toNoBorderTextField() => TextField(

        style: AppTheme.button.copyWith(fontWeight: FontWeight.w500),
        maxLines: 3,
        maxLength: 600,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
            counter: Offstage(),
            border: InputBorder.none,
            hintText: this,
            hintStyle: AppTheme.caption.copyWith(fontWeight: FontWeight.bold)),
      );

  SvgPicture toSvg({num height = 15, num width = 15, Color color}) =>
      SvgPicture.asset(this,
          color: color,
          width: width.toWidth,
          height: width.toHeight,
          semanticsLabel: 'A red up arrow');

  Image toAssetImage({double height = 50, double width = 50}) =>
      Image.asset(this, height: height.toHeight, width: width.toWidth);

  Widget toRoundNetworkImage({num radius = 10, num borderRadius = 60.0}) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.toDouble()),
        child: CircleAvatar(
          radius: radius.toHeight + radius.toWidth,
          // backgroundImage:Image(),
          child: CachedNetworkImage(
            imageUrl: this,
          ),
          backgroundColor: Colors.transparent,
        ),
      );

  Widget toNetWorkImage({num height = 50, num width = 50,num borderRadius=20}) => ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius.toDouble()),
    child: CachedNetworkImage(imageUrl: this,height: height.toHeight,width: width.toWidth,fit: BoxFit.cover,),
  );

  Widget toTab()=>Tab(
    text: this,
  ).toContainer(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border()));

  Widget toBadge({bool isActive=false})=>Container(
    padding: EdgeInsets.all(4),
    alignment: Alignment.center,
  child: this.toCaption(color: isActive?AppColors.colorPrimary:Colors.black,fontWeight: FontWeight.bold,fontSize: 9),
    decoration: BoxDecoration(color: isActive?AppColors.colorPrimary.withOpacity(.3):Colors.grey.shade300,shape: BoxShape.circle),);
}

extension StringExtensionNumber on String {
  bool get isValidPhone {
    return this.length >= 10;
  }
}
