// To parse this JSON data, do
//
//     final createGroupModel = createGroupModelFromJson(jsonString);

import 'dart:convert';

CreateGroupModel createGroupModelFromJson(String str) =>
    CreateGroupModel.fromJson(json.decode(str));

String createGroupModelToJson(CreateGroupModel data) =>
    json.encode(data.toJson());

class CreateGroupModel {
  bool? status;
  String? message;
  List<Datum>? data;

  CreateGroupModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateGroupModel.fromJson(Map<String, dynamic> json) =>
      CreateGroupModel(
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
  int? id;
  int? userId;
  String? groupName;
  List<String>? contactIds;
  String? createDate;

  Datum({
    this.id,
    this.userId,
    this.groupName,
    this.contactIds,
    this.createDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        groupName: json["groupName"],
        contactIds: json["contact_ids"] == null
            ? []
            : List<String>.from(json["contact_ids"]!.map((x) => x)),
        createDate: json["create_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "groupName": groupName,
        "contact_ids": contactIds == null
            ? []
            : List<dynamic>.from(contactIds!.map((x) => x)),
        "create_date": createDate,
      };
}
