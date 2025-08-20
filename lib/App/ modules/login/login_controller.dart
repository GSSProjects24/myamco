// lib/App/modules/login/login_controller.dart
import 'dart:developer';

import 'package:get/get.dart';
import 'package:myamco/App/%20modules/login/loginRepository.dart';

import 'package:myamco/App/data/ModelClass/LoginModel.dart';
import 'package:myamco/App/data/ModelClass/error_response.dart';
import 'package:myamco/App/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final LoginRepository _repo = LoginRepository();

  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  /// ✅ Moved here so UI can call it
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
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

        // ✅ Handle invalid login cases
        if (loginModel.data?.status?.toLowerCase() == "invalid credentials" ||
            loginModel.data?.status?.toLowerCase() == "invalid email or memberno") {
          Get.snackbar("Oops", "invalid UserName And Password");
          return;
        }

        // ✅ Successful login
        if (loginModel.success == true && (loginModel.data?.memberId ?? "").isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("member_id", loginModel.data!.memberId!);
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

          print("Stored Member ID: $storedId");
          print("Stored Member Name: $storedName");
          print("Stored Member No: $storedMemberNo");

          Get.offAllNamed(AppRoutes.DASHBOARD);
        }
      }


      else {
        var loginModel = LogingModel(
          errorResponse: ErrorResponse(
            message:
            "Login failed: ${response.data['errorMsg'] ?? 'Unknown error'}",
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
