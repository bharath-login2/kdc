import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kdc_chitty_mainnew/screens/splashScreen.dart';

import '../core/common.dart';
import '../key.dart';
import 'leadManagement/leadDetails.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool sts = true;
  String? token;
  bool? editLead;
  bool? deleteLead;
  bool? cloudCall;
  String? navigation;
  String? detailId;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initLocalNotifications();
    _setupFirebaseMessaging();
  }

  void _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      } else if (message.data.isNotEmpty) {
        // Handle data-only messages
        String? title = message.data['title'];
        String? body = message.data['message'] ?? message.data['body'];
        if (title != null || body != null) {
          flutterLocalNotificationsPlugin.show(
            message.hashCode,
            title,
            body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'High Importance Notifications',
                importance: Importance.max,
                priority: Priority.high,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      token = await Common.getSharedPref("token");
      setState(() {
        sts = false;
        detailId = message.data['detail_id'] ?? message.data['detailId'];
        editLead =
            message.data['edit_lead'] == 'true' ||
            message.data['editLead'] == 'true';
        deleteLead =
            message.data['delete_lead'] == 'true' ||
            message.data['deleteLead'] == 'true';
        cloudCall =
            message.data['cloud_call'] == 'true' ||
            message.data['cloudcall'] == 'true';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NoomiKeys.navKey,
      home: sts == true
          ? const SplashScreen()
          : LeadDetails(
              token!,
              editLead!,
              deleteLead!,
              cloudCall!,
              detailId!,
              pageName: 'notification',
            ),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the background message here (if needed)
  print("onMessageOpenedApp: $message");
}
