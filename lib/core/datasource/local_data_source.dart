import 'dart:convert';

import 'package:colibri/features/authentication/data/models/login_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';


abstract class LocalDataSource{
  final storage;
  LocalDataSource(this.storage);

  Future<void> saveUser(LoginResponse response);

  Future<LoginResponse> getUser();

  userLogin();

  Future<bool> isUserLoggedIn();

  clearData();
}

@Injectable(as: LocalDataSource)
class LocalDataSourceImpl extends LocalDataSource{
  final Dio dio;
  final FlutterSecureStorage storage;
  LocalDataSourceImpl(this.dio, this.storage) : super(storage);
  @override
  Future<bool> isUserLoggedIn() async{
   return await storage.containsKey(key: "user");
  }

  @override
  userLogin() async{
    await storage.write(key: "user", value: "yes");
  }

  @override
  clearData() async{
   storage.deleteAll();
  }

  @override
  Future<void> saveUser(LoginResponse response) async{
    await storage.write(key: "user", value: jsonEncode(response));
  }

  @override
  Future<LoginResponse> getUser() async{
    if(await storage.containsKey(key: "user"))
    return LoginResponse.fromJson(jsonDecode(await storage.read(key: "user")));
    return null;
  }
}