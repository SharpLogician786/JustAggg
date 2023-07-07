// To parse this JSON data, do
//
//     final analyticModel = analyticModelFromJson(jsonString);

import 'dart:convert';

AnalyticModel analyticModelFromJson(String str) =>
    AnalyticModel.fromJson(json.decode(str));

String analyticModelToJson(AnalyticModel data) => json.encode(data.toJson());

class AnalyticModel {
  bool? status;
  String? message;
  Data? data;

  AnalyticModel({
    this.status,
    this.message,
    this.data,
  });

  factory AnalyticModel.fromJson(Map<String, dynamic> json) => AnalyticModel(
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
  int? userId;
  String? profilePicture;
  int? tContactsMe;
  int? totalClicks;
  int? totalViews;
  int? todayClicks;
  int? todayViews;
  int? clicksRate;
  Monthly? weekly;
  Monthly? monthly;
  Monthly? yearly;

  Data({
    this.userId,
    this.profilePicture,
    this.tContactsMe,
    this.totalClicks,
    this.totalViews,
    this.todayClicks,
    this.todayViews,
    this.clicksRate,
    this.weekly,
    this.monthly,
    this.yearly,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        profilePicture: json["profilePicture"],
        tContactsMe: json["tContactsMe"],
        totalClicks: json["totalClicks"],
        totalViews: json["totalViews"],
        todayClicks: json["todayClicks"],
        todayViews: json["todayViews"],
        clicksRate: json["clicksRate"],
        weekly:
            json["weekly"] == null ? null : Monthly.fromJson(json["weekly"]),
        monthly:
            json["monthly"] == null ? null : Monthly.fromJson(json["monthly"]),
        yearly:
            json["yearly"] == null ? null : Monthly.fromJson(json["yearly"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "profilePicture": profilePicture,
        "tContactsMe": tContactsMe,
        "totalClicks": totalClicks,
        "totalViews": totalViews,
        "todayClicks": todayClicks,
        "todayViews": todayViews,
        "clicksRate": clicksRate,
        "weekly": weekly?.toJson(),
        "monthly": monthly?.toJson(),
        "yearly": yearly?.toJson(),
      };
}

class Monthly {
  int? clicks;
  int? views;
  int? clicksRate;
  int? contacts;
  List<Link>? links;

  Monthly({
    this.clicks,
    this.views,
    this.clicksRate,
    this.contacts,
    this.links,
  });

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
        clicks: json["clicks"],
        views: json["views"],
        clicksRate: json["clicksRate"],
        contacts: json["contacts"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clicks": clicks,
        "views": views,
        "clicksRate": clicksRate,
        "contacts": contacts,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}

class Link {
  int? linkId;
  String? name;
  String? image;
  int? clicks;

  Link({
    this.linkId,
    this.name,
    this.image,
    this.clicks,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        linkId: json["linkId"],
        name: json["name"],
        image: json["image"],
        clicks: json["clicks"],
      );

  Map<String, dynamic> toJson() => {
        "linkId": linkId,
        "name": name,
        "image": image,
        "clicks": clicks,
      };
}
