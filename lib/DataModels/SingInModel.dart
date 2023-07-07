// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  bool? status;
  String? message;
  Data? data;

  SignInModel({
    this.status,
    this.message,
    this.data,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  String? email;
  String? secondaryEmail;
  String? username;
  int? parentId;
  dynamic googleId;
  dynamic facebookId;
  String? appleId;
  String? address;
  String? secondaryAddress;
  String? contactLink;
  String? customText;
  String? bio;
  String? company;
  String? designation;
  String? dob;
  String? coverUrl;
  String? profileUrl;
  String? logoUrl;
  String? phone;
  String? secondaryPhone;
  String? platform;
  String? gender;
  String? loginWith;
  int? profileOn;
  int? directMode;
  int? directLinkId;
  dynamic directValue;
  int? leadMode;
  String? fcmToken;
  String? backgroundColor;
  String? tagUid;
  int? verifyUser;
  String? verifyCode;
  int? isDeleted;
  String? activeProfile;
  String? timestamp;
  String? createdAt;
  String? updatedAt;
  String? role;
  String? token;
  String? baseUrl;
  Profile? profile;
  List<dynamic>? links;

  Data({
    this.id,
    this.name,
    this.email,
    this.secondaryEmail,
    this.username,
    this.parentId,
    this.googleId,
    this.facebookId,
    this.appleId,
    this.address,
    this.secondaryAddress,
    this.contactLink,
    this.customText,
    this.bio,
    this.company,
    this.designation,
    this.dob,
    this.coverUrl,
    this.profileUrl,
    this.logoUrl,
    this.phone,
    this.secondaryPhone,
    this.platform,
    this.gender,
    this.loginWith,
    this.profileOn,
    this.directMode,
    this.directLinkId,
    this.directValue,
    this.leadMode,
    this.fcmToken,
    this.backgroundColor,
    this.tagUid,
    this.verifyUser,
    this.verifyCode,
    this.isDeleted,
    this.activeProfile,
    this.timestamp,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.token,
    this.baseUrl,
    this.profile,
    this.links,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    secondaryEmail: json["secondaryEmail"],
    username: json["username"],
    parentId: json["parentId"],
    googleId: json["googleId"],
    facebookId: json["facebookId"],
    appleId: json["appleId"],
    address: json["address"],
    secondaryAddress: json["secondaryAddress"],
    contactLink: json["contactLink"],
    customText: json["customText"],
    bio: json["bio"],
    company: json["company"],
    designation: json["designation"],
    dob: json["dob"],
    coverUrl: json["coverUrl"],
    profileUrl: json["profileUrl"],
    logoUrl: json["logoUrl"],
    phone: json["phone"],
    secondaryPhone: json["secondaryPhone"],
    platform: json["platform"],
    gender: json["gender"],
    loginWith: json["loginWith"],
    profileOn: json["profileOn"],
    directMode: json["directMode"],
    directLinkId: json["directLinkId"],
    directValue: json["directValue"],
    leadMode: json["leadMode"],
    fcmToken: json["fcmToken"],
    backgroundColor: json["backgroundColor"],
    tagUid: json["tagUid"],
    verifyUser: json["verifyUser"],
    verifyCode: json["verifyCode"],
    isDeleted: json["isDeleted"],
    activeProfile: json["activeProfile"],
    timestamp: json["timestamp"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    role: json["role"],
    token: json["token"],
    baseUrl: json["baseUrl"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    links: json["links"] == null ? [] : List<dynamic>.from(json["links"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "secondaryEmail": secondaryEmail,
    "username": username,
    "parentId": parentId,
    "googleId": googleId,
    "facebookId": facebookId,
    "appleId": appleId,
    "address": address,
    "secondaryAddress": secondaryAddress,
    "contactLink": contactLink,
    "customText": customText,
    "bio": bio,
    "company": company,
    "designation": designation,
    "dob": dob,
    "coverUrl": coverUrl,
    "profileUrl": profileUrl,
    "logoUrl": logoUrl,
    "phone": phone,
    "secondaryPhone": secondaryPhone,
    "platform": platform,
    "gender": gender,
    "loginWith": loginWith,
    "profileOn": profileOn,
    "directMode": directMode,
    "directLinkId": directLinkId,
    "directValue": directValue,
    "leadMode": leadMode,
    "fcmToken": fcmToken,
    "backgroundColor": backgroundColor,
    "tagUid": tagUid,
    "verifyUser": verifyUser,
    "verifyCode": verifyCode,
    "isDeleted": isDeleted,
    "activeProfile": activeProfile,
    "timestamp": timestamp,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "role": role,
    "token": token,
    "baseUrl": baseUrl,
    "profile": profile?.toJson(),
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x)),
  };
}

class Profile {
  String? percentage;
  int? totalCount;
  int? trueCount;
  ProfileComplete? profileComplete;

  Profile({
    this.percentage,
    this.totalCount,
    this.trueCount,
    this.profileComplete,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    percentage: json["percentage"],
    totalCount: json["totalCount"],
    trueCount: json["trueCount"],
    profileComplete: json["profileComplete"] == null ? null : ProfileComplete.fromJson(json["profileComplete"]),
  );

  Map<String, dynamic> toJson() => {
    "percentage": percentage,
    "totalCount": totalCount,
    "trueCount": trueCount,
    "profileComplete": profileComplete?.toJson(),
  };
}

class ProfileComplete {
  bool? picture;
  bool? cover;
  bool? logo;
  bool? tagActivation;
  bool? firstLink;

  ProfileComplete({
    this.picture,
    this.cover,
    this.logo,
    this.tagActivation,
    this.firstLink,
  });

  factory ProfileComplete.fromJson(Map<String, dynamic> json) => ProfileComplete(
    picture: json["picture"],
    cover: json["cover"],
    logo: json["logo"],
    tagActivation: json["tag_activation"],
    firstLink: json["first_link"],
  );

  Map<String, dynamic> toJson() => {
    "picture": picture,
    "cover": cover,
    "logo": logo,
    "tag_activation": tagActivation,
    "first_link": firstLink,
  };
}
