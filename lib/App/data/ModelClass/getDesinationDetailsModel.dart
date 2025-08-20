// To parse this JSON data, do
//
//     final getDesignationDetailsModel = getDesignationDetailsModelFromJson(jsonString);

import 'dart:convert';

GetDesignationDetailsModel getDesignationDetailsModelFromJson(String str) => GetDesignationDetailsModel.fromJson(json.decode(str));

String getDesignationDetailsModelToJson(GetDesignationDetailsModel data) => json.encode(data.toJson());

class GetDesignationDetailsModel {
  bool? success;
  Data? data;
  String? message;

  GetDesignationDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetDesignationDetailsModel.fromJson(Map<String, dynamic> json) => GetDesignationDetailsModel(
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
  List<DesignationDetail>? designationDetails;

  Data({
    this.notify,
    this.status,
    this.designationDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notify: json["notify"],
    status: json["status"],
    designationDetails: json["designation_details"] == null ? [] : List<DesignationDetail>.from(json["designation_details"]!.map((x) => DesignationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notify": notify,
    "status": status,
    "designation_details": designationDetails == null ? [] : List<dynamic>.from(designationDetails!.map((x) => x.toJson())),
  };
}

class DesignationDetail {
  int? id;
  String? designationName;
  String? status;

  DesignationDetail({
    this.id,
    this.designationName,
    this.status,
  });

  factory DesignationDetail.fromJson(Map<String, dynamic> json) => DesignationDetail(
    id: json["id"],
    designationName: json["designation_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "designation_name": designationName,
    "status": status,
  };
}
