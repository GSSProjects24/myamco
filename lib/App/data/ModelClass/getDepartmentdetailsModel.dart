// To parse this JSON data, do
//
//     final getDepartmentDetailsModel = getDepartmentDetailsModelFromJson(jsonString);

import 'dart:convert';

GetDepartmentDetailsModel getDepartmentDetailsModelFromJson(String str) => GetDepartmentDetailsModel.fromJson(json.decode(str));

String getDepartmentDetailsModelToJson(GetDepartmentDetailsModel data) => json.encode(data.toJson());

class GetDepartmentDetailsModel {
  bool? success;
  Data? data;
  String? message;

  GetDepartmentDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetDepartmentDetailsModel.fromJson(Map<String, dynamic> json) => GetDepartmentDetailsModel(
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
  List<DepartmentDetail>? departmentDetails;

  Data({
    this.notify,
    this.status,
    this.departmentDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notify: json["notify"],
    status: json["status"],
    departmentDetails: json["department_details"] == null ? [] : List<DepartmentDetail>.from(json["department_details"]!.map((x) => DepartmentDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notify": notify,
    "status": status,
    "department_details": departmentDetails == null ? [] : List<dynamic>.from(departmentDetails!.map((x) => x.toJson())),
  };
}

class DepartmentDetail {
  int? id;
  String? departmentName;
  String? status;

  DepartmentDetail({
    this.id,
    this.departmentName,
    this.status,
  });

  factory DepartmentDetail.fromJson(Map<String, dynamic> json) => DepartmentDetail(
    id: json["id"],
    departmentName: json["department_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "department_name": departmentName,
    "status": status,
  };
}
