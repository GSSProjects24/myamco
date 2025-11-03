import 'dart:developer';

import 'package:get/get.dart';
import 'package:myamco/App/%20modules/login/loginRepository.dart';
import 'package:myamco/App/data/ModelClass/LoginModel.dart';
import 'package:myamco/App/data/ModelClass/error_response.dart';
import 'package:myamco/App/data/provider/api_provider.dart';
import 'package:myamco/App/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginController extends GetxController {
  final LoginRepository _repo = LoginRepository();

  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // ✅ NEW: Ensure FCM token is available before registering
  Future<String?> ensureFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("fcmToken");

    if (token == null || token.isEmpty) {
      print("⚠️ Token not in SharedPreferences, fetching from Firebase...");
      token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        await prefs.setString("fcmToken", token);
        print("✅ FCM Token retrieved and saved: $token");
      } else {
        print("❌ Unable to get FCM token");
      }
    } else {
      print("✅ FCM Token found in SharedPreferences");
    }

    return token;
  }

  Future<void> handleLoginSuccess(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", userId);
    await prefs.setString("user_id", userId.toString()); // Keep string version too

    // ✅ Ensure token is available before registering
    String? token = await ensureFCMToken();

    if (token != null) {
      // Register device
      bool registered = await ApiProvider.registerDevice(userId);
      if (registered) {
        print("✅ Device registered after login");
      } else {
        print("⚠️ Device registration failed, will retry on next app launch");
      }
    } else {
      print("⚠️ FCM token not available, device registration skipped");
    }

    // Navigate to dashboard
    Get.offAllNamed(AppRoutes.DASHBOARD);
  }

  void login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar("Oops", "Please enter email and password");
      return;
    }

    isLoading.value = true;

    try {
      var response = await _repo.login(email.value, password.value);

      if (response.statusCode == 200) {
        var loginModel = LogingModel.fromJson(response.data);

        log("Parsed loginModel: $loginModel");
        log("Success: ${loginModel.success}");
        log("Status: ${loginModel.data?.status}");
        log("Member ID: ${loginModel.data?.memberId}");
        log("User ID: ${loginModel.data?.userId}");

        // Handle invalid login cases
        if (loginModel.data?.status?.toLowerCase() == "invalid credentials" ||
            loginModel.data?.status?.toLowerCase() == "invalid email or memberno") {
          Get.snackbar("Oops", "Invalid UserName And Password");
          return;
        }

        // Successful login
        if (loginModel.success == true &&
            (loginModel.data?.memberId ?? "").isNotEmpty &&
            (loginModel.data?.userId ?? "").isNotEmpty) {

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("member_id", loginModel.data!.memberId!);
          await prefs.setString("user_id", loginModel.data!.userId!);
          await prefs.setString(
              "member_name", loginModel.data!.memberDetails!.first.memberName ?? ""
          );
          await prefs.setString(
              "member_no", loginModel.data!.memberDetails!.first.memberNo ?? ""
          );

          print(response.data);

          String? storedId = prefs.getString("member_id");
          String? storedName = prefs.getString("member_name");
          String? storedMemberNo = prefs.getString("member_no");
          String? storedUserId = prefs.getString("user_id");

          print("Stored Member ID: $storedId");
          print("Stored Member Name: $storedName");
          print("Stored Member No: $storedMemberNo");
          print("Stored User ID: $storedUserId");

          // Convert userId to int and register device
          try {
            int userId = int.parse(loginModel.data!.userId!);
            await handleLoginSuccess(userId);
          } catch (e) {
            print("❌ Error converting user_id to int: $e");
            Get.offAllNamed(AppRoutes.DASHBOARD);
          }
        } else {
          Get.snackbar("Oops", "Login data incomplete");
        }
      } else {
        var loginModel = LogingModel(
          errorResponse: ErrorResponse(
            message: "Login failed: ${response.data['errorMsg'] ?? 'Unknown error'}",
          ),
        );
        Get.snackbar("Oops", loginModel.errorResponse?.message ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Oops", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}