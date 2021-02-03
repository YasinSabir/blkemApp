import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/datasource/local_data_source.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  final bool fromProfile;

  const SettingsScreen({Key key, this.fromProfile=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: "Profile Settings".toSubTitle1(color: AppColors.textColor,fontWeight: FontWeight.bold),
        centerTitle: true,
        leading: fromProfile?IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
          BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.profile(ProfileScreenArguments(otherUser: false)));
        },):null,
        automaticallyImplyLeading: true,
      ),
      body: [
        header("General"),
        profileItem("Username", "Admin - @admin"),
        profileItem("Email address", "test@gmail.com"),
        profileItem("Website url address", "https://www.google.co.in"),
        profileItem("About you", "It's abou t me"),
        profileItem("Your Gender", "Male"),
        header("User Password"),
        profileItem("My password", "* * * * * *"),
        header("Language and Country"),
        profileItem("Display Language", "English"),
        profileItem("Country", "United States"),
        header("Account Verification"),
        profileItem("Verify my account", "Click to submit a verification request"),
        header("Account Privacy Settings"),
        profileItem("Account Privacy","Click to set your account privacy "),
        header("Company"),
        profileItem("Terms", "Click for our terms of usage"),
        profileItem("Privacy", "Click for our privacy details"),
        profileItem("Cookies", "Click for our cookies"),
        profileItem("About us", "Read about us"),
        header("Delete Profile"),
        profileItem("Delete", "Click to confirm deletion of profile"),
        20.toSizedBox,
        "Log Out"
            .toButton()
            .toFlatButton(() {
          context.showAlertDialog(widgets: [
            "Yes".toButton().toFlatButton(() async {
              var localDataSource = getIt<LocalDataSource>();
              await localDataSource.clearData();
              // Fix the issue
              ExtendedNavigator.root.replace(Routes.loginScreen);
            }),
            "No".toButton().toFlatButton(() {
              ExtendedNavigator.root.pop();
            }),
          ], title: "Are you sure want to Logout?");
        })
            .toContainer(alignment: Alignment.center),
        ["Version 1.0".toCaption(),"Dallas, TX".toCaption()].toColumn(mainAxisAlignment: MainAxisAlignment.center,).toContainer(alignment: Alignment.bottomCenter,height: 100),
        10.toSizedBox,
      ].toColumn().makeScrollable().toSafeArea,
    );
  }
}
Widget header(String name){
  return name
      .toCaption(fontWeight: FontWeight.bold).toHorizontalPadding(12)
      .toPadding(12).onTap(() { })
      .toContainer(color: AppColors.lightSky.withOpacity(.5)).makeBottomBorder;
}

Widget profileItem(String title,String value){
  return [
    title.toSubTitle2(fontWeight: FontWeight.bold),
    5.toSizedBox,
    value.toSubTitle2()
  ].toColumn().toPadding(12).toFlatButton(() { }).toContainer().makeBottomBorder;
}
