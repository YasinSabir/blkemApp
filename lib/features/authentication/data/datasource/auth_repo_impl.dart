import 'dart:collection';


import 'package:colibri/core/common/api/api_helper.dart';
import 'package:colibri/core/common/api/api_constants.dart';
import 'package:colibri/core/common/failure.dart';
import 'package:colibri/core/datasource/local_data_source.dart';
import 'package:colibri/features/authentication/data/models/login_response.dart';
import 'package:colibri/features/authentication/domain/repo/auth_repo.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';
@Singleton(as:AuthRepo)
class AuthRepoImpl extends AuthRepo{
  final ApiHelper apiHelper;
  final GoogleSignIn _googleSignIn;
  final TwitterLogin _twitterLogin;
  final LocalDataSource localDataSource;

  AuthRepoImpl(this.apiHelper, this._googleSignIn, this._twitterLogin, this.localDataSource);

  @override
  Future<Either<Failure, LoginResponse>> signIn(HashMap<String, dynamic> hashMap) async{
    var response= await apiHelper.post(ApiConstants.loginEndPoint,hashMap);
    return response.fold((l) => Left(l), (r) async{
      var loginResponse = LoginResponse.fromJson(r.data);
      await localDataSource.saveUser(loginResponse);
      var user=await localDataSource.getUser();
      print(user.data.email);
      return Right(loginResponse);
    });
  }

  @override
  Future<Either<Failure, dynamic>> signUp(HashMap<String, dynamic> hashMap) {
  return apiHelper.post(ApiConstants.signUpEndPoint, hashMap);
  }

  @override
  Future<Either<Failure, String>> fbLogin() async{
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    if(result.status==FacebookLoginStatus.loggedIn) return Right(result.accessToken.token);
    else if(result.status==FacebookLoginStatus.cancelledByUser) return Left(ServerFailure("Cancelled by user"));
    else return Left(ServerFailure(result.errorMessage));
  }

  @override
  Future<Either<Failure, String>> googleLogin() async{
    try {
      var response= await _googleSignIn.signIn();
     var auth=await response.authentication;
     return Right(auth.accessToken);
    } catch (e) {
      return Left(ServerFailure("Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, String>> twitterLogin() async{
    final AuthResult result = await _twitterLogin.login();
    if(result.status==TwitterLoginStatus.loggedIn) return Right(result.accessToken.authToken);
    else if(result.status==TwitterLoginStatus.cancelledByUser)return Left(ServerFailure("Cancelled by the user"));
    else return Left(ServerFailure(result.errorMessage));
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(String email) async{
    var response= await apiHelper.post(ApiConstants.resetPassword,
        HashMap<String,dynamic>.from({"email":email}));
     return response.fold(
             (l) => Left(l),
             (r) => Right(r));
  }
}