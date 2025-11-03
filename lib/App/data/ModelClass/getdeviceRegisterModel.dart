// To parse this JSON data, do
//
//     final deviceRegisterModel = deviceRegisterModelFromJson(jsonString);

import 'dart:convert';

DeviceRegisterModel deviceRegisterModelFromJson(String str) => DeviceRegisterModel.fromJson(json.decode(str));

String deviceRegisterModelToJson(DeviceRegisterModel data) => json.encode(data.toJson());

class DeviceRegisterModel {
  bool? success;
  String? message;
  Data? data;

  DeviceRegisterModel({
    this.success,
    this.message,
    this.data,
  });

  factory DeviceRegisterModel.fromJson(Map<String, dynamic> json) => DeviceRegisterModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? userId;
  String? deviceId;
  String? fcmTokenId;

  Data({
    this.userId,
    this.deviceId,
    this.fcmTokenId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    deviceId: json["device_id"],
    fcmTokenId: json["fcm_token_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "device_id": deviceId,
    "fcm_token_id": fcmTokenId,
  };
}
