import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/features/feed/presentation/bloc/bookmark_cubit.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/feed/presentation/widgets/feed_widgets.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BookMarkScreen extends StatefulWidget {
  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  BookmarkCubit bookmarkCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookmarkCubit=getIt<BookmarkCubit>();
  }
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(headerSliverBuilder: (v,c)=>[
      SliverAppBar(
        elevation: 0.0,
        collapsedHeight: 60,
        expandedHeight: 100.toHeight,
        floating: true,
        pinned: true,
        centerTitle: true,
        leading: BackButton(color: Colors.black,onPressed: (){
          BlocProvider.of<FeedCubit>(context).changeCurrentPage(ScreenType.home());
        },),
        title: "Bookmarks".toSubTitle1(color: AppColors.textColor,fontWeight: FontWeight.bold),
        flexibleSpace: FlexibleSpaceBar(background: ["Search content bookmarks.."
            .toSearchBarField(fieldValidator: bookmarkCubit.searchQuery).toHorizontalPadding(24)
            .toContainer(height: 65)
            ].toColumn(mainAxisAlignment: MainAxisAlignment.end)),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
      )
    ], body: Container(child: ListView.separated(
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index)  =>Divider(thickness: .5,), itemBuilder: (BuildContext context, int index) =>PostItem(),
      ),)).toSafeArea;
  }
}
