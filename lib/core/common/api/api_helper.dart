
import 'dart:collection';

import 'package:colibri/core/common/api/api_constants.dart';
import 'package:colibri/core/common/failure.dart';
import 'package:colibri/core/datasource/local_data_source.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';



@injectable
class ApiHelper{
  final Dio dio=getIt<Dio>();
  final LocalDataSource localDataSource;
  ApiHelper(this.localDataSource){
    dio.options.baseUrl=ApiConstants.baseUrl;
    var interceptor=InterceptorsWrapper(
        onError: (e){
          print("error in response ${e.response.data["message"]}");
        },
        onRequest: (req)async{
          var user=await localDataSource.getUser();
          if(user!=null){
            (req.data as FormData).fields.add(MapEntry("session_id", user.auth.authToken));
          }
          print(req);
          print(req.baseUrl+req.path);
          print(req.data.toString());
        },
        onResponse: (res){
          print(res.statusCode);
          print(res);
        }
    );
    dio.interceptors.add(interceptor);
  }

  Future<Either<Failure,T>> post<T>(String path,HashMap<String,dynamic> body,{dynamic headers})async =>
      await safeApiHelperRequest(() =>
          dio.post(path,data: FormData.fromMap(body),options: Options(headers: headers)));

  Future<Either<Failure,T>> get<T>(String path,{Map<String,dynamic> headers})async =>
      await safeApiHelperRequest(() => dio.get(path,options: Options(headers:headers)));

  Future<Either<Failure,T>> put<T>(String path,{Map<String,dynamic> headers,dynamic body})async =>
      await safeApiHelperRequest(() => dio.put(path,options: Options(headers:headers),data: body));

  Future<Either<Failure,dynamic>> safeApiHelperRequest(Future<dynamic> Function() function)async{
    try{
      // EasyLoading.show();
      // var user=await localDataSource.getUser();
      // if(user!=null){
      // }
      var response=await function.call();
      // EasyLoading.dismiss();
      if(response.data["code"]==200)
      return Right(response);
      return Left(ServerFailure(response.data["message"]));
    } on DioError catch(e){
      // EasyLoading.dismiss();
      return Left(ServerFailure(_handleError(e)));
    }
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
          "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occurred";
    }
    return errorDescription;
  }

}
