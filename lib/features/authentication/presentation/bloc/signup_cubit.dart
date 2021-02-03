import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/core/common/uistate/common_ui_state.dart';
import 'package:colibri/core/common/validators.dart';
import 'package:colibri/features/authentication/domain/usecase/sign_up_case.dart';
import 'package:colibri/features/authentication/domain/usecase/social_login_use_case.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

part 'signup_state.dart';

@injectable
class SignUpCubit extends Cubit<CommonUIState> {
  FieldValidators emailValidator;

  FieldValidators firstNameValidator;

  FieldValidators userNameValidator;

  FieldValidators lastNameValidator;

  FieldValidators passwordValidator;

  FieldValidators confirmPasswordValidator;

  // page view controller for sign up ui
  final currentPageController=BehaviorSubject<int>.seeded(0);
  Function(int) get changeCurrentPage=>currentPageController.sink.add;
  Stream<int> get currentPage=>currentPageController.stream;

  // agree terms and conditions

  final agreeTermsController=BehaviorSubject<bool>.seeded(false);
  Function(bool) get changeAgreeTerms=>agreeTermsController.sink.add;
  Stream<bool> get agreeTerms=>agreeTermsController.stream;

  Stream<bool> get isFirstStepValid=> Rx.combineLatest3(firstNameValidator.stream, lastNameValidator.stream, userNameValidator.stream, (a, b, c) => true);
  // Stream<bool> get isSecondStepValid=> Rx.combineLatest3(firstNameValidator.stream, lastNameValidator.stream, userNameValidator.stream, (a, b, c) => true);
  Stream<bool> get validForm => Rx.combineLatest7<String,String,String,String,String,String,bool,bool>(
      emailValidator.stream,
      firstNameValidator.stream,
      userNameValidator.stream,
      lastNameValidator.stream,
      passwordValidator.stream,
      confirmPasswordValidator.stream,
      agreeTerms,
      (a, b, c, d, e, f,g) => true&&g);

  // use cases
  final SignUpUseCase signUpUseCase;
  final SocialLoginUseCase socialLoginUseCase;

  SignUpCubit(this.signUpUseCase, this.socialLoginUseCase) : super(CommonUIState.initial()) {
    initCubit();
  }

  signUp() async{
    emit(CommonUIState.success("User registered successfully"));
    if (emailValidator.isEmpty &&
        firstNameValidator.isEmpty &&
        userNameValidator.isEmpty &&
        lastNameValidator.isEmpty &&
        passwordValidator.isEmpty) {
      emailValidator.onChange("");
      passwordValidator.onChange("");
      firstNameValidator.onChange("");
      userNameValidator.onChange("");
      lastNameValidator.onChange("");
      confirmPasswordValidator.onChange("");
    } else {
      // var response = await signUpUseCase(HashMap.from({
      //   "email": emailValidator.text,
      //   "first_name": firstNameValidator.text,
      //   "last_name": lastNameValidator.text,
      //   "username": userNameValidator.text,
      //   "password": passwordValidator.text
      // }));
      // emit(response.fold((l) =>
      //     CommonUIState.error(l.errorMessage),
      //         (r) => CommonUIState.success(r)));

      var url = "https://staging.blkem.com/mobile_api/signup";

      //save in local storage...
      var response = await signUpUseCase(HashMap.from({
        "email": emailValidator.text,
        "first_name": firstNameValidator.text,
        "last_name": lastNameValidator.text,
        "username": userNameValidator.text,
        "password": passwordValidator.text
      }));

      var data = {
        "first_name": firstNameValidator.text,
        "last_name": lastNameValidator.text,
        "email": emailValidator.text,
        "username": userNameValidator.text,
        "password": passwordValidator.text
      };
      var res = await http.post(url,body:data);
      // emit(response.fold((l) =>
      //     CommonUIState.error(l.errorMessage),
      //         (r) => CommonUIState.success(r)));
      if(jsonDecode(res.body) == "doubling_username"){
        Fluttertoast.showToast(msg: "Account already exists",toastLength: Toast.LENGTH_SHORT);
        // emit(response.fold((l) =>
        //     CommonUIState.error(l.errorMessage),
        //         (r) => CommonUIState.success(r)));
      }else{

        if(res.statusCode == 200 ){
          Fluttertoast.showToast(msg: "account created",toastLength: Toast.LENGTH_SHORT);
          // emit(response.fold((l) =>
          //     CommonUIState.error(l.errorMessage),
          //         (r) => CommonUIState.success(r)));
        }else{
          var dd = res.body;
          Fluttertoast.showToast(msg: "error" ,toastLength: Toast.LENGTH_LONG);
          // emit(res.fold((l) =>
          //     CommonUIState.error(l.errorMessage),
          //         (r) => CommonUIState.success(r)));
        }
      }
    }
  }

  void initCubit() {
    confirmPasswordValidator = FieldValidators(
        StreamTransformer.fromHandlers(handleData: (string, sink) {
      if (string.isNotEmpty && string == passwordValidator.text) {
        sink.add(string);
      } else {
        sink.addError("Please make sure password match");
      }
    }), null, obsecureTextBool: true,passwordField: true);
    passwordValidator = FieldValidators(
        validatePassword, confirmPasswordValidator.focusNode,
        obsecureTextBool: true,passwordField: true);
    emailValidator =
        FieldValidators(validateEmail, passwordValidator.focusNode);
    userNameValidator = FieldValidators(
        notEmptyValidator(FieldType.USERNAME), emailValidator.focusNode);
    lastNameValidator = FieldValidators(
        notEmptyValidator(FieldType.LAST_NAME), userNameValidator.focusNode);
    firstNameValidator = FieldValidators(
        notEmptyValidator(FieldType.FIRST_NAME), lastNameValidator.focusNode);
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
  Future<void> close() {
    // TODO: implement close
    confirmPasswordValidator.onDispose();
    firstNameValidator.onDispose();
    lastNameValidator.onDispose();
    userNameValidator.onDispose();
    emailValidator.onDispose();
    passwordValidator.onDispose();
    currentPageController.close();
     super.close();
  }
}
