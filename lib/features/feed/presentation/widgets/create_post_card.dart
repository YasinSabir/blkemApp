import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/theme/app_icons.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/core/theme/strings.dart';
import 'package:colibri/core/widgets/MediaOpener.dart';
import 'package:colibri/core/widgets/media_picker.dart';
import 'package:colibri/core/widgets/thumbnail_widget.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:emoji_picker/emoji_picker.dart';
// import 'package:emoji_picker/emoji_picker.dart';


import 'package:flutter/cupertino.dart';
import 'package:colibri/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thumbnails/thumbnails.dart' as thumb;
import 'package:thumbnails/thumbnails.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:video_compress/src/progress_callback.dart/subscription.dart';


import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
class CreatePostCard extends StatefulWidget {
  final String title;

  const CreatePostCard({Key key, this.title="New Post"}) : super(key: key);
  @override
  _CreatePostCardState createState() => _CreatePostCardState();
}

class _CreatePostCardState extends State<CreatePostCard> {
   FeedCubit feedCubit;
   Subscription sub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    feedCubit=BlocProvider.of<FeedCubit>(context);
    feedCubit.postTextValidator.changeData("");
    sub=VideoCompress.compressProgress$.subscribe((progress) {
      if(progress<99.99)
      EasyLoading.showProgress((progress/100), status: 'Compressing ${progress.toInt()}%',);
      else EasyLoading.dismiss();
    });
  }
  @override
  Widget build(BuildContext context) {
    return buildCreatePostCard(context);
  }

  Widget buildCreatePostCard(BuildContext context) {
    return [
      5.toSizedBox,
      [
        widget.title.toSubTitle1(fontWeight: FontWeight.bold),
      Icon(Icons.close).onTap(() {
        ExtendedNavigator.root.pop();
      }),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(12),
      5.toSizedBox,
      Divider(thickness: 1,),
      10.toSizedBox,
      [
      10.toSizedBox,
      "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"
          .toNetWorkImage(borderRadius: 8).toContainer(alignment: Alignment.topCenter,),

      "What is happening? #Hashtag...@Mention"
          .toNoBorderTextField()
          .toPostBuilder(validators: BlocProvider.of<FeedCubit>(context).postTextValidator).toHorizontalPadding(5)
          .toContainer(alignment: Alignment.topCenter).toFlexible()
    ].toRow().toContainer(),
      Divider(thickness: 2,),
      Padding(
        padding: const EdgeInsets.only(left:24.0),
        child: StreamBuilder<List<MediaData>>(
            stream: feedCubit.images,
            initialData: [],
            builder: (context, snapshot) {
              return Wrap(
                  runSpacing: 20.0,
                  spacing: 5.0,
                  children:List.generate(snapshot.data.length, (index) {
                    switch(snapshot.data[index].type){
                      case MediaType.IMAGE:
                        return ThumbnailWidget(data:
                        snapshot.data[index],fun: (){
                          feedCubit.removedFile(index);
                        },).onTap(() {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (c)=>MediaOpener(data: snapshot.data[index],)));
                        },).toContainer(width: context.getScreenWidth*.45);
                        break;
                      case MediaType.VIDEO:
                        return Stack(
                          children: [

                            ThumbnailWidget(data:
                            snapshot.data[index],fun: (){
                              feedCubit.removedFile(index);
                            },),
                            Positioned.fill(child: Icon(FontAwesomeIcons.play,color: Colors.white,size: 45,)),
                          ],
                        ).toHorizontalPadding(12).onTap(() {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (c)=>MediaOpener(data: snapshot.data[index],)));
                        });
                        break;
                      case MediaType.GIF:
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GiphyWidget(path: snapshot.data[index].path,fun: (){
                            feedCubit.removedFile(index);
                          },),
                        );
                        break;
                      case MediaType.EMOJI:
                        return ThumbnailWidget(data:
                        snapshot.data[index]);
                        break;
                      default :
                        return Container() ;
                    }
                  },
                  ))
                  .toContainer();
            }
        ),
      ),
      [

        [
          if(context.getScreenWidth<321)
          10.toSizedBoxHorizontal,
          if(context.getScreenWidth>321)
           20.toSizedBoxHorizontal,
          StreamBuilder<bool>(
              stream: feedCubit.imageButton,
              initialData: true,
              builder: (context, snapshot) {
                return AppIcons.imageIcon(enabled: snapshot.data).onTap(() async{
                  if(snapshot.data)
                   await  openMediaPicker(context,(image){
                      feedCubit.addImage(image);
                      // context.showSnackBar(message: image);
                    },mediaType: MediaType.IMAGE,);


                });
              }
          ),
          20.toSizedBoxHorizontal,
          StreamBuilder<bool>(
              stream: feedCubit.videoButton,
              initialData: true,
              builder: (context, snapshot) {
                return AppIcons.videoIcon(enabled: snapshot.data).onTap(() async{
                  if(snapshot.data)
                  await  openMediaPicker(context,(video){
                      feedCubit.addVideo(video);
                    },mediaType: MediaType.VIDEO);
                });
              }
          ),
          20.toSizedBoxHorizontal,
          AppIcons.smileIcon.onTap( () {
            showModelSheet(context);
          }),
          20.toSizedBoxHorizontal,
          StreamBuilder<bool>(
              stream: feedCubit.gifButton,
              initialData: true,
              builder: (context, snapshot) {
                return AppIcons.gifIcon(enabled: snapshot.data).onTap(() async{
                  if(snapshot.data)
                  {
                    final gif = await GiphyPicker.pickGif(
                        context: context,
                        apiKey: Strings.giphyApiKey);
                    if(gif?.images?.original?.url!=null)
                    feedCubit.addGif(gif?.images?.original?.url);
                  }
                  // context.showModelBottomSheet(GiphyImage.original(gif: gif));
                });
              }
          ),

          [
            StreamBuilder<int>(
                stream: BlocProvider.of<FeedCubit>(context).postTextValidator.stream.map((event) => event.length),
                initialData: 0,
                builder: (context, snapshot) {
                  return Visibility(
                      visible: snapshot.data!=0,
                      child: "${snapshot.data}/600".toCaption());
                }
            ),

            // 10.toSizedBoxHorizontal,
            StreamBuilder<bool>(
                stream: feedCubit.enablePublishButton,
                initialData: false,
                builder: (context, snapshot) {
                  return "Publish".toCaption(color: Colors.white).toMaterialButton(
                          () {},enabled: snapshot.data
                  ).toHorizontalPadding(4);
                }
            ),
            if(context.getScreenWidth<321)
              8.toSizedBoxHorizontal,
            if(context.getScreenWidth>321)
              16.toSizedBoxHorizontal,
          ].toRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end)
              .toExpanded()
        ].toRow(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center)
            .toContainer()
            .toFlexible(),
      ].toRow()
    ].toColumn(mainAxisSize: MainAxisSize.min);

  }

  void showModelSheet(BuildContext context) {
   context.showModelBottomSheet(EmojiPicker(
     rows: 3,
     columns: 7,
     buttonMode: ButtonMode.CUPERTINO,
     numRecommended: 10,
     onEmojiSelected: (emoji, category) {
       print(emoji.emoji);
       // print(emoji.emoji);
       feedCubit.postTextValidator.textController.text=feedCubit.postTextValidator.text+emoji.emoji;
     },
   ).toContainer(height: context.getScreenWidth>600?400:250,color: Colors.transparent));
  }
  @override
  void dispose() {
    // TODO: implement dispose

    sub.unsubscribe();
    super.dispose();
  }
}



enum MediaType{
  IMAGE,
  VIDEO,
  GIF,
  EMOJI
}