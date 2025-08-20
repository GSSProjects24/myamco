import 'dart:convert';

import 'package:get/get.dart';
import 'package:myamco/App/data/ModelClass/getCityDetailModel.dart';
import 'package:myamco/App/data/ModelClass/getDepartmentdetailsModel.dart';
import 'package:myamco/App/data/ModelClass/getDesinationDetailsModel.dart';
import 'package:myamco/App/data/ModelClass/getRaseModel.dart';
import 'package:myamco/App/data/ModelClass/getStatedetailModel.dart';
import 'package:myamco/App/data/ModelClass/profileModel.dart';
import 'Editprofile_Repository.dart';

class EditprofileController extends GetxController {
  final EditprofileRepository repository;

  EditprofileController({required this.repository});

  // Observable lists & selected items
  var raceDetails = <RaceDetail>[].obs;
  var selectedRaceDetail = Rxn<RaceDetail>();

  var designationDetails = <DesignationDetail>[].obs;
  var selectedDesignationDetail = Rxn<DesignationDetail>();

  var departmentDetails = <DepartmentDetail>[].obs;
  var selectedDepartmentDetail = Rxn<DepartmentDetail>();

  var statedetailsModel = <StateDetail>[].obs;
  var selectedStateDetail = Rxn<StateDetail>();

  var cityDetailsModel = <CityDetail>[].obs;
  var selectedCityDetail = Rxn<CityDetail>();

  // Other fields
  var selectedGender = ''.obs;
  var selectedMaritalStatus = ''.obs;

  RxBool isLoading = false.obs;
  ProfileModel? profile;
  String error = "";

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  /// Fetch all dropdown data
  Future<void> fetchAllData() async {
    await Future.wait([
      fetchRaces(),
      fetchDesignations(),
      fetchDepartments(),
      fetchStates(),
    ]);
    fetchCities(); // cities depend on selected state
  }

  /// Fetch Races
  Future<void> fetchRaces() async {
    try {
      print("Fetching Races...");
      final result = await repository.fetchRace();
      raceDetails.assignAll(result.data?.raceDetails ?? []);
      print("Fetched Races: ${raceDetails.map((e) => e.raceName).toList()}");
    } catch (e) {
      error = e.toString();
      print("Error fetching races: $error");
    }
  }

  /// Fetch Designations
  Future<void> fetchDesignations() async {
    try {
      print("Fetching Designations...");
      final result = await repository.fetchDesignation();
      designationDetails.assignAll(result.data?.designationDetails ?? []);
      print("Fetched Designations: ${designationDetails.map((e) => e.designationName).toList()}");
    } catch (e) {
      error = e.toString();
      print("Error fetching designations: $error");
    }
  }

  /// Fetch Departments
  Future<void> fetchDepartments() async {
    try {
      print("Fetching Departments...");
      final result = await repository.fetchDepartment();
      departmentDetails.assignAll(result.data?.departmentDetails ?? []);
      print("Fetched Departments: ${departmentDetails.map((e) => e.departmentName).toList()}");
    } catch (e) {
      error = e.toString();
      print("Error fetching departments: $error");
    }
  }

  /// Fetch States
  Future<void> fetchStates() async {
    try {
      isLoading.value = true;
      print("Fetching States for countryId=130...");
      final result = await repository.fetchState(countryId: 130);
      statedetailsModel.assignAll(result.data?.stateDetails ?? []);
      print("Fetched States: ${statedetailsModel.map((s) => s.stateName).toList()}");
    } catch (e) {
      error = e.toString();
      print("Error fetching states: $error");
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch Cities for selected state
  Future<void> fetchCities() async {
    if (selectedStateDetail.value == null) {
      cityDetailsModel.clear();
      selectedCityDetail.value = null;
      return;
    }

    try {
      isLoading.value = true;
      print("Fetching Cities for stateId=${selectedStateDetail.value!.stateId}...");
      print("URL: http://amco.graspsoftwaresolutions.com/city_details");
      print("POST Data: {country_id: 130, state_id: ${selectedStateDetail.value!.stateId}}");

      final response = await repository.fetchCity(
        countryId: 130,
        stateId: selectedStateDetail.value!.stateId!,
      );

      print("Response Data: $response");

      // Use safe null handling
      final cityModel = GetcCityDetailsModel.fromJson(response);
      final cities = cityModel.data?.cityDetails ?? [];

      cityDetailsModel.assignAll(cities);

      // Preselect city if profile has cityName
      final memberCity = profile?.data?.memberDetails?.firstOrNull?.cityName;
      if (memberCity != null) {
        selectedCityDetail.value =
            cityDetailsModel.firstWhereOrNull((city) => city.cityName == memberCity);
        print("Preselected City: ${selectedCityDetail.value?.cityName}");
      } else {
        selectedCityDetail.value = null; // ensure safe default
      }

    } catch (e, st) {
      print("Error fetching cities: $e");
      print(st);
    } finally {
      isLoading.value = false;
    }
  }


  // Call this from button
  Future<void> submitProfileUpdate(Map<String, dynamic> data) async {
    try {
      await repository.updateProfile(data);

    } catch (e) {
      print("Error in submitProfileUpdate: $e");
    }
  }




  // Setters
  void setSelectedRace(RaceDetail race) => selectedRaceDetail.value = race;
  void setSelectedDesignation(DesignationDetail desig) => selectedDesignationDetail.value = desig;
  void setSelectedDepartment(DepartmentDetail dept) => selectedDepartmentDetail.value = dept;
  void setSelectedCity(CityDetail city) => selectedCityDetail.value = city;
}
