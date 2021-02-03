
import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/app_theme.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/images.dart';
import 'package:colibri/core/theme/strings.dart';
import 'package:colibri/core/widgets/media_picker.dart';
import 'package:colibri/extensions.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:colibri/features/messages/domain/entity/chat_entity.dart';
import 'package:colibri/features/messages/presentation/bloc/chat_cubit.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giphy_picker/giphy_picker.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatCubit chatCubit;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatCubit = getIt<ChatCubit>();
  }

  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return Scaffold(
      // bottomNavigationBar: PreferredSize(
      //   child: ,
      //   preferredSize: Size(150, 100),
      // ).toSafeArea,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 120.0),
            child: StreamBuilder<List<ChatEntity>>(
                stream: chatCubit.messageList,
                initialData: [],
                builder: (context, snapshot) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    controller.jumpTo(controller.position.maxScrollExtent);
                  });
                  var chat = snapshot.data;
                  return CustomScrollView(
                    controller: controller,
                    slivers: [
                      SliverAppBar(
                        iconTheme: IconThemeData(color: Colors.black),
                        automaticallyImplyLeading: true,
                        collapsedHeight: 60,
                        expandedHeight: 60,
                        actions: [
                          ["Delete Chat", "Report"].toPopUpMenuButton(
                              (s) {},
                              icon: RotatedBox(
                                  quarterTurns: 45, child: AppIcons.optionIcon))
                        ],
                        elevation: 5.0,
                        floating: false,
                        pinned: true,
                        bottom: PreferredSize(
                          preferredSize: Size(context.getScreenWidth, 45),
                          child: [
                            'Search in messages...'
                                .toSearchBarField(
                                    fieldValidator: chatCubit.searchQuery)
                                .toContainer(height: 42),
                            10.toSizedBox,
                          ].toColumn().toHorizontalPadding(24),
                        ),
                        title: "John Doe".toSubTitle1(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold),
                        backgroundColor: Colors.white,
                        centerTitle: true,
                      ),
                      SliverToBoxAdapter(
                        child: Divider(
                          thickness: .5,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (_, index) => chat[index].isSender
                                ? senderCard(chat[index])
                                : receiverCard(chat[index]),
                            childCount: snapshot.data.length),
                      ),
                    ],
                  ).toContainer(color: Colors.white).toSafeArea;
                }),
          ),
          Positioned(
            bottom: 28,
            left: 0,
            right: 0,
            height: 80,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Divider(
                      height: 3,
                      color: Colors.grey.withOpacity(.2),
                      thickness: 3,
                    ),
                    20.toSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 48.0),
                      child: TextField(
                        onChanged: chatCubit.message.onChange,
                        controller: chatCubit.message.textController,
                        style: AppTheme.button
                            .copyWith(fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            labelStyle: AppTheme.caption
                                .copyWith(fontWeight: FontWeight.bold),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.rotate(

                                  angle: 120,
                                  child: Icon(Icons.attach_file).toPadding(14).onTap(() {
                                    openMediaPicker(context, (image) {},
                                        mediaType: MediaType.IMAGE);
                                  }),
                                ),
                                Icon(FontAwesomeIcons.smile,).onTap(()async {
                                  context.showModelBottomSheet(EmojiPicker(
                                    rows: 3,
                                    columns: 7,
                                    buttonMode: ButtonMode.CUPERTINO,
                                    numRecommended: 10,
                                    onEmojiSelected: (emoji, category) {
                                      print(emoji.emoji);
                                      // print(emoji.emoji);
                                      chatCubit.message.textController.text=chatCubit.message.textController.text+emoji.emoji;
                                      // feedCubit.postTextValidator.textController.text=feedCubit.postTextValidator.text+emoji.emoji;
                                    },
                                  ).toContainer(height: context.getScreenWidth>600?400:250,color: Colors.transparent));
                                  // if (gif?.images?.original?.url != null)
                                }
                                ),
                                10.toSizedBox
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(18),
                            hintText: "Send a message",
                            border: InputBorder.none),
                      ).toContainer(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFFECF1F6),
                              borderRadius: BorderRadius.circular(40))),
                    )
                  ],
                ),
                Align(
                    alignment: Alignment(1, .40),
                    child: SvgPicture.asset(
                      Images.sendIcon,
                      height: 24,
                      color: AppColors.colorPrimary,
                    )).toHorizontalPadding(12).onTap(() {
                  chatCubit.sendMessage();
                  chatCubit.message.textController.clear();
                }, removeFocus: false),
              ],
            ).toContainer(height: 56, alignment: Alignment.center),
          ),
        ],
      ),
    );
  }

  senderCard(ChatEntity message) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ["Delete","Unsend"].toPopUpMenuButton((value) { },icon: RotatedBox(
                quarterTurns: 45,
                child: Icon(
                  FontAwesomeIcons.ellipsisV,
                  size: 20,
                  color: Colors.grey,
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.colorPrimary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: message.message
                        .toSubTitle2(color: Colors.white)
                        .toPadding(16),
                  ),
                  5.toSizedBox,
                  message.time.toCaption()
                ],
              ),
            ],
          ),

          // message.message
          //     .toSubTitle2(color: Colors.white)
          //     .toPadding(16)
          //     .toContainer(
          //     decoration: BoxDecoration(
          //         color: Color(0xFF737880),
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(20),
          //             bottomLeft: Radius.circular(20),
          //             bottomRight: Radius.circular(20)))
          //
          // )
        ],
      ),
    ).toHorizontalPadding(16).toVerticalPadding(6);
    return Container(
      child: Wrap(
        alignment: WrapAlignment.end,

        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          [
            Wrap(
              alignment: WrapAlignment.end,
              children: [
                message.message
                    .toSubTitle2(color: Colors.white)
                    .toPadding(16)
                    .toContainer(
                        decoration: BoxDecoration(
                            color: Color(0xFF737880),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))))
              ],
            ),
            5.toSizedBox,
            message.time.toCaption().toHorizontalPadding(20)
          ].toColumn()
        ],
      ),
    );
  }
}

receiverCard(ChatEntity message) {
  return [
    [
      "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
          .toNetWorkImage(
        height: 50,
        width: 50,
        borderRadius: 10,
      ),
      10.toSizedBox,
      [
        message.message
            .toSubTitle2(color: Colors.black)
            .toPadding(16)
            .toContainer(
                decoration: BoxDecoration(
                    color: AppColors.lightSky,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)))),
        5.toSizedBox,
        ["20 Aug, 2020 5:58pm".toCaption()]
            .toRow(mainAxisAlignment: MainAxisAlignment.end)
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.end)
    ].toRow(),
  ].toColumn().toContainer().toHorizontalPadding(16).toVerticalPadding(6);
}
