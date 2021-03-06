import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class AuthService extends ChangeNotifier {
  final String baseUrl = Environment.baseUrl;

  final storage = new FlutterSecureStorage();

  Future<String?> createUser(
      String email, String password, String username) async {
    final url = Uri.http(baseUrl, '/account/register/');

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'username': username
    };

    print(url);

    // final resp = await http.post(url, body: json.encode(authData));

    final resp = await http.post(url,
        body: {'email': email, 'password': password, 'username': username});

    print('Test');
    print(json.encode(authData));
  }

  Future login(String email, String password) async {
    final url = Uri.http(Environment.baseUrl, '/account/login/');

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    print(url);

    // final resp = await http.post(url, body: json.encode(authData));

    final resp =
        await http.post(url, body: {'email': email, 'password': password});

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    // User Valid
    if (decodedResp.containsKey('token_access')) {
      print(decodedResp['token_access']);

      await storage.write(
          key: 'token_access', value: decodedResp['token_access']);

      String? test = await storage.read(key: 'token_access');
      Map<String, String> allValues = await storage.readAll();

      return null;
    } else {
      return decodedResp['detail'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token_access');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token_access') ?? '';
  }

  // Getters del token de forma est??tica
  static Future getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access');

    return token;
  }

  Future<String> validateToken() async {
    final url = Uri.http(Environment.baseUrl, '/settings/');

    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }
    ;

    final response = await http.get(url, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });

    print(response);

    final body = json.decode(response.body);

    if (body['code'] == "token_not_valid") {
      return '';
    }

    return "Have token";
  }

  Future<dynamic> isLoggedIn() async {
    final _storage = new FlutterSecureStorage();

    final logged = {'token': ""};

    final token = await _storage.read(key: 'token_access') ?? '';

    final url = Uri.http(Environment.baseUrl, '/strategy/v1/all');

    if (token == '') {
      return {'isLogged': false, 'token': ''};
    }
    ;

    final response = await http.get(url, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });

    final body = json.decode(response.body);

    if (body['code'] == "token_not_valid") {
      return {'isLogged': false, 'token': ''};
    }

    return {'isLogged': true, 'token': token};
  }

  Future readProfileData(String token) async {
    final urlProfile = Uri.http(Environment.baseUrl, '/account/profile/');

    final response_profile = await http.get(urlProfile, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });

    final bodyProfile = json.decode(response_profile.body);

    return {
      "about": bodyProfile['about'],
      "username": bodyProfile['username'],
      "profile_image": bodyProfile['profile_image'],
    };
  }
}
