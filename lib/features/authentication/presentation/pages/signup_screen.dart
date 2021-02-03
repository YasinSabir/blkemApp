import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:colibri/core/common/uistate/common_ui_state.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/core/theme/strings.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/authentication/presentation/bloc/signup_cubit.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpCubit signUpCubit;
  PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=PageController(initialPage: 0);
    signUpCubit = getIt<SignUpCubit>();
  }

  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return BlocProvider<SignUpCubit>(
      create: (c) => signUpCubit,
      child: BlocListener<SignUpCubit, CommonUIState>(
        listener: (_, state) {
          state.maybeWhen(
              orElse: () {},
              error: (e){
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
              success: (message) {
                ExtendedNavigator.root.replace(Routes.loginScreen);
                context.showSnackBar(message: message);
              });
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                     // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                      child: [
                        150.toSizedBox,
                      buildTopView(),
                      StreamBuilder<int>(
                        stream: signUpCubit.currentPage,
                        builder: (context, snapshot) {
                          return PageView(
                            controller: pageController,
                            physics:snapshot.data==0? NeverScrollableScrollPhysics():ClampingScrollPhysics(),
                            onPageChanged: (page){
                              print("current page $page");
                              signUpCubit.changeCurrentPage(page);
                            },
                            children: [
                              buildFirstStep(),
                              buildSecondStep()
                            ],
                          ).toContainer(height: 190);
                        }
                      ),
                      buildMiddleView(),
                      buildBottomView()
                    ]
                        .toColumn(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center)
                        .toContainer(
                        alignment: Alignment.center, color: Colors.white)
                        .toHorizontalPadding(24.0),),
                    Positioned(
                        top: -90,
                        right: -80,
                        child: Images.signUpImage.toSvg(height: 380,width: 380)),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget buildTopView() {
    return [
      // Images.signUpImage.toSvg(height: 400,width: 400),
      AppIcons.appLogo.toContainer(),
      AppIcons.appName.toContainer(),
      // 30.toSizedBox,
      Strings.stay.toSubTitle1().toContainer(),
      10.toSizedBox,
    ].toColumn(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end).toHorizontalPadding(10);
  }

  Widget buildFirstStep(){
   return [
      Strings.firstName
          .toTextField(icon: Images.user)
          .toStreamBuilder(validators: signUpCubit.firstNameValidator),
      11.toSizedBox,
      Strings.lastName
          .toTextField(icon: Images.user)
          .toStreamBuilder(validators: signUpCubit.lastNameValidator).toThemeTextField,
      10.toSizedBox,
      Strings.userName
          .toTextField(icon: Images.user)
          .toStreamBuilder(validators: signUpCubit.userNameValidator).toThemeTextField,
    ].toColumn();
  }

  Widget buildSecondStep(){
    return [
      Strings.emailAddress
          .toTextField(icon: Images.email)
          .toStreamBuilder(validators: signUpCubit.emailValidator).toThemeTextField,
      10.toSizedBox,
      Strings.password
          .toTextField(icon: Images.lock)
          .toStreamBuilder(validators: signUpCubit.passwordValidator).toThemeTextField,
      10.toSizedBox,
      Strings.confirmPassword
          .toTextField(icon: Images.lock)
          .toStreamBuilder(validators: signUpCubit.confirmPasswordValidator).toThemeTextField,
    ].toColumn();
  }

  Widget buildMiddleView() {
    return [
      // 20.toSizedBox.toSteamVisibility(signUpCubit.currentPage.map((event) => event==1)),
      [
        5.toSizedBoxHorizontal,
        StreamBuilder<bool>(
            stream: signUpCubit.agreeTerms,
            initialData: false,
            builder: (context, snapshot) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Checkbox(
                    value: snapshot.data, onChanged: signUpCubit.changeAgreeTerms).toContainer(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8))),
              );
            }
        ),
        Strings.byClickingAgree.toButton(fontSize: 14.0, color: AppColors.greyText,fontWeight: FontWeight.bold),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start).toSteamVisibility(signUpCubit.currentPage.map((event) => event==1)),
      [
        55.toSizedBoxHorizontal,
        Strings.termsOfUse
            .toButton(fontSize: 14.0, color: AppColors.colorPrimary)
            .onTap(() {
              context.removeFocus();
          ExtendedNavigator.root.push(Routes.webViewScreen,
              arguments: WebViewScreenArguments(url: Strings.termsUrl,name: Strings.termsOfUse));
        }).toContainer(),
        " and ".toButton(fontSize: 14.0, color: AppColors.greyText),
        Strings.privacy
            .toButton(fontSize: 14.0, color: AppColors.colorPrimary)
            .onTap(() {
              context.removeFocus();
          ExtendedNavigator.root.push(Routes.webViewScreen,
              arguments: WebViewScreenArguments(url: Strings.privacyUrl,name: Strings.privacy),);
        })
      ].toRow(mainAxisAlignment: MainAxisAlignment.start).toSteamVisibility(signUpCubit.currentPage.map((event) => event==1)),
      25.toSizedBox,
      Row(
        children: [
          "Back".toButton().toCustomButton(() {
            signUpCubit.changeCurrentPage(0);
            pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          },fullWidth: false,color: Colors.grey.withOpacity(.5)).toExpanded().toSteamVisibility(signUpCubit.currentPage.map((event) => event==1)),
          10.toSizedBox,
          StreamBuilder<int>(
              stream: signUpCubit.currentPage,
              builder: (context,snapshot){
                if(snapshot.data==null)return Container();
            return Text(snapshot.data==0?Strings.next:Strings.signUp).toStreamBuilderButton(snapshot.data==0?signUpCubit.isFirstStepValid:signUpCubit.validForm, () {
              if(snapshot.data==0){
                if(signUpCubit.firstNameValidator.text.isEmpty){
                  FlushbarHelper.createError(message: "Your first name is missing! Please try again").show(context);
                }
                else if(signUpCubit.lastNameValidator.isEmpty){
                  FlushbarHelper.createError(message: "Your Last name is missing! Please try again").show(context);
                }
                else if(signUpCubit.userNameValidator.isEmpty){
                  FlushbarHelper.createError(message: "Username is missing! Please try again").show(context);
                }
                else {
                  pageController.animateToPage(1, duration: Duration(milliseconds:500), curve: Curves.easeIn);
                  signUpCubit.changeCurrentPage(1);
                }
              }
              else {
                  if(signUpCubit.emailValidator.isEmpty){
                    FlushbarHelper.createError(message: "Email is missing! Please try again").show(context);
                  }
                  else if(!signUpCubit.emailValidator.text.isValidEmail){
                    FlushbarHelper.createError(message: "Please enter a valid email! Please try again").show(context);
                  }
                  else if(!signUpCubit.passwordValidator.text.isValidPass){
                    FlushbarHelper.createError(message: "Choose a password wisely! Please try again").show(context);
                  }
                  else if(signUpCubit.passwordValidator.text!=signUpCubit.confirmPasswordValidator.text){
                    FlushbarHelper.createError(message: "Password mismatched! Please try again").show(context);
                  }

                  else signUpCubit.signUp();
              }
              signUpCubit.changeCurrentPage(snapshot.data);
    },fullWidth: false).toExpanded();
          }),
        ],
      ).toHorizontalPadding(8),
      25.toSizedBox,
      [
        Images.facebook
            .toSvg()
            .toFlatButton(
                () => {context.showSnackBar(message: Strings.fbLoginComing)},
                color: AppColors.fbBlue,radius: 5)
            .toSizedBox(height: 40, width: 55),
        10.toSizedBox,
        Images.google
            .toSvg()
            .toFlatButton(
              () => {context.showSnackBar(message: Strings.googleComing)},radius: 5
            ,borderColor: Colors.grey.shade300)
            .toSizedBox(height: 40, width: 55)
            .toContainer(
                decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.withOpacity(.1)),
              shape: BoxShape.rectangle,
            )),
        10.toSizedBox,
        Images.twitter
            .toSvg()
            .toFlatButton(
                () => {context.showSnackBar(message: Strings.twitterComing)},
                color: AppColors.twitterBlue,radius: 5)
            .toSizedBox(height: 40, width: 55),
      ].toRow(mainAxisAlignment: MainAxisAlignment.center).toSteamVisibility(signUpCubit.currentPage.map((event) => event==0)),
    ].toColumn(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center);
  }

  Widget buildBottomView() {
    return [
      10.toSizedBox,
      Strings.haveAlreadyAccount.toCaption(),
      Strings.signIn
          .toButton(color: AppColors.colorPrimary)
          .toUnderLine()
          .toFlatButton(
              () => {
                ExtendedNavigator.root.replace(Routes.loginScreen)
              }),
    ].toColumn(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }
}
