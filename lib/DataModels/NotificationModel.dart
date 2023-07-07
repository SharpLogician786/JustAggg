// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  bool? status;
  String? message;
  List<Datum>? data;

  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
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
  Title? title;
  String? message;
  DateTime? dateTime;
  int? userId;
  NotificationType? notificationType;
  int? contactId;
  Contact? contact;

  Datum({
    this.id,
    this.title,
    this.message,
    this.dateTime,
    this.userId,
    this.notificationType,
    this.contactId,
    this.contact,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: titleValues.map[json["title"]]!,
        message: json["message"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        userId: json["user_id"],
        notificationType: notificationTypeValues.map[json["notificationType"]]!,
        contactId: json["contact_id"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleValues.reverse[title],
        "message": message,
        "dateTime": dateTime?.toIso8601String(),
        "user_id": userId,
        "notificationType": notificationTypeValues.reverse[notificationType],
        "contact_id": contactId,
        "contact": contact?.toJson(),
      };
}

class Contact {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? job;
  String? company;
  String? phone;
  String? image;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  Contact({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.job,
    this.company,
    this.phone,
    this.image,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        job: json["job"],
        company: json["company"],
        phone: json["phone"],
        image: json["image"],
        message: json["message"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "email": email,
        "job": job,
        "company": company,
        "phone": phone,
        "image": image,
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

// ignore: constant_identifier_names
enum NotificationType { VIEW, CONTACT, CLICK }

final notificationTypeValues = EnumValues({
  "click": NotificationType.CLICK,
  "contact": NotificationType.CONTACT,
  "view": NotificationType.VIEW
});

// ignore: constant_identifier_names
enum Title { NEW_VISIT, NEW_CONNECTION, NEW_CLICK }

final titleValues = EnumValues({
  "New Click": Title.NEW_CLICK,
  "New Connection": Title.NEW_CONNECTION,
  "New Visit": Title.NEW_VISIT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
