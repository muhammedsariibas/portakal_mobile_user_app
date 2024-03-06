import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/models/NotificationModel.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/models/NotificationType.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/stores/NotificationStore.dart';
import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/userapp/services/NotificationService.dart';
import 'package:portakal_mobile_user_app/firebase_options.dart';

Future<void> _firebasemessagingbackgroundhandler(RemoteMessage message) async {
  NotificationModel notificationModel = NotificationModel(
      "${message.notification?.body}",
      "${message.notification?.title}",
      DateTime.now().millisecondsSinceEpoch,
      "General");

  notificationStore.add(notificationModel);
}

class FirebaseNotificationservice {
  late final FirebaseMessaging messaging;
  NotificationService notificationService = NotificationService();

  void settingNotification() async {
    await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  void connectNotification() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    messaging = FirebaseMessaging.instance;
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );
    settingNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("------------");
      NotificationModel notificationModel = NotificationModel(
          "${event.notification?.body}",
          "${event.notification?.title}",
          DateTime.now().millisecondsSinceEpoch,
          "General");
      notificationStore.add(notificationModel);
      notificationService.makeSnackbar(
          "Bildirim", "bildiirm geldi", Color(0xFFFFFF));
    });

    if (FirebaseMessaging != null) {
      FirebaseMessaging.onBackgroundMessage(
          _firebasemessagingbackgroundhandler);
    }

    // send token to portakal

    messaging
        .getToken()
        .then((value) => log("Token : $value", name: "FCM TOKEN"));
  }
}
