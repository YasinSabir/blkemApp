import 'dart:async';

import 'package:colibri/extensions.dart';

final validateEmail =
    StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
  if (email.isValidEmail) {
    sink.add(email);
  } else {
    sink.addError('Please enter a valid email');
  }
});
final validatePassword =
    StreamTransformer<String, String>.fromHandlers(handleData: (string, sink) {
  try {
    print("password lenght"+string.length.toString());
    if (string.length < 8) {
      print("FIRST");
//      sink.addError("Req min 8 Chars");
      sink.addError("Choose a password wisely");
    }
    else if(nameRegExp.hasMatch(string).not){
      print("SECOND");
      sink.addError("Choose a password wisely");
//      sink.addError("Req min 1 alphabet");
    }
    else if(numberRegExp.hasMatch(string).not){
      print("THIRD");
      sink.addError("Choose a password wisely");
//      sink.addError("Req min 1 number");
    }
    else {
      print("FOURTH");
      sink.add(string);
    }
  } catch (e) {
    print("Exceptio:" + e.toString());
  }
});
 StreamTransformer<String, String> notEmptyValidator(FieldType type) {
  return StreamTransformer<String, String>.fromHandlers(handleData: (string, sink) {
     if (string.isNotEmpty) {
       sink.add(string);
     } else {
       switch(type){
         case FieldType.FIRST_NAME:
           sink.addError("Your first name is missing! Please try again");
           break;
         case FieldType.LAST_NAME:
           sink.addError("Your last name is missing! Please try again");
           break;
         case FieldType.USERNAME:
           sink.addError("You need a username");
           break;
       }
     }
   });
 }

final phoneValidator =
    StreamTransformer<String, String>.fromHandlers(handleData: (string, sink) {
  if (string.length >= 10) {
    sink.add(string);
  } else {
    sink.addError("Enter a valid phone");
  }
});

confirmPassValidator(Stream<String> password) =>
    StreamTransformer<String, String>.fromHandlers(handleData: (string, sink) {
      String givenPassword;
      password.listen((event) {
       givenPassword=event;
       print(givenPassword);
      });
      print("actual pass" + givenPassword);
      print("c pass" + string);
      if (string.isNotEmpty && string == givenPassword) {
        sink.add(string);
      } else {
        sink.addError("Password Mismatched");
      }
    });
final RegExp nameRegExp = RegExp('[a-zA-Z]');
final RegExp numberRegExp = RegExp(r'\d');

enum FieldType{FIRST_NAME,LAST_NAME,USERNAME}