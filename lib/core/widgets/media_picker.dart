
import 'package:auto_route/auto_route.dart';
import 'package:colibri/core/theme/colors.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../extensions.dart';

openMediaPicker(BuildContext context,
    StringToVoidFunc onMediaSelected,
    {MediaType mediaType=MediaType.IMAGE})async{
  PickedFile media;
  var status = await Permission.storage.status;
  if (status.isUndetermined) {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
    ].request();
    print(statuses[Permission.storage]); // it should print PermissionStatus.granted
  }

// You can request multiple permissions at once.
else
  context.showAlertDialog(widgets: [
    "Camera".toSubTitle2(color: AppColors.colorPrimary).toFlatButton(()async {
      ExtendedNavigator.root.pop();
      if(mediaType==MediaType.IMAGE){
        media= await ImagePicker().getImage(source: ImageSource.camera);
        if(media!=null){
          onMediaSelected(media.path);
        }
      }
      else{
        media= await ImagePicker().getVideo(source: ImageSource.camera);
        var videoFile=await media?.path?.compressVideo;
        onMediaSelected(videoFile?.path);
      }

    }),
    "Gallery".toSubTitle2(color: AppColors.colorPrimary).toFlatButton(() async{
      ExtendedNavigator.root.pop();
      if(mediaType==MediaType.IMAGE){
        media= await ImagePicker().getImage(source: ImageSource.gallery);
        if(media!=null){
          onMediaSelected(media.path);
        }
      }
      else{
        media= await ImagePicker().getVideo(source: ImageSource.gallery,);
        var videoFile=await media?.path?.compressVideo;
        onMediaSelected(videoFile?.path);
      }

    }),
  ],title: "Choose media type");

}