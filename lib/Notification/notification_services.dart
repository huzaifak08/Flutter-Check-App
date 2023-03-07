import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted Permission'); // For Android:
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission'); // For IOS:
    } else {
      debugPrint('Permission Denied');
    }
  }
}
