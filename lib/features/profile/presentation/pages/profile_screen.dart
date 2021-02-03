import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:colibri/features/feed/presentation/widgets/feed_widgets.dart';
import 'package:colibri/features/profile/presentation/widgets/profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  final bool otherUser;
  const ProfileScreen({Key key, this.otherUser=true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    // BlocProvider.of(context)
    return Scaffold(
      // appBar: AppBar(),
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: Visibility(
              visible: !otherUser,
              child: FloatingActionButton(

                onPressed: () {

                  showAnimatedDialog(

                      context: context, builder: (c)=> Dialog(

                    insetPadding: EdgeInsets.all(8),

                    // contentPadding: EdgeInsets.zero,
                    child: BlocProvider.value(
                        value: getIt<FeedCubit>(), child: CreatePostCard()),
                  ));
                },

                backgroundColor: AppColors.colorPrimary,
                child: Icon(Icons.add,size: 28,),
              ),
            ),
            body: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading: null,
                    brightness: Brightness.light,
                    elevation: 0.0,
                    expandedHeight: context.getScreenWidth>320?480.toHeight:520.toHeight,
                    floating: true,
                    pinned: true,
                    // title: Text('Profile'),
                    backgroundColor: Colors.white,

                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: getTopAppBar(context,otherUser: otherUser),
                    ),
                    bottom: PreferredSize(
                      child:   Stack(
                        children: [
                          Positioned.fill(
                            top: 0.0,
                            child: Container(
                              color: Colors.white,
                            ).makeVerticalBorders,
                          ),
                          TabBar(
                            isScrollable: false,

                            indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.colorPrimary,width: 3),),
                            // indicatorWeight: 1,
                            // indicatorSize: TabBarIndicatorSize.label,
                            // labelPadding: EdgeInsets.all(0),
                            tabs: [
                              Tab(
                                text: "Posts",
                              ),
                              Tab(
                                text: "Media",
                              ),
                              Tab(
                                text: "Interest",
                              )
                            ],
                          ),
                        ],
                      ),
                      preferredSize: Size(500, 56),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  Container(
                      child: ListView.separated(
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return [PostItem(showThread: false,otherUser: otherUser,), 5.toSizedBox]
                                .toColumn();
                          }, separatorBuilder: (BuildContext context, int index) {   return  Divider(thickness: 2,); },)),
                  Container(
                      child: ListView.separated(
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return [PostItem(showThread: false,otherUser: otherUser), 5.toSizedBox]
                              .toColumn();
                        }, separatorBuilder: (BuildContext context, int index) {   return  Divider(thickness: 2,); },)),
                  Container(
                      child: ListView.separated(
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return [PostItem(showThread: false,otherUser: otherUser,isLiked: true,isInterest: true,), 5.toSizedBox]
                              .toColumn();
                        }, separatorBuilder: (BuildContext context, int index) {   return  Divider(thickness: 2,); },)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
