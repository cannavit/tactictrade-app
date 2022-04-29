import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:tactictrade/models/environments_models.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStreamController =
      new StreamController.broadcast();

  static Stream<String> get messageStreamController =>
      _messageStreamController.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    print(' On Background Handler ${message.messageId}');

    // _messageStreamController.add(message.notification?.title ?? 'Not title');
    _messageStreamController.add(message.data['product'] ?? 'No Data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print(' onMessage  Handler ${message.messageId}');
    // _messageStreamController.add(message.notification?.title ?? 'Not title');
    _messageStreamController.add(message.data['product'] ?? 'No Data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print(' background Handler ${message.data}');

    _messageStreamController.add(message.data['product'] ?? 'No Data');
  }

  static Future initializeApp() async {
    // Push Notification
    await Firebase.initializeApp();
    final token_device = await FirebaseMessaging.instance.getToken();

    print("@Note-01 ---- 873035972 -----");
    print("TOKEN: ${token_device}");
    final baseUrl =  Environment.baseUrl;
    final url = Uri.http(baseUrl, '/notifications/v1/register');
    final _storage = new FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    print(token);

    if (token == '') {
      return '';
    }

    // final data = json.encode(bodyBroker);

    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token
    }, body: json.encode({
      "token": token_device,
      "device_type": ""
    }) );

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local Notification
  }

  static closeStreams() {
    _messageStreamController.close();
  }
}
