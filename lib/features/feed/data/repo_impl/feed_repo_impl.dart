import 'dart:collection';

import 'package:colibri/core/common/api/api_constants.dart';
import 'package:colibri/core/common/api/api_helper.dart';
import 'package:colibri/core/common/failure.dart';
import 'package:colibri/features/feed/domain/entity/postentity.dart';
import 'package:colibri/features/feed/domain/repo/feed_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as:FeedRepo)
class FeedRepoImpl extends FeedRepo{
  final ApiHelper apiHelper;
  FeedRepoImpl(this.apiHelper);
  @override
  Future<Either<Failure, List<PostEntity>>> getPostFeeds() async{
   var response= await apiHelper.post(ApiConstants.postFeeds,null);
   response.fold(
           (l) => null,
           (r) => null);
  }
  
}