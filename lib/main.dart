import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myamco/App/%20modules/Union%20Update/notification_server.dart';
import 'package:myamco/App/config/app_config.dart';
import 'package:myamco/App/data/provider/api_provider.dart';
import 'package:myamco/App/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App/routes/app_pages.dart';
import 'firebase_options.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("🔔 Background Message: ${message.notification?.title}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.setUpFirebase();
  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase initialized successfully");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Initialize notifications
    // await NotificationService().initialize();
    print("✅ Notification service initialized");
  } catch (e) {
    print("❌ Initialization error: $e");
  }

  AppConfig.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await fetchDeviceId();
    await requestNotificationPermissions();

    // Wait a bit to ensure tokens are saved
    await Future.delayed(const Duration(milliseconds: 500));

    // Register device if user is logged in
    await _registerDeviceIfLoggedIn();
  }

  Future<void> _registerDeviceIfLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt("user_id"); // Get stored user_id

      if (userId != null) {
        print("📲 User logged in, registering device...");
        bool success = await ApiProvider.registerDevice(userId);
        if (success) {
          print("✅ Device registration completed");
        }
      } else {
        print("⚠️ User not logged in, skipping device registration");
      }
    } catch (e) {
      print("❗ Error in device registration check: $e");
    }
  }

  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
    return null;
  }

  // ✅ Changed from void to Future<void>
  Future<void> fetchDeviceId() async {
    String? deviceId = await getDeviceId();
    debugPrint("Device ID: $deviceId");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
      "deviceId",
      "$deviceId",
    );
  }

  Future<void> requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    try {
      if (Platform.isIOS) {
        // Request notification permissions for iOS
        NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          print("✅ Notifications allowed on iOS");
          await Future<void>.delayed(
            const Duration(seconds: 3),
          );

          messaging.getAPNSToken().then((apnsToken) async{
            if (apnsToken != null) {
              print("📲 APNS Token: $apnsToken");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("apnsToken", apnsToken);
            } else {
              print("⚠️ APNS token not yet available. Try again later.");
            }
          }).catchError((e) {
            print("❗️ Error getting APNS token: $e");
          });
        } else {
          print("❌ Notifications denied on iOS");
        }
      } else if (Platform.isAndroid) {
        // Request notification permissions for Android
        NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          print("✅ Notifications allowed on Android");

          // Get the Firebase token (FCM)
          String? fcmToken = await messaging.getToken();
          if (fcmToken != null) {
            print("🔑 FCM Token: $fcmToken");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("fcmToken", fcmToken);
          }
        } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
          print("🔄 Provisional notification permissions granted");
        } else {
          print("❌ Notifications denied on Android");
        }
      }
    } catch (e) {
      print("❗️ Error requesting notification permissions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "AMCO",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,

    );
  }
}