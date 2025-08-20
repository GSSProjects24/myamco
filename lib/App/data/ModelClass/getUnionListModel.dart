// To parse this JSON data, do
//
//     final getUnionListModel = getUnionListModelFromJson(jsonString);

import 'dart:convert';

GetUnionListModel getUnionListModelFromJson(String str) => GetUnionListModel.fromJson(json.decode(str));

String getUnionListModelToJson(GetUnionListModel data) => json.encode(data.toJson());

class GetUnionListModel {
  bool? success;
  Data? data;
  String? message;

  GetUnionListModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetUnionListModel.fromJson(Map<String, dynamic> json) => GetUnionListModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? notify;
  String? status;
  String? memberId;
  String? filePath;
  List<NotifyDetail>? notifyDetails;

  Data({
    this.notify,
    this.status,
    this.memberId,
    this.filePath,
    this.notifyDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notify: json["notify"],
    status: json["status"],
    memberId: json["member_id"],
    filePath: json["file_path"],
    notifyDetails: json["notify_details"] == null ? [] : List<NotifyDetail>.from(json["notify_details"]!.map((x) => NotifyDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notify": notify,
    "status": status,
    "member_id": memberId,
    "file_path": filePath,
    "notify_details": notifyDetails == null ? [] : List<dynamic>.from(notifyDetails!.map((x) => x.toJson())),
  };
}

class NotifyDetail {
  int? id;
  String? type;
  String? memberId;
  String? title;
  String? description;
  String? fileUpload;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotifyDetail({
    this.id,
    this.type,
    this.memberId,
    this.title,
    this.description,
    this.fileUpload,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory NotifyDetail.fromJson(Map<String, dynamic> json) => NotifyDetail(
    id: json["id"],
    type: json["type"],
    memberId: json["member_id"],
    title: json["title"],
    description: json["description"],
    fileUpload: json["file_upload"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "member_id": memberId,
    "title": title,
    "description": description,
    "file_upload": fileUpload,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
