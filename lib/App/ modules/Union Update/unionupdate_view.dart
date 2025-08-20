// lib/pages/union_update_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myamco/App/config/app_colors.dart';

import 'union_Repostory.dart';
import 'union_controller.dart';
import 'unionupadate_details.dart';

class UnionUpdatePage extends StatelessWidget {
  UnionUpdatePage({super.key});

  final UnionController controller =
  Get.put(UnionController(repository: UnionRepository()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      ),
        title: const Text(
          'Union Updates',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.unionUpdates.isEmpty) {
          return const Center(child: Text("No updates available"));
        }

        // union_update_page.dart
        return ListView.builder(
          itemCount: controller.unionUpdates.length,
          itemBuilder: (context, index) {
            final update = controller.unionUpdates[index];

            // Combine filePath + fileUpload
            final imageUrl = (update.fileUpload != null && update.fileUpload!.isNotEmpty)
                ? "${controller.filePath.value}${update.fileUpload}"
                : null;

            return ListTile(
              leading: imageUrl != null
                  ? Image.network(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported);
                },
              )
                  : const Icon(Icons.image),
              title: Text(
                update.title ?? "",
                maxLines: 1,           // Minimum 1 line
                overflow: TextOverflow.ellipsis, // Add ellipsis if too long
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                update.description ?? "",
                maxLines: 1,           // Minimum 1 line
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UnionUpdateDetailPage(
                      title: update.title ?? "",
                      description: update.description ?? "",
                      imageUrl: imageUrl ?? "",
                    ),
                  ),
                );
              },
            );

          },
        );

      }),
    );
  }
}
