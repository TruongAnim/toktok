import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toktok/Auth/login_navigator.dart';
import 'package:toktok/Routes/routes.dart';
import 'package:toktok/models/notif.dart';
import 'package:toktok/services/notification_service.dart';
import 'package:toktok/services/user_service.dart';

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
    print('initPushNotification');
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
        print('onDidReceiveNotificationResponse');
        final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
        handleMessage(message);
      },
      onDidReceiveBackgroundNotificationResponse: (payload) {
        print('onDidReceiveBackgroundNotificationResponse');
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> onBackgroundMessage(RemoteMessage message) async {
    // call when recieve notification in background
    print('onBackgroundMessage');
    final notification = message.notification;
    if (notification != null) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    }
  }

  void handleForegroundMessage(RemoteMessage message) {
    // call when recieve notification in foreground
    print('handleForegroundMessage');
    final notification = message.notification;
    if (notification != null) {
      // firebase do not create notification
      // need to show custom notification
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

  void handleMessage(RemoteMessage? message) {
    // call when click to notification
    print('handleMessage');
    if (message?.notification != null) {
      print(message?.notification?.title);
      print(message?.notification?.body);
      print(message?.data);
      navigatorKey.currentState?.pushNamed(PageRoutes.notification,
          arguments: {'tab': 'notification', 'data': message?.data});
    }
  }

  void sendNotification(Notif notification) async {
    if (notification.senderId == notification.uid) {
      return;
    }
    String? fmToken = await UserService.instance.getFmToken(notification.uid);
    if (fmToken != null && fmToken.isNotEmpty) {
      Map<String, dynamic> headers = await _getHeader();
      await _dio.post(
        _SEND_NOTIFY_URL,
        options: Options(headers: headers),
        data: {
          "to": fmToken,
          "notification": {
            "title": notification.title,
            "body": notification.desc,
          },
          "data": notification.toJson(),
        },
      );
    }
    NotificationService.instance.addNotification(notification);
  }

  Future<Map<String, dynamic>> _getHeader() async {
    // String token = await AppSecureStorage.getTokenFirebase();
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_SERVER_KEY",
    };
  }
}
