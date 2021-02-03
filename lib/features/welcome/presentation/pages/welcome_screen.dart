import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/common/buttons/custom_button.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/app_theme.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/strings.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }
  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    // useMemoized(()=>context.initScreenUtil());
    // useEffect((){
    //   ScreenUtil.init(allowFontScaling: true);
    // });
    //     var controller=useAnimationController(duration: Duration(milliseconds: 500));
    // controller.forward();
    // Animation<Offset> _offsetAnimation = Tween<Offset>(
    //   begin: const Offset(0.2, 0.0),
    //   end: const Offset(0.0, 0.0),
    // ).animate(CurvedAnimation(
    //   parent: controller,
    //   curve: Curves.easeInOut,
    // ));
//    print("build")

    return Material(
      child: [
        buildTopView(),
        buildMiddleView(),
        buildBottomView(),

      ].toColumn().toContainer()
      // toFadeAnimation(controller).toSlideAnimation(controller),
    );
  }

  Widget buildTopView(){
    return [
      // Text("demo",style: TextStyle(fontSize: 24.sp),),
      Strings.welcome.toHeadLine5(color: AppColors.colorPrimary,fontWeight: FontWeight.bold),
      10.toSizedBox,
      Strings.seeWhats.toHeadLine6(fontWeight: FontWeight.bold).toAlign(TextAlign.center).toHorizontalPadding(32),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center).toContainer(alignment: Alignment.bottomCenter).toExpanded();
  }

  Widget buildMiddleView(){
    return [AppIcons.appLogo].toColumn(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center).toContainer(alignment: Alignment.center).toExpanded();
  }

  Widget buildBottomView(){
    return [
      Strings.login.toButton(color: Colors.white).toCustomButton(() => {
        ExtendedNavigator.root.pushAndRemoveUntil(Routes.loginScreen,(f)=>false)
      }
        ).toSymmetricPadding(42, 8),
      Strings.signUp.toButton(color: Colors.black,fontWeight: FontWeight.w800).toFlatButton(() => {
    ExtendedNavigator.root.pushAndRemoveUntil(Routes.signUpScreen,(f)=>false)}
      )
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.center).toExpanded();

  }
}

