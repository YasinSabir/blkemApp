import 'package:auto_route/auto_route.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:colibri/features/groups/create_group.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: AppColors.colorPrimary.withOpacity(.05),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // showModalBottomSheet(context: context, builder: (c)=>BlocProvider.value(
            //     value: getIt<FeedCubit>(),
            //     child: CreatePostCard()));
            AwesomeDialog(
              width: context.getScreenWidth,
              isDense: true,
              padding: EdgeInsets.zero,
              body: BlocProvider.value(
                  value: getIt<FeedCubit>(),
                  child: CreatePostCard()),
              dialogType: DialogType.NO_HEADER,
              animType: AnimType.BOTTOMSLIDE, context: context,
            )..show();
          },
          backgroundColor: AppColors.colorPrimary,
          child: Icon(Icons.add,size: 28,),
        ),
        appBar: AppBar(
          elevation: 0.0,
        leading: BackButton(onPressed: (){
          BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.home());
        },color: Colors.black,),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.colorPrimary),
        centerTitle: true,
        title: "Groups".toSubTitle1(fontWeight: FontWeight.bold),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: (){
            showModalBottomSheet(context: context, builder: (c)=>CreateGroup());
          },color: Colors.black,)
        ],
          bottom: PreferredSize(preferredSize: Size(context.getScreenWidth, 120.toHeight),
          child: [
            "Search for groups".toSearchBarField(fieldValidator: FieldValidators(null, null)).toPadding(12),
            TabBar(
              isScrollable: true,
              indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.colorPrimary,width: 3),insets: EdgeInsets.only(left:20,right: 40)),
                indicatorColor: AppColors.colorPrimary,
                tabs: [
                  Tab(child: ["Main".toSubTitle2(fontWeight: FontWeight.bold),
                    2.toSizedBoxHorizontal,
                    "51".toBadge(isActive: true)].toRow(crossAxisAlignment: CrossAxisAlignment.center),),
                  Tab(child: ["Users".toSubTitle2(fontWeight: FontWeight.bold),
                    2.toSizedBoxHorizontal,
                    "5".toBadge()].toRow(crossAxisAlignment: CrossAxisAlignment.center),),
                  Tab(child: ["My Groups".toSubTitle2(fontWeight: FontWeight.bold),
                    2.toSizedBoxHorizontal,
                    "85".toBadge()].toRow(crossAxisAlignment: CrossAxisAlignment.center),),

            // "Main".toTab(),
            // "User".toTab(),
            // "My Groups".toTab(),
          ])

          ].toColumn(),

          ),
      ),
        body: TabBarView(children: [
          StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) => groupTile().onTap(() {
            // ExtendedNavigator.root.push(Routes.groupDetail);
              BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.groupDetails());
            }),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2.5 : 2.3),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ).toPadding(8),
          Container(),
          Container(),
        ],),
      ),
    );
  }
  Widget groupTile(){

    return Card(
      elevation: 0.0,
      shadowColor:Colors.black.withAlpha(10),
      child: Container(
        // padding: EdgeInsets.all(8),
        // color: Colors.red,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF979797).withAlpha(55)),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
          BoxShadow(blurRadius: 99,spreadRadius: 10,color: Colors.black.withAlpha(10),offset: Offset(0,-7))
        ]),
        child: [
        ["Public Group".toBody2(color: AppColors.colorPrimary,fontSize: 12),
          ["Join"].toPopUpMenuButton((value) { },icon: RotatedBox(quarterTurns: 45,
            child: Icon(
              FontAwesomeIcons.ellipsisV,
              size: 20,
              color: Colors.grey,
            ),
          ))
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center),
        "Financial Developement".toSubTitle2(fontWeight: FontWeight.bold,fontSize: 16),
         [
           // 10.toSizedBox,
           "1.5m post today".toCaption(),
           2.toSizedBox,
           [
           "https://i.pravatar.cc/150?img=1".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),
           "https://i.pravatar.cc/150?img=2".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),
           "https://i.pravatar.cc/150?img=3".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),
           "https://i.pravatar.cc/150?img=4".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),
           "https://i.pravatar.cc/150?img=5".toRoundNetworkImage(radius: 4).toHorizontalPadding(2),
         ].toRow(),
           2.toSizedBox,
           "1k members".toCaption(),
          15.toSizedBox,
         ].toColumn(mainAxisAlignment: MainAxisAlignment.end).toExpanded()
      ].toColumn().toPadding(8),),
    );
  }
}
