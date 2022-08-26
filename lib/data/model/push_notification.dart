import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import '../../helper/app_constant.dart';
import '../../helper/user_constant.dart';
import '../../main.dart';
import '../../ui/bloc/send_fcm_token.dart';
import '../api/api_method.dart';
import '../api/api_urls.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

firebaseGetToken() async {}
Future<void> initFirebase() async {
  print("entered");
  await Firebase.initializeApp();
  firebaseMessaging = FirebaseMessaging.instance;

  firebaseMessaging?.subscribeToTopic('DawimTopic');

  NotificationSettings settings = await firebaseMessaging!.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

//Background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Background Handling a background message: ${message.messageId}");
}

//-------------------------------------  locale notification  --------------------------------

initLocaleNotification() {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  ); //onSelectNotification: onSelectNotification

  firebaseMessaging?.getToken().then((String? token) {
    print("Firebase token:: $token");
    if (null != token) {
      sm.setValue(UserConstant.FCM_TOKEN, token);
    }
  });

  //Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Foreground Message data: ${message.data}');
    if (message.notification != null) {
      print(
          'Foreground Message also contained a notification: ${message.notification?.title} - ${message.notification?.body}');
      await _displayLocalNotification(
          message.notification?.title ?? "", message.notification?.body ?? "");
    }
  });
}

Future<void> _displayLocalNotification(String title, String body) async {
  var androidPlatformChannelSpecifics =
      const AndroidNotificationDetails('channel_ID', 'channel name',
          channelDescription: 'channel description',
          importance: Importance.max,
          playSound: true,
          // sound: 'sound',
          showProgress: true,
          priority: Priority.max,
          channelShowBadge: true,
          ticker: 'ticker');

  var iOSChannelSpecifics = IOSNotificationDetails();
  const MacOSNotificationDetails macOSPlatformChannelSpecifics =
      MacOSNotificationDetails(subtitle: 'the subtitle');
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSChannelSpecifics,
      macOS: macOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin
      .show(10001, title, body, platformChannelSpecifics, payload: 'test');
  var androidNotificationChannel = AndroidNotificationChannel(
    "10001",
    title,
    description: body,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);
}

tryingNotification() async {
    String fcm = sm.getValue(UserConstant.FCM_TOKEN);

    var result = await put(
        Uri.parse("${Urls.baseUrl}${Urls.sendFcmToken}/${sm.getUser()?.usId ?? 0}"),
        body: {
          "userToken": "$fcm",
          "deviceType": "0", //"${(Platform.isAndroid)?'android': 'ios'}",
          "language": "${(currentLocale == AppLocale.AR) ? 0 : 1}",
          "empId": "${sm.getUser()?.usId ?? 0}",
        });




  Uri uri = Uri.parse("${Urls.baseUrl}${Urls.sendNotification}");
  String token = sm.getValue(UserConstant.FCM_TOKEN);
  Map body = {
    "DeviceId": token,
    "IsAndroiodDevice": true,
    "Title": "my own title",
    "Body": "my own Body",
  };
  Response response = await post(uri,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode(body));

  print("==============================>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  print("${Urls.baseUrl}${Urls.sendNotification}");
  print(response.statusCode);
  print(response.body);
}


