/// err_code : 0
/// code : 200
/// message : "User logged in successfully"
/// data : {"id":590,"first_name":"Dave","last_name":"Loki","user_name":"gulag","email":"dabowen86@gmail.com","is_verified":false,"website":"https://www.google.com","about_you":"","gender":"M","country":"United States","post_count":8,"last_post":0,"last_ad":2,"language":"english","following_count":0,"follower_count":2,"wallet":"0.00","ip_address":"101.0.49.184","last_active":"1605001780","member_since":"Jun 2020","profile_privacy":"everyone"}
/// auth : {"auth_token":"b45319ce502f77db136cd23185096a802145245316050018086ff48df8a1aa41072b0524a6744f2990","auth_token_expiry":1920361808}

class LoginResponse {
  int errCode;
  int code;
  String message;
  UserModel data;
  Auth auth;

  LoginResponse({
      this.errCode, 
      this.code, 
      this.message, 
      this.data, 
      this.auth});

  LoginResponse.fromJson(dynamic json) {
    errCode = json["err_code"];
    code = json["code"];
    message = json["message"];
    data = json["data"] != null ? UserModel.fromJson(json["data"]) : null;
    auth = json["auth"] != null ? Auth.fromJson(json["auth"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["err_code"] = errCode;
    map["code"] = code;
    map["message"] = message;
    if (data != null) {
      map["data"] = data.toJson();
    }
    if (auth != null) {
      map["auth"] = auth.toJson();
    }
    return map;
  }

}

 ///auth_token : "b45319ce502f77db136cd23185096a802145245316050018086ff48df8a1aa41072b0524a6744f2990"
/// auth_token_expiry : 1920361808

class Auth {
  String authToken;
  int authTokenExpiry;

  Auth({
      this.authToken, 
      this.authTokenExpiry});

  Auth.fromJson(dynamic json) {
    authToken = json["auth_token"];
    authTokenExpiry = json["auth_token_expiry"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["auth_token"] = authToken;
    map["auth_token_expiry"] = authTokenExpiry;
    return map;
  }

}

/// id : 590
/// first_name : "Dave"
/// last_name : "Loki"
/// user_name : "gulag"
/// email : "dabowen86@gmail.com"
/// is_verified : false
/// website : "https://www.google.com"
/// about_you : ""
/// gender : "M"
/// country : "United States"
/// post_count : 8
/// last_post : 0
/// last_ad : 2
/// language : "english"
/// following_count : 0
/// follower_count : 2
/// wallet : "0.00"
/// ip_address : "101.0.49.184"
/// last_active : "1605001780"
/// member_since : "Jun 2020"
/// profile_privacy : "everyone"

class UserModel {
  int id;
  String firstName;
  String lastName;
  String userName;
  String email;
  bool isVerified;
  String website;
  String aboutYou;
  String gender;
  String country;
  int postCount;
  int lastPost;
  int lastAd;
  String language;
  int followingCount;
  int followerCount;
  String wallet;
  String ipAddress;
  String lastActive;
  String memberSince;
  String profilePrivacy;

  UserModel({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.userName, 
      this.email, 
      this.isVerified, 
      this.website, 
      this.aboutYou, 
      this.gender, 
      this.country, 
      this.postCount, 
      this.lastPost, 
      this.lastAd, 
      this.language, 
      this.followingCount, 
      this.followerCount, 
      this.wallet, 
      this.ipAddress, 
      this.lastActive, 
      this.memberSince, 
      this.profilePrivacy});

  UserModel.fromJson(dynamic json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    userName = json["user_name"];
    email = json["email"];
    isVerified = json["is_verified"];
    website = json["website"];
    aboutYou = json["about_you"];
    gender = json["gender"];
    country = json["country"];
    postCount = json["post_count"];
    lastPost = json["last_post"];
    lastAd = json["last_ad"];
    language = json["language"];
    followingCount = json["following_count"];
    followerCount = json["follower_count"];
    wallet = json["wallet"];
    ipAddress = json["ip_address"];
    lastActive = json["last_active"];
    memberSince = json["member_since"];
    profilePrivacy = json["profile_privacy"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["user_name"] = userName;
    map["email"] = email;
    map["is_verified"] = isVerified;
    map["website"] = website;
    map["about_you"] = aboutYou;
    map["gender"] = gender;
    map["country"] = country;
    map["post_count"] = postCount;
    map["last_post"] = lastPost;
    map["last_ad"] = lastAd;
    map["language"] = language;
    map["following_count"] = followingCount;
    map["follower_count"] = followerCount;
    map["wallet"] = wallet;
    map["ip_address"] = ipAddress;
    map["last_active"] = lastActive;
    map["member_since"] = memberSince;
    map["profile_privacy"] = profilePrivacy;
    return map;
  }

}