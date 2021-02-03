import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/datasource/local_data_source.dart';
import 'package:i18n_extension/i18n_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_screenutil/screenutil.dart';
import 'package:rxdart/rxdart.dart';

import 'core/di/injection.dart';
import 'core/routes/routes.gr.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/colors.dart';
import 'extensions.dart';

final appThemeConstroller = BehaviorSubject<TextTheme>.seeded(appTextTheme);

Function(TextTheme) get changeAppTheme => appThemeConstroller.sink.add;

Stream<TextTheme> get appTheme => appThemeConstroller.stream;
LocalDataSource localDataSource;
var isUserLoggedIn=false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)

 await configureDependencies();
  localDataSource=getIt<LocalDataSource>();
  isUserLoggedIn=await localDataSource.isUserLoggedIn();
    ScreenUtil.init(allowFontScaling: true);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,

  ]).then((value) async{
    await Future.delayed(Duration(milliseconds: 500));
    runApp(MyApp());
  });

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     EasyLoading.instance
       ..displayDuration = const Duration(milliseconds: 2000)
       ..indicatorType = EasyLoadingIndicatorType.ring
       ..loadingStyle = EasyLoadingStyle.custom
       ..indicatorSize = 45.0
       ..radius = 10.0
       ..maskType=EasyLoadingMaskType.custom
       ..maskColor=AppColors.colorPrimary.withOpacity(.2)
       ..indicatorColor=AppColors.colorPrimary
      ..progressColor=AppColors.colorPrimary
       ..textColor=AppColors.colorPrimary
       ..backgroundColor=Colors.transparent
       ..userInteractions = false;
   });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(designSize: Size(1080,1920),allowFontScaling: true);
    return StreamBuilder<TextTheme>(
        stream: appTheme,
        builder: (context, snapshot) {
          print("snapshot");
          return MaterialApp(
            title: 'Blkem',
            supportedLocales: [
              const Locale('en', "US"),
              const Locale('pt', "BR"),
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              indicatorColor: AppColors.colorPrimary,
                scaffoldBackgroundColor: Colors.white,
                // textTheme: snapshot.data,
                primaryColor: AppColors.colorPrimary,
                unselectedWidgetColor: AppColors.colorPrimary.withOpacity(.5),
                toggleableActiveColor: AppColors.colorPrimary,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                tabBarTheme: TabBarTheme(
                    labelColor:  AppColors.colorPrimary,
                  indicator: UnderlineTabIndicator(),
                    unselectedLabelStyle: context.subTitle2.copyWith(fontWeight: FontWeight.bold),
                    labelStyle: context.subTitle2.copyWith(fontWeight: FontWeight.bold),
                    // labelColor: AppColors.colorPrimary,
                    unselectedLabelColor: Colors.grey)),
            builder: ExtendedNavigator.builder<MyRouter>(router: MyRouter(),initialRoute: isUserLoggedIn?Routes.feedScreen:Routes.welcomeScreen,builder: (context,child){
              return FlutterEasyLoading(child: I18n(
                  initialLocale: Locale('pt', "BR"),
                  child: child));
            }),
          );
        });
  }
}
