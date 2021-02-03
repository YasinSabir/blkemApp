import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/routes/routes.gr.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/messages/presentation/bloc/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  MessageCubit messageCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageCubit = getIt<MessageCubit>();
  }

  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.0,

              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    BlocProvider.of<FeedCubit>(context)
                        .changeCurrentPage(ScreenType.home());
                  }),
              expandedHeight: 135.toHeight,
              floating: true,
              pinned: true,
              centerTitle: true,
              actions: [
                ["Delete Messages", "Report"].toPopUpMenuButton((value) {},
                    icon: RotatedBox(
                        quarterTurns: 45, child: AppIcons.optionIcon))
              ],
              title: "Messages".toSubTitle1(
                  color: AppColors.textColor, fontWeight: FontWeight.bold),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: [
                  'Search for contacts...'
                      .toSearchBarField(
                          fieldValidator: messageCubit.searchQuery)
                      .toHorizontalPadding(8)
                      .toContainer(height: 65),
                  [
                    15.toSizedBox,
                    "Sort By:".toCaption(fontWeight: FontWeight.bold),
                    5.toSizedBox,
                    "Latest First".toCaption(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 15,
                    )
                  ].toRow().toSymmetricPadding(12, 6)
                ].toColumn(mainAxisAlignment: MainAxisAlignment.end),
              ),
              // title:
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: AppColors.colorPrimary,
                    child: [
                      FlatButton.icon(
                        icon: SvgPicture.asset(
                          Images.delete,
                          color: Colors.white,
                          height: 16,
                          width: 16,
                        ),
                        label: "Delete".toCaption(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        onPressed: () {},
                      ),
                    ]
                        .toRow(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center)
                        .toHorizontalPadding(12),
                  ),
                  key: ValueKey(index),
                  child: messageItem().onTap(() {
                    ExtendedNavigator.root.push(Routes.chatScreen);
                  }),
                ),
                childCount: 40,
              ),
            )
          ],
        ).toContainer(color: Colors.white),
      ),
    );
  }

  Widget messageItem() {
    return [
      10.toSizedBox,
      "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
          .toRoundNetworkImage(radius: 10),
      20.toSizedBox,
      [
        Row(
          children: [
            "John Doe".toSubTitle2(fontWeight: FontWeight.bold),
            5.toSizedBoxHorizontal,
            if (context.getScreenWidth > 320) "@john.doe".toSubTitle2(),
            [
              // Icon(
              //   Icons.access_time,
              //   color: Colors.grey,
              //   size: 15,
              // ),
              5.toSizedBoxHorizontal,
              "2 hours ago"
                  .toCaption(fontWeight: FontWeight.w400, fontSize: 10.toSp)
            ]
                .toRow(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center)
                .toContainer()
                .toExpanded()
          ],
        ),
        if (context.getScreenWidth < 321) "@john.doe".toSubTitle2(),
        2.toSizedBox,
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, "
            .toCaption(maxLines: 2)
      ].toColumn().toExpanded()
    ].toRow().toPadding(16).toContainer().makeBottomBorder;
  }
}
