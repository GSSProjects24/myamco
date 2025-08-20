import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myamco/App/config/app_config.dart';
import 'package:myamco/App/reusable/common_appbar.dart';
import 'package:myamco/App/routes/app_routes.dart';
import '../../config/app_colors.dart';
import '../../config/app_images.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:CommonAppBar(
        title: "AMCO - DASHBOARD",
        backgroundColor: AppColors.white,
        showLogout: true,
        onLogout: controller.logout,
        leadingImagePath: AppImages.logo, // Your logo/image
      ),

      body: Column(
        children: [
          // Banner Image
          Image.asset(
            AppImages.banner, // Replace with your banner image
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),

          // Profile Details
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.deepOrange),
                    const SizedBox(width: 8),
                    Obx(() => Text(
                      controller.memberName.value.isNotEmpty
                          ? controller.memberName.value
                          : "Loading...",
                      style: const TextStyle(color: AppColors.primary),
                    )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.badge, color: Colors.deepOrange),
                    const SizedBox(width: 8),
                    Obx(() => Text(
                      controller.memberNo.value.isNotEmpty
                          ? controller.memberNo.value
                          : "Loading...",
                      style: const TextStyle(color: AppColors.primary),
                    )),
                  ],
                ),
                const SizedBox(height: 16),

                // Two Grid Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dashboardCard(
                      image: AppImages.user,
                      label: 'USER PROFILE',
                      onTap: () {Get.toNamed(AppRoutes.ProfilePage);},
                    ),
                    _dashboardCard(
                      image:AppImages.Announcement,
                      label: 'UNION UPDATES',
                      onTap: () {Get.toNamed(AppRoutes.UnionUpdatePage);},
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboardCard({
    required String image,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(image, height: 60),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
