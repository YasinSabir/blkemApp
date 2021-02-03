import 'dart:collection';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:colibri/core/common/base_screen.dart';
import 'package:colibri/core/common/bloc/base_bloc.dart';
import 'package:colibri/core/common/uistate/common_ui_state.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/core/theme/strings.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/authentication/presentation/bloc/login_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginCubit loginCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginCubit = getIt<LoginCubit>();
    // EasyLoading.show();
  }

  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return BlocProvider<LoginCubit>(
      create: (c) => loginCubit,
      child: BlocListener<LoginCubit, CommonUIState>(
        listener: (_, state) {
          state.maybeWhen(
            orElse: () {},
            success: (message) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Login Successfully',
                desc: "",
                btnOkColor: AppColors.colorPrimary,
                btnOkOnPress: () {
                  ExtendedNavigator.root.replace(Routes.feedScreen);
                },
              )..show();
              // ExtendedNavigator.root.replace(Routes.feedScreen);
              // context.showSnackBar(message: message);
            },
            error: (e) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Oops',
                desc: e,
                btnCancelOnPress: () {},
                btnOkColor: AppColors.colorPrimary,
                btnOkOnPress: () {},
              )..show();
            },
          );
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      // constraints: BoxConstraints(
                      //     maxHeight: MediaQuery.of(context).size.height),
                      child: [
                        120.toSizedBox,
                        buildTopView(),
                        buildMiddleView(context),
                        30.toSizedBox,
                        buildBottomView()
                      ]
                          .toColumn(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center)
                          .makeScrollable()
                          .toContainer(
                              alignment: Alignment.center, color: Colors.white)
                          .toHorizontalPadding(24.0),
                    ),
                    Positioned(
                        top: -90,
                        right: -80,
                        child:
                            Images.signUpImage.toSvg(height: 380, width: 380)),
                  ],
                ),
              ),
            )
            // .toFadeAnimation(animationController).toSlideAnimation(animationController),
            ),
      ),
    );
  }

  Widget buildTopView() {
    return [
      [
        AppIcons.appLogo.toContainer(),
        AppIcons.appName,
        Strings.stay.toSubTitle1(),
      ].toColumn(mainAxisAlignment: MainAxisAlignment.end).toPadding(12),
      [
        Strings.emailAddress
            .toTextField(icon: Images.email)
            .toStreamBuilder(validators: loginCubit.emailValidators)
            .toThemeTextField,
        10.toSizedBox,
        Strings.password
            .toTextField(
                onSubmit: (value) {
                  // context.showSnackBar(message:value.toString());
                  loginCubit.validForm.listen((event) {
                    if (event) loginCubit.loginUser();
                  });
                },
                icon: Images.lock)
            .toStreamBuilder(validators: loginCubit.passwordValidator)
            .toThemeTextField,
        5.toSizedBox,
        Strings.forgotPassword
            .toCaption(
                fontWeight: FontWeight.w600, color: AppColors.colorPrimary)
            .toContainer(alignment: Alignment.centerLeft)
            .toVerticalPadding(12.0)
            .toHorizontalPadding(10)
            .onTap(() {
          ExtendedNavigator.root.push(Routes.resetPasswordScreen);
        }),
        "The email and password you entered does not match. Please double-check and try again"
            .toCaption(color: Colors.red, fontWeight: FontWeight.w600)
            .toAlign(
              TextAlign.center,
            )
            .toVisibilityStreamBuilder(loginCubit.errorTextStream.stream)
      ].toColumn()
    ]
        .toColumn(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center)
        .toContainer(
          alignment: Alignment.bottomCenter,
        );
  }

  Widget buildMiddleView(BuildContext context) {
    return [
      25.toSizedBox,

      // 35.toSizedBox,
      Strings.login.toText.toStreamBuilderButton(loginCubit.validForm,
          () async {
        await loginCubit.loginUser();
        //ExtendedNavigator.root.replace(Routes.feedScreen);
      }),
      35.toSizedBox,
      [
        Images.facebook
            .toSvg()
            .toFlatButton(() async => loginCubit.facebookLogin(),
                color: AppColors.fbBlue, radius: 5)
            .toSizedBox(height: 40, width: 55),
        10.toSizedBox,
        Images.google
            .toSvg()
            .toFlatButton(() => loginCubit.googleLogin(),
                radius: 5, borderColor: Colors.grey.shade300)
            .toSizedBox(height: 40, width: 55)
            .toContainer(
                decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.withOpacity(.1)),
              shape: BoxShape.rectangle,
            )),
        10.toSizedBox,
        Images.twitter
            .toSvg()
            .toFlatButton(() => loginCubit.twitterLogin(),
                color: AppColors.twitterBlue, radius: 5)
            .toSizedBox(height: 40, width: 55),
      ].toRow(mainAxisAlignment: MainAxisAlignment.center),
      20.toSizedBox,
      [
        // StreamBuilder<bool>(
        //     stream: loginCubit.agreeTermsController.stream,
        //     initialData: false,
        //     builder: (context, snapshot) {
        //       return Checkbox(
        //           value: snapshot.data, onChanged: loginCubit.agreeTermsController.changeBool);
        //     }
        // ),

        Strings.byClickingAgree
            .toButton(fontSize: 14.0, color: AppColors.greyText)
      ].toRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center),
      [
        Strings.termsOfUse
            .toButton(fontSize: 14.0, color: AppColors.colorPrimary)
            .onTap(() {
          context.removeFocus();
          ExtendedNavigator.root.push(Routes.webViewScreen,
              arguments: WebViewScreenArguments(
                  url: Strings.termsUrl, name: Strings.termsOfUse));
        }),
        " and ".toButton(fontSize: 14.0, color: AppColors.greyText),
        Strings.privacy
            .toButton(fontSize: 14.0, color: AppColors.colorPrimary)
            .onTap(() {
          context.removeFocus();
          ExtendedNavigator.root.push(
            Routes.webViewScreen,
            arguments: WebViewScreenArguments(
                url: Strings.privacyUrl, name: Strings.privacy),
          );
        })
      ].toRow(mainAxisAlignment: MainAxisAlignment.center),
    ]
        .toColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center)
        .toContainer(alignment: Alignment.topCenter, color: Colors.white);
  }

  Widget buildBottomView() {
    return [
      Strings.dontHaveAnAccount.toCaption(),
      Strings.signUpCaps
          .toButton(color: AppColors.colorPrimary)
          .toUnderLine()
          .toFlatButton(
              () => ExtendedNavigator.root.replace(Routes.signUpScreen)
              // ()=>loginCubit.loginUser()
              ),
    ]
        .toColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center)
        .toContainer(alignment: Alignment.center, color: Colors.white);
  }
}
