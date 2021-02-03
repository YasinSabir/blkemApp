import 'package:colibri/core/di/injection.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colibri/extensions.dart';
class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    context.initScreenUtil();
    return Scaffold(

      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        title:"Create Post".toSubTitle1(color: AppColors.textColor,fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
      brightness: Brightness.light,
      ),
      body: BlocProvider(
          create: (c)=>getIt<FeedCubit>(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CreatePostCard(),
            ],
          ).makeScrollable()),);
  }
}
