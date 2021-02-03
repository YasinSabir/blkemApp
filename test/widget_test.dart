// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:collection';
import 'package:colibri/extensions.dart';
import 'package:colibri/core/common/failure.dart';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/core/common/validators.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/features/authentication/data/models/login_response.dart';
import 'package:colibri/features/authentication/domain/repo/auth_repo.dart';
import 'package:colibri/features/authentication/domain/usecase/login_use_case.dart';
import 'package:colibri/features/authentication/presentation/pages/login_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:colibri/main.dart';
import 'package:intl/intl.dart';

void main() {
 setUpAll(()async{
    TestWidgetsFlutterBinding.ensureInitialized();
    ScreenUtil.init();
  await configureDependencies();
 });
 test("etst pass", (){
  String password="Sachin052#";
  expect(password.isValidPass, true);
 });
 // testWidgets("test login screen", (tester)async{
 //   // await tester.pumpWidget(MyApp());
 //   // await tester.pump();
 //   // expect("Login", findsOneWidget);
 // });
 // testWidgets("Login Screen", (tester)async{
 //  await tester.pumpWidget(MaterialApp(home: LoginScreen()));
 //  await tester.pump(Duration(milliseconds:400));
 //  var email= tester.firstWidget(find.byType(TextField));
 //  await tester.tap(find.byWidget(email));
 //  await tester.enterText(find.byWidget(email), "sachin");
 //  // find.bySemanticsLabel("Email");
 //  // await tester.showKeyboard(find.byType(TextField));
 //  // await tester.enterText(find.text("Email"), "sachin");
 //  // await tester.pump();
 //  // tester.enterText(find.text("Email"), "sachin");
 // });
//
// group("Login Api Tests", (){
//
//   test("Login api with wrong credentials", ()async{
//     LoginUseCase loginUseCase=getIt<LoginUseCase>();
//     var response=await loginUseCase(HashMap.from({"email":"sachin@gmail.com","password":"password"}));
//     response.fold((l) => find.byType(ServerFailure), (r) => expect(r, Right(r)));
//   });
//   test("Login api with right credentials", ()async{
//     LoginUseCase loginUseCase=getIt<LoginUseCase>();
//     var response=await loginUseCase(HashMap.from({"email":"dabowen86@gmail.com","password":"TimBuk89#"}));
//     response.fold((l) => find.byType(ServerFailure), (r) {
//       print(r.auth.authToken);
//       return find.byType(LoginResponse);
//     } );
//   });
// });
//
//   test("date", (){
//     final DateTime now = DateTime.now();
//     final DateFormat formatter = DateFormat('d MMM, y').add_jm();
//     final String formatted = formatter.format(now);
//     print(formatted);
//   });
}
