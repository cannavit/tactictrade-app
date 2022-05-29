import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class AuthService extends ChangeNotifier {
  final String baseUrl = Environment.baseUrl;

  final storage = const FlutterSecureStorage();

  Future<String?> createUser(
      String email, String password, String username) async {
    final url = Uri.http(baseUrl, '/account/register/');

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'username': username
    };


    // final resp = await http.post(url, body: json.encode(authData));

    final resp = await http.post(url,
        body: {'email': email, 'password': password, 'username': username});
    return null;

  }

  Future login(String email, String password) async {
    final url = Uri.http(Environment.baseUrl, '/account/login/');

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };


    // final resp = await http.post(url, body: json.encode(authData));

    final resp =
        await http.post(url, body: {'email': email, 'password': password});

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    // User Valid
    if (decodedResp.containsKey('token_access')) {

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

  // Getters del token de forma estática
  static Future getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access');

    return token;
  }

  Future<String> validateToken() async {
    final url = Uri.http(Environment.baseUrl, '/settings/');

    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });


    final body = json.decode(response.body);

    if (body['code'] == "token_not_valid") {
      return '';
    }

    return "Have token";
  }

  Future<dynamic> isLoggedIn() async {
    //TODO When the token exist but is expirad or the user is deleted the app not open
    const _storage = FlutterSecureStorage();

    final logged = {'token': ""};

    final token = await _storage.read(key: 'token_access') ?? '';

    final url = Uri.http(Environment.baseUrl, '/broker/v1/all');

    if (token == '') {
      return {'isLogged': false, 'token': ''};
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });

    try {
      final body = json.decode(response.body);

      if (body['code'] == "token_not_valid") {
        return {'isLogged': false, 'token': ''};
      }

      return {'isLogged': true, 'token': token};
    } catch (e) {
      return {'isLogged': false, 'token': ''};
    }
  }

  Future readProfileData(String token) async {
    final urlProfile = Uri.http(Environment.baseUrl, '/account/profile/');

    final responseProfile = await http.get(urlProfile, headers: {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    });

    final bodyProfile = json.decode(responseProfile.body);

    try {
      if (bodyProfile['code'] == 'user_not_found') {
        return '';
      }
    } catch (e) {
      print('The User exist');
    }

    return {
      "about": bodyProfile['about'],
      "username": bodyProfile['username'],
      "profile_image": bodyProfile['profile_image'],
    };
  }
}
