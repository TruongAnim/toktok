import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toktok/Auth/login_navigator.dart';
import 'package:toktok/Routes/routes.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._();
  static FirebaseMessagingService get instance => _instance;
  FirebaseMessagingService._();
  final FirebaseMessaging fmInstance = FirebaseMessaging.instance;

  final String _SEND_NOTIFY_URL = "https://fcm.googleapis.com/fcm/send";
  final String _SERVER_KEY =
      "AAAAd-cWwgA:APA91bFIq_two7bpeXZPdv1md7r42-7s1TiJxaWfcatDh1dQE_uZbJhvSPH3JGHAG3mn1CXvJHNvoqyE8CWS-9F0wcIBq6l6jpRF8qess244PFxBVYhHrQTBYtTumR5IKiNzP9hr2cG7";
  final Dio _dio = Dio();

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for high importance channel',
      importance: Importance.defaultImportance);
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<String?> getFmToken() async {
    return fmInstance.getToken();
  }

  Future<void> initNotification() async {
    await fmInstance.requestPermission();
    final fmToken = await getFmToken();
    print('fmToken $fmToken');
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    initPushNotification();
    initLocalNotification();
  }

  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(android: android);
    await _localNotifications.initialize(
      setting,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
        handleMessage(message);
        print('onDidReceiveNotificationResponse');
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        print('onDidReceiveBackgroundNotificationResponse');
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> onBackgroundMessage(RemoteMessage message) async {
    // call when recieve notification
    print('onBackgroundMessage');
    print(message.notification?.title);
    print(message.notification?.body);
    print(message.data);
  }

  void handleMessage(RemoteMessage? message) {
    // call when click to notification
    print('handleMessage');
    print(message?.notification?.title);
    print(message?.notification?.body);
    print(message?.data);
    navigatorKey.currentState?.pushNamed(PageRoutes.bottomNavigation,
        arguments: {'tab': 'notification', 'message': message});
  }

  void handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              _androidChannel.id, _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher'),
        ),
        payload: jsonEncode(message.toMap()),
      );
    }
  }

  // void sendNotification(NotificationRequest notification) async {
  void sendNotification() async {
    Map<String, dynamic> headers = await _getHeader();
    await _dio.post(
      _SEND_NOTIFY_URL,
      options: Options(headers: headers),
      data: {
        "to":
            'ffmwKpkWSoeo_aW6v3kFYr:APA91bF8KtsjGZL_kh3s1roiCEDg9Cr_MOtCWnosm2v_bkKA32H9q5wwU2pkOHzWDo0IYDvmCQqcYGRszBHsBW8nqph-V7prqkeqmaGzDGr8TX48j1ahuATL7kZ-HDJmrxxMb-sUXGFi',
        "notification": {
          "title": 'notification.title',
          "body": 'notification.body',
        },
        // "data": {
        //   "adminDocId": notification.adminDocId,
        // },
      },
    );
  }

  Future<Map<String, dynamic>> _getHeader() async {
    // String token = await AppSecureStorage.getTokenFirebase();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_SERVER_KEY",
    };
  }
}
