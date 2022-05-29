import 'package:flutter/material.dart';

class NewStrategyProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static String? _strategyName = '';

  static bool _isPublic = true;
  static bool _isActive = true;
  static String _selectedMessage = '';
  static String _selectedWebhook = '';

  String? get strategyName => _strategyName;

  set strategyName(String? value) {
    _strategyName = value;
    notifyListeners();
  }

  bool get isActive => _isActive;

  set isActive(bool value) {
    _isActive = value;
    notifyListeners();
  }

  bool get isPublic => _isPublic;

  set isPublic(bool value) {
    _isPublic = value;
    notifyListeners();
  }

  String get selectedMessage => _selectedMessage;

  set selectedMessage(String value) {
    _selectedMessage = value;
    notifyListeners();
  }

  String get selectedWebhook => _selectedWebhook;

  set selectedWebhook(String value) {
    _selectedWebhook = value;
    notifyListeners();
  }


}
