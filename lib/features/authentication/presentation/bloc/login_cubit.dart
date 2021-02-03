import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/core/common/uistate/common_ui_state.dart';
import 'package:colibri/core/common/validators.dart';
import 'package:colibri/core/datasource/local_data_source.dart';
import 'package:colibri/features/authentication/domain/usecase/login_use_case.dart';
import 'package:colibri/features/authentication/domain/usecase/social_login_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<CommonUIState> {

  FieldValidators passwordValidator = FieldValidators(null,null,obsecureTextBool: true,passwordField: true);
  FieldValidators emailValidators;
  Stream<bool> get validForm => Rx.combineLatest2<String, String,bool>(
          emailValidators.stream, passwordValidator.stream, (a, b) {
    return a!=null&&b!=null&&a.isNotEmpty&&b.isNotEmpty;
  }).asBroadcastStream();

  final errorTextStream=BoolStreamValidator();

  // agree terms and conditions

  final agreeTermsController=BoolStreamValidator();

  // use cases
  final LocalDataSource localDataSource;
  final LoginUseCase loginUseCase;
  final SocialLoginUseCase socialLoginUseCase;

  // constructor
  LoginCubit(this.localDataSource, this.loginUseCase, this.socialLoginUseCase) : super(CommonUIState.initial()){
    emailValidators = FieldValidators(null,passwordValidator.focusNode);
  }

  loginUser()async {
    // empty case
    if (emailValidators.textController.text.isEmpty &&
        passwordValidator.textController.text.isEmpty) {
      emailValidators.onChange("");
      passwordValidator.onChange("");
    }
    //
    else {
      emit(CommonUIState.loading());

      //Login Funtionality Custom Code
      var url = "https://staging.blkem.com/mobile_api/login";
      var data = {
        "email": emailValidators.text,
        "password": passwordValidator.text
      };
      var res = await http.post(url, body: data);
      if (jsonDecode(res.body) == 0) {
        Fluttertoast.showToast(
            msg: "Invalid Credentials", toastLength: Toast.LENGTH_SHORT);
      } else {
        if (res.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Login Successfully", toastLength: Toast.LENGTH_SHORT);
        } else {
          var dd = res.body;
          Fluttertoast.showToast(
              msg: "invalid device type", toastLength: Toast.LENGTH_LONG);
        }
        //Login Funtionality Custom Code

        //get data from local storage...
        // var response = await loginUseCase(HashMap<String,dynamic>.from({
        //   "email":emailValidators.text,
        //   "password":passwordValidator.text
        // }));
        // response.fold(
        //         (l) => emit(CommonUIState.error(l.errorMessage)),
        //         (r) => emit(CommonUIState.success(r)));
      }
    }
  }

  void facebookLogin()async{
    var response=await socialLoginUseCase(SocialLogin.FB);
    emit(response.fold((l) => CommonUIState.error(l.errorMessage), (r) => CommonUIState.success(r)));
  }

  void googleLogin()async{
    var response=await socialLoginUseCase(SocialLogin.GOOGLE);
    emit(response.fold((l) => CommonUIState.error(l.errorMessage), (r) => CommonUIState.success(r)));
  }

  void twitterLogin()async{
    var response=await socialLoginUseCase(SocialLogin.TWITTER);
    emit(response.fold((l) => CommonUIState.error(l.errorMessage), (r) => CommonUIState.success(r)));
  }

  @override
  Future<Function> close() {
    emailValidators.onDispose();
    passwordValidator.onDispose();
    errorTextStream.dispose();
      super.close();
  }
}
