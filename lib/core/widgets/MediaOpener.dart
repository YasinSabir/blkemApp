import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:colibri/extensions.dart';
class MediaOpener extends StatefulWidget {
  final MediaData data;
  const MediaOpener({Key key, this.data}) : super(key: key);
  @override
  _MediaOpenerState createState() => _MediaOpenerState();
}

class _MediaOpenerState extends State<MediaOpener> {
  @override
  Widget build(BuildContext context) {
     switch(widget.data.type){

       case MediaType.IMAGE:
        return OpenImage(path: widget.data.path,);
         break;
       case MediaType.VIDEO:
         return MyVideoPlayer(path: widget.data.path,);
         break;
       case MediaType.GIF:
         return OpenImage(path: widget.data.path,);
         break;
       case MediaType.EMOJI:
         return Container();
         break;
       default: return Container();
     }
  }
}

class MyVideoPlayer extends StatefulWidget {
  final String path;

  const MyVideoPlayer({Key key, this.path}) : super(key: key);
  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  BetterPlayerController _betterPlayerController;
  bool isPlaying;
  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.FILE,widget.path);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(fit: BoxFit.cover),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title:"Video Player".toSubTitle1(color: AppColors.textColor,fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body:AspectRatio(
        aspectRatio: _betterPlayerController.aspectRatio??16/9,
        child: BetterPlayer(
          controller: _betterPlayerController,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async{
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
  }

  }

class OpenImage extends StatelessWidget {
  final String path;

  const OpenImage({Key key, this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title:"Gallery".toSubTitle1(color: AppColors.textColor,fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: Container(
          child: PhotoView(
            imageProvider: path.contains("http")?Image.network(path,headers: {'accept': 'image/*'}):FileImage(File(path)),
          )
      ),
    );
  }
}
