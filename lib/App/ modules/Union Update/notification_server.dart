import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myamco/firebase_options.dart';
import 'package:myamco/main.dart';

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
FirebaseMessaging messaging = FirebaseMessaging.instance;

class NotificationService {
  ///handle messages that pushed when app is in background
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    handleMessage(message.toMap());
  }

  static setUpFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("com.app.myamco");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
          'com.app.myamco', // id
          'myamco_title',
          description: "myamco_description",
          importance: Importance.high,
          enableLights: true,
          enableVibration: true,
          showBadge: true,
          playSound: true);

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel!);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    listenAndHandlePushNotifications();
  }

  static Future<dynamic> onSelectNotification(payload) async {
    Map<String, dynamic> action = jsonDecode(payload);
    handleMessage(action);
  }

  static Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => handleMessage(value != null ? value.data : Map()));
  }

  ///set up firebase to receive and handle push notifications.
  ///Step 1: initialize settings for android & ios.
  ///Step 2: initialize flutterLocalNotificationsPlugin especially for android.
  ///Step 3: [handleMessage] - call any where you want.
  ///OnMessage -> Receive payload when app is in foreground.
  ///onMessageOpenedApp -> Receive payload when app resumes.
  static void listenAndHandlePushNotifications() async {
    WidgetsFlutterBinding.ensureInitialized();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    setupInteractedMessage();
    FirebaseMessaging.onMessage.listen((message) async {
      notificationNotifier.notify();
      debugPrint("Push notification: ${message.data}");
      debugPrint(
          "📩 Foreground message received: ${message.notification?.title}");
      debugPrint("📩 Body: ${message.notification?.body}");
      RemoteNotification? notification = message.notification;
      String? imageUrl = message.data['image_url'] ??
          message.data['image']; // Check for an image key
      debugPrint(
          "📷 Image URL from push notificationbeforechecknull: $imageUrl");
      if (imageUrl != null && imageUrl.isNotEmpty) {
        debugPrint("📷 Image URL from push notification: $imageUrl");
      }
      if (notification != null && !kIsWeb) {
        String action = jsonEncode(message.data);
        try {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel?.id ?? "",
                  channel?.name ?? "",
                  channelDescription: channel?.description,
                  priority: Priority.high,
                  importance: Importance.max,
                  setAsGroupSummary: true,
                  styleInformation: const DefaultStyleInformation(true, true),
                  largeIcon: const DrawableResourceAndroidBitmap(
                      '@mipmap/launcher_icon'),
                  channelShowBadge: true,
                  autoCancel: true,
                  icon: '@mipmap/launcher_icon',
                ),
              ),
              payload: action);
        } catch (e, stacktrace) {
          debugPrintStack(stackTrace: stacktrace);
        }
      }
    });
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => handleMessage(message.data));
  }

  ///handle message from push notifications when app is in foreground
  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      debugPrint('notification payload: $payload');
      handleMessage(json.decode(payload));
    }
  }

  ///get payload from push notifications and handle the business logic inside
  static handleMessage(Map<String, dynamic> data) async {
    debugPrint("Onclick Data: $data");
    notificationNotifier.notify();
    if (navigatorKey.currentState == null) {
      debugPrint("Navigator key is null, unable to navigate.");
      return;
    }

    // if (data.containsKey('route')) {
    //   // Navigate using pushNamed if the route is provided
    //   String routeName = data['route'];
    //   Map<String, dynamic>? arguments = data['arguments']; // Optional arguments
    //   navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
    // } else {
    // Navigate using push based on data values
    if (data.containsKey('image_url')) {
      debugPrint("📷 Image URL: ${data['image_url']}");
    }

  }

  static Future<String?> getFbToken() async {
    String? fireBaseToken = await FirebaseMessaging.instance.getToken();
    debugPrint("fireBaseNotificationServiceToken $fireBaseToken");
    return fireBaseToken;
  }
}

class NotificationType {
  static const assign = "ASSIGN";
  static const add = "ADD";
  static const comment = "COMMENT";
}


class NotificationNotifier extends ValueNotifier<bool> {
  NotificationNotifier() : super(false);

  void notify() {
    value = !value; // toggling the value forces rebuild
  }
}

final notificationNotifier = NotificationNotifier();