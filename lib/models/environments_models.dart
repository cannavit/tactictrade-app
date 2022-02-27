import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }

    return '.env';
  }

  static String get baseUrl {
    // return ?? 'API_URL not found!';
    final baseUrl = Platform.isAndroid
        ? dotenv.env['BASE_URL_ANDROID']
        : dotenv.env['BASE_URL_IOS'];
    return baseUrl ?? '';
  }

  static String get baseWebUrl {
    final webUrl = dotenv.env['BASE_URL_WEB'];

    return webUrl ?? '';
  }
}
