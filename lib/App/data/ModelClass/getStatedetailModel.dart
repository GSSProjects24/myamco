// To parse this JSON data, do
//
//     final getStateDetailsModel = getStateDetailsModelFromJson(jsonString);

import 'dart:convert';

GetStateDetailsModel getStateDetailsModelFromJson(String str) => GetStateDetailsModel.fromJson(json.decode(str));

String getStateDetailsModelToJson(GetStateDetailsModel data) => json.encode(data.toJson());

class GetStateDetailsModel {
  bool? success;
  Data? data;
  String? message;

  GetStateDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetStateDetailsModel.fromJson(Map<String, dynamic> json) => GetStateDetailsModel(
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
  String? countyId;
  List<StateDetail>? stateDetails;

  Data({
    this.notify,
    this.status,
    this.countyId,
    this.stateDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notify: json["notify"],
    status: json["status"],
    countyId: json["county_id"],
    stateDetails: json["state_details"] == null ? [] : List<StateDetail>.from(json["state_details"]!.map((x) => StateDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notify": notify,
    "status": status,
    "county_id": countyId,
    "state_details": stateDetails == null ? [] : List<dynamic>.from(stateDetails!.map((x) => x.toJson())),
  };
}

class StateDetail {
  int? stateId;
  int? countryId;
  CountryCode? countryCode;
  CountryName? countryName;
  String? stateName;

  StateDetail({
    this.stateId,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.stateName,
  });

  factory StateDetail.fromJson(Map<String, dynamic> json) => StateDetail(
    stateId: json["state_id"],
    countryId: json["country_id"],
    countryCode: countryCodeValues.map[json["country_code"]]!,
    countryName: countryNameValues.map[json["country_name"]]!,
    stateName: json["state_name"],
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "country_id": countryId,
    "country_code": countryCodeValues.reverse[countryCode],
    "country_name": countryNameValues.reverse[countryName],
    "state_name": stateName,
  };
}

enum CountryCode {
  MY
}

final countryCodeValues = EnumValues({
  "MY": CountryCode.MY
});

enum CountryName {
  MALAYSIA
}

final countryNameValues = EnumValues({
  "Malaysia": CountryName.MALAYSIA
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
