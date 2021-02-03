import 'package:auto_route/auto_route_annotations.dart';
import 'package:colibri/core/common/error_screen.dart';
import 'package:colibri/core/common/widget/web_view_screen.dart';
import 'package:colibri/features/authentication/presentation/pages/login_screen.dart';
import 'package:colibri/features/authentication/presentation/pages/reset_password_screen.dart';
import 'package:colibri/features/authentication/presentation/pages/signup_screen.dart';
import 'package:colibri/features/feed/presentation/pages/create_post.dart';
import 'package:colibri/features/feed/presentation/pages/feed_screen.dart';
import 'package:colibri/features/feed/presentation/pages/post_view_screen.dart';
import 'package:colibri/features/feed/presentation/pages/webpage_screen.dart';
import 'package:colibri/features/groups/group_detail.dart';
import 'package:colibri/features/groups/groups_screen.dart';
import 'package:colibri/features/messages/presentation/pages/chat_screen.dart';
import 'package:colibri/features/profile/presentation/pages/profile_screen.dart';
import 'package:colibri/features/welcome/presentation/pages/welcome_screen.dart';

@CupertinoAutoRouter(

  routes: <AutoRoute>[
    // initial route is named "/"
    CupertinoRoute(page: WelcomeScreen, ),
    CupertinoRoute(page: SignUpScreen,),
    CupertinoRoute(page: LoginScreen,),
    CupertinoRoute(page: ResetPasswordScreen,),
    CupertinoRoute(page: WebViewScreen,),
    CupertinoRoute(page: ErrorScreen,),
    CupertinoRoute(page: FeedScreen,),
    CupertinoRoute(page: ProfileScreen,),
    CupertinoRoute(page: CreatePost,),
    CupertinoRoute(page: ChatScreen,),
    CupertinoRoute(page: GroupScreen,),
    CupertinoRoute(page: GroupDetail,),
    CupertinoRoute(page: PostViewScreen,),
    CupertinoRoute(page: WebPageScreen,),

  ],
)
class $MyRouter {}