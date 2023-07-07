// To parse this JSON data, do
//
//     final contactsModel = contactsModelFromJson(jsonString);

import 'dart:convert';

ContactsModel contactsModelFromJson(String str) =>
    ContactsModel.fromJson(json.decode(str));

String contactsModelToJson(ContactsModel data) => json.encode(data.toJson());

class ContactsModel {
  bool? status;
  String? message;
  List<DatumContact>? data;

  ContactsModel({
    this.status,
    this.message,
    this.data,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) => ContactsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DatumContact>.from(
                json["data"]!.map((x) => DatumContact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DatumContact {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? job;
  String? company;
  String? phone;
  String? image;
  String? message;
  String? createdAt;
  String? updatedAt;

  DatumContact({
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

  factory DatumContact.fromJson(Map<String, dynamic> json) => DatumContact(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        job: json["job"],
        company: json["company"],
        phone: json["phone"],
        image: json["image"],
        message: json["message"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
