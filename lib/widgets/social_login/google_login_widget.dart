import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../models/environments_models.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;

    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();


    final storage = new FlutterSecureStorage();
    final url = Uri.http(Environment.baseUrl, '/social_auth/google_login/');
    final resp = await http.post(url, body: {'auth_token': googleAuth.idToken});

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    // // User Valid
    if (decodedResp. containsKey('token_access')) {

      await storage.write(
          key: 'token_access', value: decodedResp['token_access']);

      String? test = await storage.read(key: 'token_access');

      Map<String, String> allValues = await storage.readAll();

      return null;
    } else {
      return decodedResp['detail'];
    }
    // ---------------------------------------------------------------------

  }
}
