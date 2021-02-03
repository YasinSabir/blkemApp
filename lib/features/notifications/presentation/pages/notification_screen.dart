import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/notifications/presentation/pages/notification_page.dart';
import 'package:colibri/features/search/presentation/widgets/ThreadedPostItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: BackButton(onPressed: (){
                  BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.home());
                },color: Colors.black,),
                elevation: 5.0,
                expandedHeight: 100.toHeight,
                floating: true,
                pinned: true,
                // title: Text('Profile'),
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size(context.getScreenWidth, 56.toHeight),
                  child: Stack(
                    children: [
                      // Positioned.fill(
                      //   top: 0.0,
                      //   child: Container(
                      //     color: Colors.red,
                      //   ).makeBottomBorder,
                      // ),
                      TabBar(
                        indicator: UnderlineTabIndicator(),
                        onTap: (int){
                          setState(() {
                            currentPage=int;
                          });
                        },
                        indicatorColor: Colors.white,
                        tabs: [
                          // "Hashtags".toTab(),
                              Tab(child: "Notifications".toSubTitle1(fontWeight: FontWeight.bold,
                                  color: currentPage==0?AppColors.colorPrimary:Colors.black.withOpacity(.5),fontSize: 20),),
                              Tab(child: "Mentions".toSubTitle1(fontWeight: FontWeight.bold,
                                  color:currentPage==1?AppColors.colorPrimary:Colors.black.withOpacity(.5),fontSize: 20)),
                          // "People".toTab(),
                          // "Posts".toTab(),
                        ],
                      ),
                    ],
                  ),
                ),
                // bottom: TabBar(
                //   tabs: [
                //     Tab(text: "Notifications"),
                //     Tab(text: "Mentions"),
                //   ],
                // ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    NotificationPage().toVerticalPadding(4),
                    Container(child: [
                      30.toSizedBox,
                      ThreadedPostItem(lastThread: true,startingThread: true,),Divider(thickness: 1,)].toColumn(),)
                    // [
                    //   SvgPicture.asset(Images.atRate,height: 80,),
                    //   "No mentions yet!".toSubTitle2(),
                    //     10.toSizedBox,
                    //   "There seems to be no mention, All links to you in user application will be displayed here".toCaption(textAlign: TextAlign.center).toHorizontalPadding(32),
                    //   10.toSizedBox,
                    //   "Go to homepage".toButton().toFlatButton(() {
                    //     BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.home());
                    //   },border: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(24.0),
                    //       side: BorderSide(color: Colors.black)
                    //   ))
                    // ].toColumn(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center)
                    // ListView(children: List<Widget>.generate(5, (index) => NotificationItem()),),
                  ],
                ),
              )
            ],
          ).toSafeArea,
        ],
      ),
    );
  }
}
