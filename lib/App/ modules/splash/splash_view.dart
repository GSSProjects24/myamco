import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myamco/App/config/app_images.dart';
import 'package:myamco/App/routes/app_routes.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  dynamic userId;
  dynamic roleId;
  final String title = "MY Amco";

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("member_id");
      roleId = prefs.getString("roleId");
    });
    debugPrint("SplashUserId: $userId");
    debugPrint("SplashRoleId: $roleId");
  }

  callApis() async {
    await getToken();
  }

  @override
  void initState() {
    callApis();

    super.initState();
    _goToNextScreen();

  }


  void _goToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("member_id");

    if (userId != null && userId.isNotEmpty) {
      // User is already logged in → go to dashboard
      Get.offAllNamed(AppRoutes.DASHBOARD);
    } else {
      // User not logged in → go to login
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }


  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, AppRoutes.DASHBOARD);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white,Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset(
            AppImages.logo,
            width: size.width * 0.6, // Adjust width dynamically
          ).animate().fade(duration: 1200.ms), // Fading animation
        ),
      ),
    );
  }
}
