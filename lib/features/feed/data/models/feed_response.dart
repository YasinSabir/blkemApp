// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

FeedResponse welcomeFromMap(String str) => FeedResponse.fromMap(json.decode(str));

String welcomeToMap(FeedResponse data) => json.encode(data.toMap());

class FeedResponse {
  FeedResponse({
    this.errCode,
    this.code,
    this.message,
    this.data,
  });

  int errCode;
  int code;
  String message;
  FeedData data;

  factory FeedResponse.fromMap(Map<String, dynamic> json) => FeedResponse(
    errCode: json["err_code"],
    code: json["code"],
    message: json["message"],
    data: FeedData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "err_code": errCode,
    "code": code,
    "message": message,
    "data": data.toMap(),
  };
}

class FeedData {
  FeedData({
    this.feeds,
  });

  List<Feed> feeds;

  factory FeedData.fromMap(Map<String, dynamic> json) => FeedData(
    feeds: List<Feed>.from(json["feeds"].map((x) => Feed.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "feeds": List<dynamic>.from(feeds.map((x) => x.toMap())),
  };
}

class Feed {
  Feed({
    this.id,
    this.userId,
    this.text,
    this.type,
    this.replysCount,
    this.repostsCount,
    this.likesCount,
    this.status,
    this.threadId,
    this.target,
    this.ogData,
    this.time,
    this.offsetId,
    this.isRepost,
    this.isReposter,
    this.attrs,
    this.advertising,
    this.timeRaw,
    this.ogText,
    this.ogImage,
    this.url,
    this.canDelete,
    this.media,
    this.isOwner,
    this.hasLiked,
    this.hasSaved,
    this.hasReposted,
    this.replyTo,
    this.owner,
    this.reposter,
    this.gif,
    this.cover,
    this.company,
    this.targetUrl,
    this.views,
    this.description,
    this.cta,
    this.avatar,
    this.username,
    this.verified,
    this.name,
    this.isConversed,
    this.showStats,
    this.domain,
  });

  int id;
  int userId;
  String text;
  Type type;
  String replysCount;
  String repostsCount;
  String likesCount;
  Status status;
  int threadId;
  Target target;
  dynamic ogData;
  String time;
  int offsetId;
  bool isRepost;
  bool isReposter;
  Attrs attrs;
  bool advertising;
  String timeRaw;
  String ogText;
  OgImage ogImage;
  String url;
  bool canDelete;
  List<Media> media;
  bool isOwner;
  bool hasLiked;
  bool hasSaved;
  bool hasReposted;
  List<dynamic> replyTo;
  Owner owner;
  Reposter reposter;
  dynamic gif;
  String cover;
  String company;
  String targetUrl;
  int views;
  String description;
  String cta;
  String avatar;
  Username username;
  String verified;
  Name name;
  bool isConversed;
  bool showStats;
  String domain;

  factory Feed.fromMap(Map<String, dynamic> json) => Feed(
    id: json["id"],
    userId: json["user_id"],
    text: json["text"] == null ? null : json["text"],
    type: json["type"] == null ? null : typeValues.map[json["type"]],
    replysCount: json["replys_count"] == null ? null : json["replys_count"],
    repostsCount: json["reposts_count"] == null ? null : json["reposts_count"],
    likesCount: json["likes_count"] == null ? null : json["likes_count"],
    status: json["status"] == null ? null : statusValues.map[json["status"]],
    threadId: json["thread_id"] == null ? null : json["thread_id"],
    target: json["target"] == null ? null : targetValues.map[json["target"]],
    ogData: json["og_data"],
    time: json["time"],
    offsetId: json["offset_id"] == null ? null : json["offset_id"],
    isRepost: json["is_repost"] == null ? null : json["is_repost"],
    isReposter: json["is_reposter"] == null ? null : json["is_reposter"],
    attrs: json["attrs"] == null ? null : attrsValues.map[json["attrs"]],
    advertising: json["advertising"],
    timeRaw: json["time_raw"] == null ? null : json["time_raw"],
    ogText: json["og_text"] == null ? null : json["og_text"],
    ogImage: json["og_image"] == null ? null : ogImageValues.map[json["og_image"]],
    url: json["url"] == null ? null : json["url"],
    canDelete: json["can_delete"] == null ? null : json["can_delete"],
    media: json["media"] == null ? null : List<Media>.from(json["media"].map((x) => Media.fromMap(x))),
    isOwner: json["is_owner"],
    hasLiked: json["has_liked"] == null ? null : json["has_liked"],
    hasSaved: json["has_saved"] == null ? null : json["has_saved"],
    hasReposted: json["has_reposted"] == null ? null : json["has_reposted"],
    replyTo: json["reply_to"] == null ? null : List<dynamic>.from(json["reply_to"].map((x) => x)),
    owner: Owner.fromMap(json["owner"]),
    reposter: json["reposter"] == null ? null : Reposter.fromMap(json["reposter"]),
    gif: json["gif"],
    cover: json["cover"] == null ? null : json["cover"],
    company: json["company"] == null ? null : json["company"],
    targetUrl: json["target_url"] == null ? null : json["target_url"],
    views: json["views"] == null ? null : json["views"],
    description: json["description"] == null ? null : json["description"],
    cta: json["cta"] == null ? null : json["cta"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    username: json["username"] == null ? null : usernameValues.map[json["username"]],
    verified: json["verified"] == null ? null : json["verified"],
    name: json["name"] == null ? null : nameValues.map[json["name"]],
    isConversed: json["is_conversed"] == null ? null : json["is_conversed"],
    showStats: json["show_stats"] == null ? null : json["show_stats"],
    domain: json["domain"] == null ? null : json["domain"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "text": text == null ? null : text,
    "type": type == null ? null : typeValues.reverse[type],
    "replys_count": replysCount == null ? null : replysCount,
    "reposts_count": repostsCount == null ? null : repostsCount,
    "likes_count": likesCount == null ? null : likesCount,
    "status": status == null ? null : statusValues.reverse[status],
    "thread_id": threadId == null ? null : threadId,
    "target": target == null ? null : targetValues.reverse[target],
    "og_data": ogData,
    "time": time,
    "offset_id": offsetId == null ? null : offsetId,
    "is_repost": isRepost == null ? null : isRepost,
    "is_reposter": isReposter == null ? null : isReposter,
    "attrs": attrs == null ? null : attrsValues.reverse[attrs],
    "advertising": advertising,
    "time_raw": timeRaw == null ? null : timeRaw,
    "og_text": ogText == null ? null : ogText,
    "og_image": ogImage == null ? null : ogImageValues.reverse[ogImage],
    "url": url == null ? null : url,
    "can_delete": canDelete == null ? null : canDelete,
    "media": media == null ? null : List<dynamic>.from(media.map((x) => x.toMap())),
    "is_owner": isOwner,
    "has_liked": hasLiked == null ? null : hasLiked,
    "has_saved": hasSaved == null ? null : hasSaved,
    "has_reposted": hasReposted == null ? null : hasReposted,
    "reply_to": replyTo == null ? null : List<dynamic>.from(replyTo.map((x) => x)),
    "owner": owner.toMap(),
    "reposter": reposter == null ? null : reposter.toMap(),
    "gif": gif,
    "cover": cover == null ? null : cover,
    "company": company == null ? null : company,
    "target_url": targetUrl == null ? null : targetUrl,
    "views": views == null ? null : views,
    "description": description == null ? null : description,
    "cta": cta == null ? null : cta,
    "avatar": avatar == null ? null : avatar,
    "username": username == null ? null : usernameValues.reverse[username],
    "verified": verified == null ? null : verified,
    "name": name == null ? null : nameValues.reverse[name],
    "is_conversed": isConversed == null ? null : isConversed,
    "show_stats": showStats == null ? null : showStats,
    "domain": domain == null ? null : domain,
  };
}

enum Attrs { EMPTY, DATA_REPOST_6222, DATA_REPOST_6220 }

final attrsValues = EnumValues({
  "data-repost=\"6220\"": Attrs.DATA_REPOST_6220,
  "data-repost=\"6222\"": Attrs.DATA_REPOST_6222,
  "": Attrs.EMPTY
});

class Media {
  Media({
    this.id,
    this.pubId,
    this.type,
    this.src,
    this.jsonData,
    this.time,
    this.x,
  });

  int id;
  int pubId;
  Type type;
  String src;
  String jsonData;
  String time;
  List<dynamic> x;

  factory Media.fromMap(Map<String, dynamic> json) => Media(
    id: json["id"],
    pubId: json["pub_id"],
    type: typeValues.map[json["type"]],
    src: json["src"],
    jsonData: json["json_data"],
    time: json["time"],
    x: List<dynamic>.from(json["x"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "pub_id": pubId,
    "type": typeValues.reverse[type],
    "src": src,
    "json_data": jsonData,
    "time": time,
    "x": List<dynamic>.from(x.map((x) => x)),
  };
}

enum Type { TEXT, GIF }

final typeValues = EnumValues({
  "gif": Type.GIF,
  "text": Type.TEXT
});

enum Name { DAVE_LOKI, DEMOU_DEMOU }

final nameValues = EnumValues({
  "Dave Loki": Name.DAVE_LOKI,
  "demou demou": Name.DEMOU_DEMOU
});

class OgDataClass {
  OgDataClass({
    this.title,
    this.description,
    this.image,
    this.url,
  });

  String title;
  String description;
  String image;
  String url;

  factory OgDataClass.fromMap(Map<String, dynamic> json) => OgDataClass(
    title: json["title"],
    description: json["description"],
    image: json["image"],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "image": image,
    "url": url,
  };
}

enum OgImage { STATICS_IMG_LOGO_PNG }

final ogImageValues = EnumValues({
  "statics/img/logo.png": OgImage.STATICS_IMG_LOGO_PNG
});

class Owner {
  Owner({
    this.id,
    this.url,
    this.avatar,
    this.username,
    this.name,
    this.verified,
  });

  int id;
  String url;
  String avatar;
  Username username;
  Name name;
  String verified;

  factory Owner.fromMap(Map<String, dynamic> json) => Owner(
    id: json["id"] == null ? null : json["id"],
    url: json["url"],
    avatar: json["avatar"],
    username: usernameValues.map[json["username"]],
    name: nameValues.map[json["name"]],
    verified: json["verified"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "url": url,
    "avatar": avatar,
    "username": usernameValues.reverse[username],
    "name": nameValues.reverse[name],
    "verified": verified,
  };
}

enum Username { GULAG, DEMOUUU }

final usernameValues = EnumValues({
  "demouuu": Username.DEMOUUU,
  "@gulag": Username.GULAG
});

class Reposter {
  Reposter({
    this.name,
    this.username,
    this.url,
  });

  Name name;
  Username username;
  String url;

  factory Reposter.fromMap(Map<String, dynamic> json) => Reposter(
    name: nameValues.map[json["name"]],
    username: usernameValues.map[json["username"]],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "name": nameValues.reverse[name],
    "username": usernameValues.reverse[username],
    "url": url,
  };
}

enum Status { ACTIVE }

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

enum Target { PUBLICATION }

final targetValues = EnumValues({
  "publication": Target.PUBLICATION
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
