

import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/feed/presentation/widgets/feed_widgets.dart';
import 'package:colibri/features/search/presentation/bloc/search_cubit.dart';
import 'package:colibri/features/search/presentation/widgets/ThreadedPostItem.dart';
import 'package:colibri/features/search/presentation/widgets/hasttag_item.dart';
import 'package:colibri/features/search/presentation/widgets/people_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  SearchCubit searchCubit;
  int currentPage=0;
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    searchCubit = getIt<SearchCubit>();
    tabController.addListener(() {
      setState(() {
        currentPage=tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) => [
          SliverAppBar(
            elevation: 0.0,
            floating: false,
            pinned: true,
            expandedHeight: 155.toHeight,
            centerTitle: true,
            leading: BackButton(color: Colors.black,onPressed: (){
              BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.home());
            }
              ,),
            title: "Search".toSubTitle1(color: Colors.black,fontWeight: FontWeight.bold),
            flexibleSpace:FlexibleSpaceBar(
              background:  [
                "#hashtag, username, etc..."
                    .toSearchBarField(fieldValidator: searchCubit.searchQuery).toHorizontalPadding(24)
                    .toContainer(height: 65)
              ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
            )
                ,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size(context.getScreenWidth, 56.toHeight),
              child:   TabBar(
              controller: tabController,
                onTap: (int){
                  setState(() {
                    currentPage=int;
                  });
                },
                indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.colorPrimary,width: 3),insets: EdgeInsets.only(left:18,right: 80)),
                indicatorColor: AppColors.colorPrimary,
                tabs: [
                  Tab(child: ["Trending".toSubTitle2(fontWeight: FontWeight.bold,color: currentPage==0?AppColors.colorPrimary:Colors.black.withOpacity(.5)),
                    ].toRow(crossAxisAlignment: CrossAxisAlignment.center),),
                  Tab(child: ["For You".toSubTitle2(fontWeight: FontWeight.bold,color: currentPage==1?AppColors.colorPrimary:Colors.black.withOpacity(.5)),
                    ].toRow(crossAxisAlignment: CrossAxisAlignment.center),),
                  Tab(child: ["Covid-19".toSubTitle2(fontWeight: FontWeight.bold,color: currentPage==2?AppColors.colorPrimary:Colors.black.withOpacity(.5)),
                   ].toRow(crossAxisAlignment: CrossAxisAlignment.center),),
                ],
              ),
            ),
          )
        ],
        body: TabBarView(
          controller: tabController,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                    child: StreamBuilder<List<String>>(
                      initialData: [],
                      stream: searchCubit.haTagList,
                    builder: (context,snapshot)=>Column(
                      children: List<Widget>.generate(snapshot.data.length,
                              (index) => index==5||index==8?ListTile(leading: "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
                                  .toNetWorkImage(borderRadius: 8,height: 100,width: 80).toHorizontalPadding(12),title: "This is dummy title".toCaption(),subtitle: "12.k views".toCaption(),dense: false,):getHastTagItem(title: snapshot.data[index])),
                    ).toContainer(decoration: BoxDecoration(border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(.3), width: 2.0)))),
                    ))),
            ListView.builder(
                itemCount: 10,
                itemBuilder: (_, index) => PeopleItem()).toContainer(decoration: BoxDecoration(border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(.3), width: 2.0)))),
            Container(
                child: ListView(children: [
                  PostItem(showArrowIcon: true),
                  Divider(),
                  6.toSizedBox,
                  "5:58pm, 20 Aug, 2020".toCaption(fontSize: 10).toHorizontalPadding(24),
                  6.toSizedBox,
                  Divider(thickness: 3,),
                  10.toSizedBox,
                  ThreadedPostItem(startingThread: true,),

                  ThreadedPostItem(lastThread: true,).toContainer().makeBottomBorder,
                      // .toContainer(color: Colors.red),
                  // Divider(thickness: 3,),
                  10.toSizedBox,
                  ThreadedPostItem(lastThread: true),
                  // Divider(thickness: 3,),
                ],)),
          ],
        ),
      ).toSafeArea,
    );
  }
}
