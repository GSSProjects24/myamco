// lib/App/modules/dashboard/dashboard_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  var memberId = ''.obs;
  var memberName = ''.obs; // Optional if you want to store name too
  var memberNo = ''.obs; // Optional if you want to store name too

  @override
  void onInit() {
    super.onInit();
    loadMemberData();
  }

  Future<void> loadMemberData() async {
    final prefs = await SharedPreferences.getInstance();
    memberId.value = prefs.getString('member_id') ?? '';
    memberNo.value = prefs.getString('member_no') ?? '';
    // If you store name in login, you can retrieve it here too
    memberName.value = prefs.getString('member_name') ?? '';
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Navigate to login
    Get.offAllNamed('/login'); // Replace with your login route
  }
}
