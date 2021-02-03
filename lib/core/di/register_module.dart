
import 'package:colibri/core/theme/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:twitter_login/twitter_login.dart';
@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  FlutterSecureStorage get storage => FlutterSecureStorage();

  @lazySingleton
  GoogleSignIn get googleLogin=> GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @lazySingleton
  TwitterLogin get twitterLogin=>TwitterLogin(
    apiKey: 'E261JBzxTeuj5PLM5bgN2VLUY',
    apiSecretKey: 'lc38SoHLDU8XZ7BhrljvcrsfiIWxGknzPSnPPSfmPCzalXqKdp',
    redirectURI: "null",);
  // bearer token
  // AAAAAAAAAAAAAAAAAAAAAGOqJgEAAAAA1yu5V2v%2FlEkQ%2B54Q86v0Hcfsdgk%3DbNqqGPgAqsB3OuniOuIr1sqpcwRtZxbYaJPaNL12nsQv7t3AGp
}