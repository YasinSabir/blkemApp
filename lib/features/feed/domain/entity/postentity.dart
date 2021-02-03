import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route.dart';
import 'package:colibri/features/feed/presentation/widgets/create_post_card.dart';

class PostEntity{
  final String postId;
  final String username;
  final String userFirstName;
  final String userLastName;
  final String postedTimesAgo;
  final String postTitle;
  final String userProfileUrl;
  final String likesCount;
  final String repostCount;
  final String commentsCount;
  final List<Media> mediaItems;

  PostEntity({
    @required this.postId,
    @required this.username,
    @required this.userFirstName,
    @required this.userLastName,
    @required this.postedTimesAgo,
    @required this.postTitle,
    @required this.userProfileUrl,
    @required this.likesCount,
    @required this.repostCount,
    @required this.commentsCount,
    @required this.mediaItems});
} 

class Media{
  final MediaType mediaType;
  final String url;
  Media({
    @required this.mediaType,
    @required this.url});
}