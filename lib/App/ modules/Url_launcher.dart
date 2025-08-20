import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  static invokeUrl(
      url,
      ) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {}
  }
}