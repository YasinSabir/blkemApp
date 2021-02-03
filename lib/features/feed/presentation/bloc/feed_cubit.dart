import 'dart:io';
import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:colibri/core/common/stream_validators.dart';
import 'package:colibri/features/feed/presentation/widgets/all_home_screens.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_compress/src/progress_callback.dart/subscription.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:colibri/extensions.dart';
part 'feed_state.dart';
@injectable
class FeedCubit extends Cubit<FeedState> {
  final postTextValidator=FieldValidators(null,null)..textController.text="";

  final currentPageController=BehaviorSubject<ScreenType>.seeded(ScreenType.home());
  Function(ScreenType) get changeCurrentPage=>currentPageController.sink.add;
  Stream<ScreenType> get currentPage=>currentPageController.stream;

   final imagesData=<MediaData>[];
  final imageController=BehaviorSubject<List<MediaData>>.seeded(<MediaData>[]);
  Function(List<MediaData>) get changeImages=>imageController.sink.add;
  Stream<List<MediaData>> get images=>imageController.stream;

  Stream<bool>  get imageButton=>Rx.combineLatest([images], (values) {
    if(values[0].isEmpty)return true;
    var data= values[0] as List<MediaData>;
    return data.any((element) => element.type==MediaType.IMAGE);

  });

  Stream<bool>  get videoButton=>Rx.combineLatest([images], (values) {
    if(values[0].isEmpty)return true;
    var data= values[0] as List<MediaData>;
    return data.any((element) => element.type==MediaType.VIDEO);

  });

  Stream<bool>  get gifButton=>Rx.combineLatest([images], (values) {
    if(values[0].isEmpty)return true;
    var data= values[0] as List<MediaData>;
    return data.any((element) => element.type==MediaType.GIF);

  });

  final enablePublisController=BehaviorSubject<bool>.seeded(false);
  Function(bool) get changePublishButton=>enablePublisController.sink.add;
  Stream<bool> get enablePublishButton=>enablePublisController.stream;

  // Stream<bool> get enablePublishButton=>


  FeedCubit() : super(FeedInitial()){
  Rx.merge([postTextValidator.stream,images]).listen((event) {
    if(event is String) changePublishButton(event.isNotEmpty||imagesData.isNotEmpty);
    else if(event is List<MediaData>) changePublishButton(event.isNotEmpty||postTextValidator.text.isNotEmpty);
  });
    // postTextValidator.stream.listen((event) {
    //   changePublishButton(event.isNotEmpty);
    // });
    // images.listen((event) {
    //   changePublishButton(event.isNotEmpty);
    // });
  }

  addImage(String image){
    imagesData.removeWhere((element) => element.type!=MediaType.IMAGE);
    imagesData.add(MediaData(type: MediaType.IMAGE,thumbnail: image,path: image));
    changeImages(imagesData);
  }
  addGif(String image){
    imagesData.clear();
    imagesData.add(MediaData(type: MediaType.GIF,thumbnail: image,path: image));
    changeImages(imagesData);
  }
  addVideo(String image)async{
   try{
     var thumb=await File(image).getThumbnail;
     imagesData.clear();
     imagesData.add(MediaData(type: MediaType.VIDEO,path: image,thumbnail: thumb.path));
     changeImages(imagesData);
   }catch(e){
     print(e);
   }
  }

  removedFile(int index){
    imagesData.removeAt(index);
    changeImages(imagesData);
  }
}
class MediaData{
  final MediaType type;
  final String path;
  final String thumbnail;
  MediaData({this.type, this.path, this.thumbnail});
}
