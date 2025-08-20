// To parse this JSON data, do
//
//     final getcCityDetailsModel = getcCityDetailsModelFromJson(jsonString);

import 'dart:convert';

GetcCityDetailsModel getcCityDetailsModelFromJson(String str) => GetcCityDetailsModel.fromJson(json.decode(str));

String getcCityDetailsModelToJson(GetcCityDetailsModel data) => json.encode(data.toJson());

class GetcCityDetailsModel {
  bool? success;
  Data? data;
  String? message;

  GetcCityDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetcCityDetailsModel.fromJson(Map<String, dynamic> json) => GetcCityDetailsModel(
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
  int? counrtyId;
  int? stateId;
  List<CityDetail>? cityDetails;

  Data({
    this.notify,
    this.status,
    this.counrtyId,
    this.stateId,
    this.cityDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notify: json["notify"],
    status: json["status"],
    counrtyId: json["counrty_id"],
    stateId: json["state_id"],
    cityDetails: json["city_details"] == null ? [] : List<CityDetail>.from(json["city_details"]!.map((x) => CityDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notify": notify,
    "status": status,
    "counrty_id": counrtyId,
    "state_id": stateId,
    "city_details": cityDetails == null ? [] : List<dynamic>.from(cityDetails!.map((x) => x.toJson())),
  };
}

class CityDetail {
  int? id;
  String? cityName;
  int? stateId;
  StateName? stateName;
  CountryName? countryName;
  CountryCode? countryCode;
  int? countryId;

  CityDetail({
    this.id,
    this.cityName,
    this.stateId,
    this.stateName,
    this.countryName,
    this.countryCode,
    this.countryId,
  });

  factory CityDetail.fromJson(Map<String, dynamic> json) => CityDetail(
    id: json["id"],
    cityName: json["city_name"],
    stateId: json["state_id"],
    // stateName: stateNameValues.map[json["state_name"]]!,
    // countryName: countryNameValues.map[json["country_name"]]!,
    // countryCode: countryCodeValues.map[json["country_code"]]!,
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city_name": cityName,
    "state_id": stateId,
    // "state_name": stateNameValues.reverse[stateName],
    // "country_name": countryNameValues.reverse[countryName],
    // "country_code": countryCodeValues.reverse[countryCode],
    "country_id": countryId,
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

enum StateName {
  JOHOR
}

final stateNameValues = EnumValues({
  "JOHOR": StateName.JOHOR
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
