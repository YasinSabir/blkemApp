
import 'dart:collection';
import 'package:colibri/core/common/failure.dart';
import 'package:colibri/features/authentication/data/models/login_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo{
  Future<Either<Failure,LoginResponse>> signIn(HashMap<String,dynamic> hashMap);
  Future<Either<Failure,dynamic>> signUp(HashMap<String,dynamic> hashMap);
  Future<Either<Failure,String>> fbLogin();
  Future<Either<Failure,String>> twitterLogin();
  Future<Either<Failure,String>> googleLogin();
  // TODO: logout
  Future<Either<Failure,dynamic>> resetPassword(String email);
}