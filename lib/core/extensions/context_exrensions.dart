import 'package:colibri/core/theme/app_theme.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter_screenutil/screenutil.dart';
extension ContextExtension on BuildContext {
  TextStyle get headLine6 => AppTheme.headline6;

  TextStyle get headLine5 => AppTheme.headline5;

  TextStyle get headLine4 => AppTheme.headline4;

  TextStyle get headLine3 => AppTheme.headline3;

  TextStyle get headLine2 => AppTheme.headline2;

  TextStyle get headLine1 => AppTheme.headline1;

  TextStyle get body1 => AppTheme.bodyText1;

  TextStyle get body2 => AppTheme.bodyText2;

  TextStyle get subTitle1 => AppTheme.subTitle1;

  TextStyle get subTitle2 => AppTheme.subTitle2;

  TextStyle get button => AppTheme.button;

  TextStyle get caption => AppTheme.caption;

  showSnackBar({String message,bool isError=false,FlushbarPosition position=FlushbarPosition.BOTTOM})=>snackBar(this, message, isError,position: position);

  removeFocus()=>FocusScope.of(this).requestFocus(FocusNode());
  Size get  getScreenSize=>Size(MediaQuery.of(this).size.width, MediaQuery.of(this).size.height);

  num get getScreenHeight=>MediaQuery.of(this).size.height;
  num get getScreenWidth=>MediaQuery.of(this).size.width;

  showModelBottomSheet(Widget child){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withOpacity(0),
        elevation: 0.0,
        context: this,
        builder: (builder){
          return child;
        }
    );
  }

  showAlertDialog({
    @required List<Widget> widgets,
    @required String title
}) async{

    // set up the buttons
    // Widget cancelButton = FlatButton(
    //   child: Text("Cancel"),
    //   onPressed:  () {},
    // );
    // Widget continueButton = FlatButton(
    //   child: Text("Continue"),
    //   onPressed:  () {},
    // );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("AlertDialog"),
      content: title.toSubTitle1(),
      actions:widgets,
    );

    // show the dialog
    // showDialog(
    //   context: this,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
    showAnimatedDialog(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }
   initScreenUtil()=>ScreenUtil.init(designSize: getScreenSize,allowFontScaling: true);
}
snackBar(BuildContext context, String text, bool isError,{FlushbarPosition position}) {
  Flushbar(
    backgroundColor: isError ? Colors.red : AppColors.colorPrimary,
    flushbarStyle: FlushbarStyle.GROUNDED,
    icon: Icon(
      isError ? Icons.error : Icons.done,
      color: Colors.white,
    ),
    message: text,
    flushbarPosition: position,
    duration: Duration(seconds: 3),
  )..show(context);
}

