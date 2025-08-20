import 'package:flutter/material.dart';
import 'package:myamco/App/%20modules/Url_launcher.dart';
import 'package:myamco/App/config/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class UnionUpdateDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const UnionUpdateDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });



  @override
  Widget build(BuildContext context) {
    final String formattedDate =
    DateFormat('dd MMM yyyy – hh:mm a').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Update Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullScreenImagePage(imageUrl: imageUrl),
                      ),
                    );
                  },
                  child: Image.network(
                    imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 100,
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                if (description != null &&
                    Uri.tryParse(description)?.hasAbsolutePath == true) {
                  LaunchUrl.invokeUrl(description!);
                }
              },
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Full screen image view page
class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImagePage({super.key, required this.imageUrl});

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  color: Colors.white,
                  size: 100,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
