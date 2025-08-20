import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myamco/App/config/app_config.dart';
import 'package:myamco/App/routes/app_routes.dart';
import 'App/routes/app_pages.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.initialize(); // optional config
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: "AMCO",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
    );
  }
}
