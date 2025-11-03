// lib/App/data/provider/api_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ Add this import for toast messages
import 'package:myamco/App/data/provider/canstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  final Dio _dio;

  ApiProvider._internal()
      : _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 10000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) => status != null && status < 500,
    ),
  ) {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  static final ApiProvider _instance = ApiProvider._internal();

  static ApiProvider get instance => _instance;

  Dio get client => _dio;

  /// 🔥 Register Device with User ID
  static Future<bool> registerDevice(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final deviceId = prefs.getString("deviceId");
      final fcmToken = prefs.getString("fcmToken");
      final apnsToken = prefs.getString("apnsToken");

      // Use FCM token for Android, APNS token for iOS (if available)
      final tokenToSend = fcmToken ?? apnsToken;

      if (deviceId == null || tokenToSend == null) {
        print("⚠️ Device ID or Token is null");
        print("Device ID: $deviceId, Token: $tokenToSend");

        // ✅ Toast for missing data
        Get.snackbar(
          "Warning",
          "Unable to register device: Missing device information",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return false;
      }

      final body = {
        "user_id": userId, // ✅ FIXED: Removed quotes (was "userId" string)
        "device_id": deviceId,
        "fcm_token_id": tokenToSend,
      };

      print("📡 Registering Device: $body");

      final response = await _instance._dio.post(
        "register-device",
        data: body,
      );

      if (response.statusCode == 200) {
        print("✅ Device registered successfully: ${response.data}");

        // Parse the response
        if (response.data != null && response.data['success'] == true) {
          await prefs.setBool("deviceRegistered", true);

          // ✅ Success Toast
          Get.snackbar(
            "Success",
            "Device registered successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Get.theme.colorScheme.primary.withOpacity(0.8),
            colorText: Get.theme.colorScheme.onPrimary,
            duration: const Duration(seconds: 2),
            icon: const Icon(Icons.check_circle, color: Colors.white),
          );

          return true;
        } else {
          print("❌ Registration failed: ${response.data?['message']}");

          // ✅ Failure Toast
          Get.snackbar(
            "Error",
            "Device registration failed: ${response.data?['message'] ?? 'Unknown error'}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );

          return false;
        }
      } else {
        print("❌ Failed to register device: ${response.statusCode}");

        // ✅ HTTP Error Toast
        Get.snackbar(
          "Error",
          "Failed to register device (Status: ${response.statusCode})",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        return false;
      }
    } catch (e) {
      print("❗ Error registering device: $e");

      // ✅ Exception Toast
      Get.snackbar(
        "Error",
        "Device registration error: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      return false;
    }
  }

  /// 🔥 Update FCM Token and Device ID to your server
  static Future<void> updateFcmToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final fcmToken = prefs.getString("fcmToken");
      final deviceId = prefs.getString("deviceId");

      if (fcmToken == null || deviceId == null) {
        print("⚠️ FCM Token or Device ID is null");
        return;
      }

      final body = {
        "fcm_token": fcmToken,
        "device_id": deviceId,
      };

      print("📡 Sending FCM Update: $body");

      final response = await _instance._dio.post(
        "fcm_update",
        data: body,
      );

      if (response.statusCode == 200) {
        print("✅ FCM Token updated successfully: ${response.data}");
      } else {
        print("❌ Failed to update FCM Token: ${response.statusCode}");
      }
    } catch (e) {
      print("❗ Error updating FCM Token: $e");
    }
  }
}