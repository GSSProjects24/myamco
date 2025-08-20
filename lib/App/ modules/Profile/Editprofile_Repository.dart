import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:myamco/App/%20modules/Profile/profile_Repository.dart';
import 'package:myamco/App/%20modules/Profile/profile_controller.dart';
import 'package:myamco/App/data/ModelClass/getDepartmentdetailsModel.dart';
import 'package:myamco/App/data/ModelClass/getDesinationDetailsModel.dart';
import 'package:myamco/App/data/ModelClass/getRaseModel.dart';
import 'package:myamco/App/data/ModelClass/getStatedetailModel.dart';
import 'package:myamco/App/data/ModelClass/getUpdateProfileModel.dart';
import 'package:myamco/App/data/provider/canstant.dart';

import 'profile_view.dart';

class EditprofileRepository {
  final Dio dio = Dio();

  // ======================= Race API =======================
  Future<GetRaseModel> fetchRace() async {
    const url = '${Constants.baseUrl}race_details';
    try {
      var response = await dio.get(url);
      print("URL: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return GetRaseModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load races: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching races: $e");
      throw Exception("Error fetching races: $e");
    }
  }

  // ======================= Designation API =======================
  Future<GetDesignationDetailsModel> fetchDesignation() async {
    const url = '${Constants.baseUrl}designation_details';
    try {
      var response = await dio.get(url);
      print("URL: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return GetDesignationDetailsModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load designations: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching designations: $e");
      throw Exception("Error fetching designations: $e");
    }
  }

  // ======================= Department API =======================
  Future<GetDepartmentDetailsModel> fetchDepartment() async {
    const url = '${Constants.baseUrl}department_details';
    try {
      var response = await dio.get(url);
      print("URL: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return GetDepartmentDetailsModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load departments: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching departments: $e");
      throw Exception("Error fetching departments: $e");
    }
  }

  // ======================= State API =======================
  Future<GetStateDetailsModel> fetchState({required int countryId}) async {
    const url = '${Constants.baseUrl}state_details';
    try {
      var response = await dio.post(
        url,
        data: {"country_id": countryId},
      );

      print("URL: $url");
      print("POST Data: {country_id: $countryId}");
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return GetStateDetailsModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load states: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching states: $e");
      throw Exception("Error fetching states: $e");
    }
  }

  // ======================= City API =======================
  Future<dynamic> fetchCity({required int countryId, required int stateId}) async {
    const url = '${Constants.baseUrl}city_details';
    try {
      var response = await dio.post(
        url,
        data: {
          "country_id": countryId,
          "state_id": stateId,
        },
      );

      print("URL: $url");
      print("POST Data: {country_id: $countryId, state_id: $stateId}");
      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return response.data; // you can parse into your City model here
      } else {
        throw Exception("Failed to load cities: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching cities: $e");
      throw Exception("Error fetching cities: $e");
    }
  }

  final ProfileController controller = Get.put(ProfileController(repository: ProfileRepository()));
  Future<GetUpdateprofileModel> updateProfile(Map<String, dynamic> data) async {
    const url = "${Constants.baseUrl}member_profile_update";

    try {
      print("=== PROFILE UPDATE REQUEST ===");
      print("POST URL: $url");
      print("POST Data: ${jsonEncode(data)}");

      final response = await dio.post(
        url,
        data: data, // pass the Map directly
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );


      print("Status Code: ${response.statusCode}");
      print("Response Data: ${jsonEncode(response.data)}");

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Profile updated successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
        controller.getProfile();

        // Get.off(() => ProfilePage());
        return GetUpdateprofileModel.fromJson(response.data);

      }
      else {
        throw Exception("Failed to update profile: ${response.statusCode}");
      }
    } catch (e) {
      print("Error updating profile: $e");
      throw Exception("Error updating profile: $e");
    }
  }


}
