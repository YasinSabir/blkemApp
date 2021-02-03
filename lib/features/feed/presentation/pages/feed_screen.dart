import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:colibri/features/feed/presentation/widgets/feed_widgets.dart';
import 'package:colibri/features/feed/presentation/widgets/promoted_feed.dart';
import 'package:colibri/features/feed/presentation/widgets/reposted_tile.dart';
import 'package:colibri/features/feed/presentation/widgets/story_list.dart';
import 'package:colibri/features/feed/presentation/widgets/where_to_follow.dart';
import 'package:colibri/features/groups/group_detail.dart';
import 'package:colibri/features/groups/groups_screen.dart';
import 'package:colibri/features/messages/presentation/pages/message_screen.dart';
import 'package:colibri/features/notifications/presentation/pages/notification_screen.dart';
import 'package:colibri/features/profile/presentation/pages/profile_screen.dart';
import 'package:colibri/features/profile/presentation/pages/settings_page.dart';
import 'package:colibri/features/search/presentation/pages/searh_screen.dart';
import 'package:colibri/features/search/presentation/widgets/ThreadedPostItem.dart';
import 'package:colibri/features/search/presentation/widgets/hasttag_item.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bookmark_screen.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FeedCubit feedCubit;
  ScrollController scrollController;
  OverlayEntry overlayEntry;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedCubit = getIt<FeedCubit>();
    scrollController=ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0)
    {
    }
      else{
        _insertOverlay(context);
        }
      // you are at bottom position
    }
    });
   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
   //   Future.delayed(Duration(seconds: 2),(){
   //     // Flushbar(
   //     //   backgroundColor: AppColors.colorPrimary,
   //     //   flushbarStyle: FlushbarStyle.GROUNDED,
   //     //   icon: Icon(
   //     //     Icons.arrow_upward_outlined ,
   //     //     color: Colors.white,
   //     //   ),
   //     //   message: 'New post',
   //     //   flushbarPosition: FlushbarPosition.TOP,
   //     //   duration: Duration(seconds: 3),
   //     // )..show(context);
   //     context.showToast(msg: null);
   //   });
   // });
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(designSize: context.getScreenSize, allowFontScaling: true);
    print(context.getScreenWidth.toString());
    return BlocProvider<FeedCubit>(
      create: (c) => feedCubit,
      child: StreamBuilder<ScreenType>(
          stream: feedCubit.currentPage,
          initialData: ScreenType.home(),
          builder: (context, snapshot) {
            return Scaffold(
              key: scaffoldKey,
              floatingActionButton: FloatingActionButton(

                onPressed: () {
                  // showCupertinoDialog(
                  //
                  //     context: context, builder: (c)=> BlocProvider.value(
                  //     value: feedCubit, child: "test".toText.toContainer(color: Colors.red)));
                  // AwesomeDialog(
                  //   context: context,
                  //   width: context.getScreenWidth,
                  //   isDense: true,
                  //   padding: EdgeInsets.zero,
                  //
                  //   body: BlocProvider.value(
                  //       value: feedCubit, child: CreatePostCard()),
                  //   dialogType: DialogType.NO_HEADER,
                  //   animType: AnimType.BOTTOMSLIDE,
                  // )..show();
                  showAnimatedDialog(

                      context: context, builder: (c)=> Dialog(

                      insetPadding: EdgeInsets.all(8),

                    // contentPadding: EdgeInsets.zero,
                        child: BlocProvider.value(
                        value: feedCubit, child: CreatePostCard()),
                      ));
                },

                backgroundColor: AppColors.colorPrimary,
                child: Icon(Icons.add,size: 28,),
              ).toSteamVisibility(feedCubit.currentPage
                  .map((event) => event == ScreenType.home())),
              drawer: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: GetDrawerMenu(),
              ),
              appBar: snapshot.data == ScreenType.home()
                  ? AppBar(
                      brightness: Brightness.light,
                      elevation: 0.0,
                      leading: InkWell(
                        onTap: (){
                          scaffoldKey.currentState.openDrawer();
                        },
                        child: Images.drawerOpen.toSvg(height: 10,width: 10).toPadding(8)
                        //     .onTap(() {
                        //   scaffoldKey.currentState.openDrawer();
                        // })
                            .toPadding(12),
                      ),
                      backgroundColor: Colors.white,
                      title:
                          AppIcons.appName.toContainer(height: 65, width: 65),
                      centerTitle: true,
                    )
                  : null,
              body: Container(
                key: ValueKey(snapshot.data),
                child: AnimatedSwitcher(
                    key: ValueKey(snapshot.data),
                    duration: Duration(milliseconds: 400),
                    child: getSelectedHomeScreen(snapshot.data)),
              ),
              bottomNavigationBar: Material(
                elevation: 10.0,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppIcons.homeIcon(screenType: snapshot.data).toIconButton(
                        onTap: () {
                      feedCubit.changeCurrentPage(ScreenType.home());
                    }),
                    // BottomNavigationBarItem(
                    //     title: Text(""),
                    //     icon: AppIcons.homeIcon(screenType: snapshot.data).toIconButton(onTap: () {
                    //       feedCubit.changeCurrentPage(ScreenType.home());
                    //     })),
                    AppIcons.messageIcon(screenType: snapshot.data)
                        .toIconButton(onTap: () {
                      feedCubit.changeCurrentPage(ScreenType.message());
                    }),
                    // BottomNavigationBarItem(
                    //     title: Text(""),
                    //     icon: AppIcons.messageIcon(screenType: snapshot.data).toIconButton(onTap: () {
                    //       feedCubit.changeCurrentPage(ScreenType.message());
                    //     })),
                    // AppIcons.addIcon.toIconButton(onTap: () {
                    //   ExtendedNavigator.root.push(Routes.createPost);
                    // }),
                    // BottomNavigationBarItem(
                    //     title: Text(""),
                    //     icon: AppIcons.addIcon.toIconButton(onTap: () {
                    //       ExtendedNavigator.root.push(Routes.createPost);
                    //     })),
                    AppIcons.notificationIcon(screenType: snapshot.data)
                        .toIconButton(onTap: () {
                      feedCubit.changeCurrentPage(ScreenType.notification());
                    }),
                    // BottomNavigationBarItem(
                    //     title: Text(""),
                    //     icon:
                    //         AppIcons.notificationIcon(screenType: snapshot.data).toIconButton(onTap: () {
                    //           feedCubit.changeCurrentPage(ScreenType.notification());
                    //         })),
                    AppIcons.searchIcon(screenType: snapshot.data).toIconButton(
                        onTap: () {
                      feedCubit.changeCurrentPage(ScreenType.search());
                    })
                    // BottomNavigationBarItem(
                    //     title: Text(""),
                    //     icon: AppIcons.searchIcon(screenType: snapshot.data).toIconButton(onTap: () {
                    //       feedCubit.changeCurrentPage(ScreenType.search());
                    //     }))
                  ],
                  // child: [
                  //   AppIcons.homeIcon().toIconButton(onTap: () {}),
                  //   AppIcons.messageIcon().toIconButton(onTap: () {}),
                  //   AppIcons.notificationIcon.toIconButton(onTap: () {}),
                  //   AppIcons.searchIcon.toIconButton(onTap: () {}),
                  // ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround).toPadding(8),
                  // color: Colors.white,
                ).toPadding(8),
              ),
            );
          }),
    );
  }

  Widget getHomeWidget() {
    return [
      // CreatePostCard(),
      10.toSizedBox,
      StoryList().toContainer(height: 70),
      Divider(
        thickness: 2,
      ),
      PostItem(
        otherUser: false,
        isLiked: false,
      ),
      Divider(
        thickness: 2,
      ),
      PromotedWidget(),
      Divider(
        thickness: 2,
      ),
      RepostedTile(),
      Divider(thickness: 1,),
      WhereToFollow(),
      // PostItem(otherUser: false,isLiked: false,),
      Divider(
        thickness: 2,
      ),
      ThreadedPostItem(startingThread: true,lastThread: true,),
      Divider(
        thickness: 2,
      ),
      PostItem(),
      Divider(
        thickness: 2,
      ),
      PostItem(),
      Divider(
        thickness: 2,
      ),
      PostItem(),
      Divider(
        thickness: 2,
      ),
    ].toColumn().makeScrollable(scrollController: scrollController);
  }

  onTapBottomBar(int index) {
    if (index == 0)
      feedCubit.changeCurrentPage(ScreenType.home());
    else if (index == 1)
      feedCubit.changeCurrentPage(ScreenType.message());
    else if (index == 2)
      feedCubit.changeCurrentPage(ScreenType.notification());
    else
      feedCubit.changeCurrentPage(ScreenType.search());
  }

  Widget getSelectedHomeScreen(ScreenType data) {
    return data.when(
        home: getHomeWidget,
        message: () => MessageScreen(),
        notification: () => NotificationScreen(),
        search: () => SearchScreen(),
        profile: (args) => ProfileScreen(
              otherUser: args.otherUser,
            ),
        settings: (args) => SettingsScreen(
              fromProfile: args,
            ),
        bookmarks: () => BookMarkScreen(), groups: ()=>GroupScreen(), groupDetails: ()=>GroupDetail());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }
  void _insertOverlay(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      overlayEntry.remove();
    });
    overlayEntry=OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      print(size.width);
      return Align(
        alignment: Alignment(0,-.72),
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: ()  {
              overlayEntry.remove();
              scrollController.animToTop();
            },
            child: Container(
              height: 30,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColors.colorPrimary,borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_upward_outlined,color: Colors.white,size: 15,),
                  "New Posts".toCaption(color: Colors.white)
                ],
              ),
            ),
          ),
        ),
      );
    });
    return Overlay.of(context).insert(
        overlayEntry
    );
  }
}


