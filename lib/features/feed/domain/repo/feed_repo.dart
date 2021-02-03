import 'package:colibri/core/common/failure.dart';
import 'package:colibri/features/feed/domain/entity/postentity.dart';
import 'package:dartz/dartz.dart';

abstract class FeedRepo{
  Future<Either<Failure,List<PostEntity>>> getPostFeeds();
}