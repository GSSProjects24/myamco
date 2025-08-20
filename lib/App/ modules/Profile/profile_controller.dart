import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myamco/App/%20modules/Profile/profile_Repository.dart';
import 'package:myamco/App/data/ModelClass/profileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;

  ProfileController({required this.repository});

  var isLoading = false.obs;
  var profileData = Rxn<ProfileModel>();

  @override
  void onInit() {
    super.onInit();
    getProfile();


  }

  Future<void> getProfile() async {
    try {
        SharedPreferences prefs =await SharedPreferences.getInstance();
        final memberId = prefs.getString('member_id') ?? '';
        debugPrint("Stored Member ID in ProfileController: $memberId");


      isLoading.value = true;
      final data = await repository.fetchProfile(memberId);
      profileData.value = data;

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
