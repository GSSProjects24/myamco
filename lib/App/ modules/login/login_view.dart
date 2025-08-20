// lib/App/modules/login/login_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_colors.dart';
import '../../config/app_images.dart';
import '../../config/app_sizes.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 32),
                _buildTitle(),
                const SizedBox(height: 8),
                _buildSubtitle(),
                const SizedBox(height: 32),

                // Email field
                _buildTextField(
                  icon: Icons.email,
                  hint: "PF Number",
                  onChanged: (val) => controller.email.value = val,
                ),
                const SizedBox(height: 16),

                // Password field
                Obx(() => TextField(
                  obscureText: !controller.isPasswordVisible.value,
                  onChanged: (val) => controller.password.value = val,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: AppColors.primary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.primary,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    hintText: "Password",
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )),
                const SizedBox(height: 12),

                // Login Button
                Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                    controller.isLoading.value ? null : controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: AppSizes.fontMedium,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 24),

                Text(
                  "App Version 1.0.0",
                  style: TextStyle(
                    fontSize: AppSizes.fontSmall,
                    color: AppColors.text.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hint,
    bool obscure = false,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      obscureText: obscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primary),
        hintText: hint,
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildLogo() => Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(AppImages.logo, fit: BoxFit.cover),
    ),
  );

  Widget _buildTitle() => Text(
    "Association of Maybank Class One Officers".toUpperCase(),
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: AppSizes.fontMedium,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    ),
  );

  Widget _buildSubtitle() => Text(
    "Login to continue",
    style: TextStyle(
      fontSize: AppSizes.fontMedium,
      color: AppColors.text.withOpacity(0.7),
    ),
  );
}
