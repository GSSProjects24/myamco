import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_sizes.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogout;
  final VoidCallback? onLogout;

  final String? leadingImagePath;
  final double leadingImageSize;

  final bool showBackButton; // 🔹 New: back button toggle
  final VoidCallback? onBack; // 🔹 New: custom back action

  final Color backgroundColor;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showLogout = false,
    this.onLogout,
    this.leadingImagePath,
    this.leadingImageSize = 36,
    this.backgroundColor = AppColors.white,
    this.showBackButton = false, // default off
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false, // prevent default behavior

      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: onBack ?? () => Navigator.pop(context),
      )
          : (leadingImagePath != null
          ? Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Image.asset(
          leadingImagePath!,
          height: leadingImageSize,
          width: leadingImageSize,
        ),
      )
          : null),

      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppSizes.fontMedium,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),

      actions: [
        if (showLogout)
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: AppColors.primary),
            onPressed: onLogout,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
