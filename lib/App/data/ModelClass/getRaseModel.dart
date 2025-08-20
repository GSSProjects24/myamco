// To parse this JSON data, do
//
//     final getRaseModel = getRaseModelFromJson(jsonString);

import 'dart:convert';

GetRaseModel getRaseModelFromJson(String str) => GetRaseModel.fromJson(json.decode(str));

String getRaseModelToJson(GetRaseModel data) => json.encode(data.toJson());

class GetRaseModel {
  bool? success;
  Data? data;
  String? message;

  GetRaseModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetRaseModel.fromJson(Map<String, dynamic> json) => GetRaseModel(
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
  List<RaceDetail>? raceDetails;

  Data({
    this.notify,
    this.status,
    this.raceDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notify: json["notify"],
    status: json["status"],
    raceDetails: json["race_details"] == null ? [] : List<RaceDetail>.from(json["race_details"]!.map((x) => RaceDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notify": notify,
    "status": status,
    "race_details": raceDetails == null ? [] : List<dynamic>.from(raceDetails!.map((x) => x.toJson())),
  };
}

class RaceDetail {
  int? id;
  String? raceName;
  String? status;

  RaceDetail({
    this.id,
    this.raceName,
    this.status,
  });

  factory RaceDetail.fromJson(Map<String, dynamic> json) => RaceDetail(
    id: json["id"],
    raceName: json["race_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "race_name": raceName,
    "status": status,
  };
}
