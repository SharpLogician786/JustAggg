// To parse this JSON data, do
//
//     final appLinksModel = appLinksModelFromJson(jsonString);

import 'dart:convert';

AppLinksModel appLinksModelFromJson(String str) =>
    AppLinksModel.fromJson(json.decode(str));

String appLinksModelToJson(AppLinksModel data) => json.encode(data.toJson());

class AppLinksModel {
  bool? status;
  String? message;
  List<Datum>? data;

  AppLinksModel({
    this.status,
    this.message,
    this.data,
  });

  factory AppLinksModel.fromJson(Map<String, dynamic> json) => AppLinksModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? category;
  List<Link>? links;

  Datum({
    this.category,
    this.links,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        category: json["category"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}

class Link {
  int? id;
  String? name;
  String? image;
  String? placeholder;
  String? value;
  int? clicks;
  int? linkId;
  int? status;

  Link({
    this.id,
    this.name,
    this.image,
    this.placeholder,
    this.value,
    this.clicks,
    this.linkId,
    this.status,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        placeholder: json["placeholder"],
        value: json["value"],
        clicks: json["clicks"],
        linkId: json["linkId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "placeholder": placeholder,
        "value": value,
        "clicks": clicks,
        "linkId": linkId,
        "status": status,
      };
}
