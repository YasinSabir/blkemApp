// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../features/authentication/presentation/pages/login_screen.dart';
import '../../features/authentication/presentation/pages/reset_password_screen.dart';
import '../../features/authentication/presentation/pages/signup_screen.dart';
import '../../features/feed/presentation/pages/create_post.dart';
import '../../features/feed/presentation/pages/feed_screen.dart';
import '../../features/feed/presentation/pages/post_view_screen.dart';
import '../../features/feed/presentation/pages/webpage_screen.dart';
import '../../features/groups/group_detail.dart';
import '../../features/groups/groups_screen.dart';
import '../../features/messages/presentation/pages/chat_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import '../../features/welcome/presentation/pages/welcome_screen.dart';
import '../common/error_screen.dart';
import '../common/widget/web_view_screen.dart';

class Routes {
  static const String welcomeScreen = '/welcome-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String loginScreen = '/login-screen';
  static const String resetPasswordScreen = '/reset-password-screen';
  static const String webViewScreen = '/web-view-screen';
  static const String errorScreen = '/error-screen';
  static const String feedScreen = '/feed-screen';
  static const String profileScreen = '/profile-screen';
  static const String createPost = '/create-post';
  static const String chatScreen = '/chat-screen';
  static const String groupScreen = '/group-screen';
  static const String groupDetail = '/group-detail';
  static const String postViewScreen = '/post-view-screen';
  static const String webPageScreen = '/web-page-screen';
  static const all = <String>{
    welcomeScreen,
    signUpScreen,
    loginScreen,
    resetPasswordScreen,
    webViewScreen,
    errorScreen,
    feedScreen,
    profileScreen,
    createPost,
    chatScreen,
    groupScreen,
    groupDetail,
    postViewScreen,
    webPageScreen,
  };
}

class MyRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.welcomeScreen, page: WelcomeScreen),
    RouteDef(Routes.signUpScreen, page: SignUpScreen),
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.resetPasswordScreen, page: ResetPasswordScreen),
    RouteDef(Routes.webViewScreen, page: WebViewScreen),
    RouteDef(Routes.errorScreen, page: ErrorScreen),
    RouteDef(Routes.feedScreen, page: FeedScreen),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.createPost, page: CreatePost),
    RouteDef(Routes.chatScreen, page: ChatScreen),
    RouteDef(Routes.groupScreen, page: GroupScreen),
    RouteDef(Routes.groupDetail, page: GroupDetail),
    RouteDef(Routes.postViewScreen, page: PostViewScreen),
    RouteDef(Routes.webPageScreen, page: WebPageScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    WelcomeScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => WelcomeScreen(),
        settings: data,
      );
    },
    SignUpScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SignUpScreen(),
        settings: data,
      );
    },
    LoginScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => LoginScreen(),
        settings: data,
      );
    },
    ResetPasswordScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ResetPasswordScreen(),
        settings: data,
      );
    },
    WebViewScreen: (data) {
      final args = data.getArgs<WebViewScreenArguments>(
        orElse: () => WebViewScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => WebViewScreen(
          key: args.key,
          url: args.url,
          name: args.name,
        ),
        settings: data,
      );
    },
    ErrorScreen: (data) {
      final args = data.getArgs<ErrorScreenArguments>(
        orElse: () => ErrorScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ErrorScreen(
          key: args.key,
          error: args.error,
        ),
        settings: data,
      );
    },
    FeedScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => FeedScreen(),
        settings: data,
      );
    },
    ProfileScreen: (data) {
      final args = data.getArgs<ProfileScreenArguments>(
        orElse: () => ProfileScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ProfileScreen(
          key: args.key,
          otherUser: args.otherUser,
        ),
        settings: data,
      );
    },
    CreatePost: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => CreatePost(),
        settings: data,
      );
    },
    ChatScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ChatScreen(),
        settings: data,
      );
    },
    GroupScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => GroupScreen(),
        settings: data,
      );
    },
    GroupDetail: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => GroupDetail(),
        settings: data,
      );
    },
    PostViewScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PostViewScreen(),
        settings: data,
      );
    },
    WebPageScreen: (data) {
      final args = data.getArgs<WebPageScreenArguments>(
        orElse: () => WebPageScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => WebPageScreen(
          key: args.key,
          title: args.title,
          url: args.url,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// WebViewScreen arguments holder class
class WebViewScreenArguments {
  final Key key;
  final String url;
  final String name;
  WebViewScreenArguments({this.key, this.url, this.name});
}

/// ErrorScreen arguments holder class
class ErrorScreenArguments {
  final Key key;
  final String error;
  ErrorScreenArguments({this.key, this.error});
}

/// ProfileScreen arguments holder class
class ProfileScreenArguments {
  final Key key;
  final bool otherUser;
  ProfileScreenArguments({this.key, this.otherUser = true});
}

/// WebPageScreen arguments holder class
class WebPageScreenArguments {
  final Key key;
  final String title;
  final String url;
  WebPageScreenArguments({this.key, this.title, this.url});
}
