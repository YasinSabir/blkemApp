import 'dart:io';

import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/features/feed/presentation/bloc/feed_cubit.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:flutter/material.dart';
import 'package:colibri/extensions.dart';
class ThumbnailWidget extends StatefulWidget {
  final MediaData data;
  final VoidCallback fun;
  const ThumbnailWidget({Key key, this.data,this.fun}) : super(key: key);
  @override
  _ThumbnailWidgetState createState() => _ThumbnailWidgetState();
}

class _ThumbnailWidgetState extends State<ThumbnailWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [

        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(File(widget.data.thumbnail),
              height: widget.data.type==MediaType.IMAGE?120:200.toHeight,
              width: widget.data.type==MediaType.IMAGE?context.getScreenWidth*.40:context.getScreenWidth,
              fit: BoxFit.cover,),),
        Positioned(top: 0,right:0,child: Icon(Icons.close,size: 18,color: Colors.red,).toContainer(decoration: BoxDecoration(
            border: Border.all(color: Colors.red,width: 1),
            shape: BoxShape.circle,color: Colors.white)).onTap(() {
              widget.fun.call();
        }),
        ),
      ],
    ).toContainer();
  }
}

class GiphyWidget extends StatefulWidget {
  final String path;
  final VoidCallback fun;
  const GiphyWidget({Key key, this.path,this.fun}) : super(key: key);
  @override
  _GiphyWidgetState createState() => _GiphyWidgetState();
}

class _GiphyWidgetState extends State<GiphyWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
              widget.path,
              headers: {'accept': 'image/*'})),
        Positioned(top: 0,
          right: 0,
          child: Icon(Icons.close, size: 18, color: Colors.red,).toContainer(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 1),
                  shape: BoxShape.circle, color: Colors.white)).onTap(() {
            widget.fun.call();
          }),
        ),
      ],
    ).toContainer().toHorizontalPadding(12);
  }
}
