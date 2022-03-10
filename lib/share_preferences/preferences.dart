import 'package:shared_preferences/shared_preferences.dart';
import 'package:tactictrade/models/environments_models.dart';

// course lecction
// https://www.udemy.com/course/flutter-ios-android-fernando-herrera/learn/lecture/14605546#notes

class Preferences {
  static late SharedPreferences _prefs;

  // Declarate Preferences Inputs. -----------------------------------------

  //           Generic preferences.
  static String _name = '';
  static bool isPaperTrading = true;
  static int _gender = 1;
  static bool _isDarkmode = false;
  // static bool _isDarkmode = false;

  //           Profine Information
  static String _username = '';
  static String _about = '';
  static String _profileImage = '';

  //           Controls Information
  static String _pathGalleryImage = '';
  static String _tempProfileImage = '';
  static String _selectedAppBarName = '';
  static String _tempStrategyImage = '';
  static bool _isPublicNewStrategy = true;
  static bool _isActiveNewStrategy = true;
  static String _selectedTimeNewStrategy = 'minute';
  static bool _createNewStrategy = false;
  static int _formValidatorCounter = 0;

  static int _navigationCurrentPage = 0;

  static bool _brokerNewUseTradingLong = false;
  static bool _brokerNewUseTradingShort = false;


  // Init Preferences
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Define geters -------------------------------------------------------

  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static bool get isPaperLightMode {
    return _prefs.getBool('isPaperLightMode') ?? isPaperTrading;
  }

  static int get gender {
    return _prefs.getInt('gender') ?? _gender;
  }

  static bool get isDarkmode {
    return _prefs.getBool('isDarkmode') ?? _isDarkmode;
  }

  static String get username {
    return _prefs.getString('username') ?? _username;
  }

  static String get about {
    return _prefs.getString('about') ?? _about;
  }

  static String get profileImage {
    final String urlProfilImage =
        _prefs.getString('profileImage') ?? _profileImage;

    final String baseUrl = Environment.baseWebUrl;

    var urlProfit;

    if (urlProfilImage.contains('http')) {
      urlProfit = urlProfilImage;
    } else {
      urlProfit = baseUrl + urlProfilImage;
    }

    return urlProfit;
  }

  static String get pathGalleryImage {
    return _prefs.getString('pathGalleryImage') ?? _pathGalleryImage;
  }

  static String get tempProfileImage {
    return _prefs.getString('tempProfileImage') ?? _tempProfileImage;
  }

  static String get selectedAppBarName {
    return _prefs.getString('selectedAppBarName') ?? _selectedAppBarName;
  }

  static String get tempStrategyImage {
    return _prefs.getString('tempStrategyImage') ?? _tempStrategyImage;
  }

  static bool get isPublicNewStrategy {
    return _prefs.getBool('isPublicNewStrategy') ?? _isPublicNewStrategy;
  }

  static bool get isActiveNewStrategy {
    return _prefs.getBool('isActiveNewStrategy') ?? _isActiveNewStrategy;
  }

  static String get selectedTimeNewStrategy {
    return _prefs.getString('selectedTimeNewStrategy') ??
        _selectedTimeNewStrategy;
  }

  static bool get createNewStrategy {
    return _prefs.getBool('createNewStrategy') ?? _createNewStrategy;
  }

  static int get formValidatorCounter {
    return _prefs.getInt('formValidatorCounter') ?? _formValidatorCounter;
  }

  static int get navigationCurrentPage {
    return _prefs.getInt('navigationCurrentPage') ?? _navigationCurrentPage;
  }

  static bool get brokerNewUseTradingLong {
    return _prefs.getBool('brokerNewUseTradingLong') ?? _brokerNewUseTradingLong;
  }

  static bool get brokerNewUseTradingShort {
    return _prefs.getBool('brokerNewUseTradingShort') ?? _brokerNewUseTradingShort;
  }

  
  // Define seters -------------------------------------------------------

  static set name(String name) {
    _name = name;
    _prefs.setString('name', name);
  }

  static set isPaperLightMode(bool value) {
    isPaperTrading = value;
    _prefs.setBool('isPaperLightMode', value);
  }

  static set gender(int value) {
    _gender = value;
    _prefs.setInt('gender', value);
  }

  static set isDarkmode(bool value) {
    _isDarkmode = value;
    _prefs.setBool('isDarkmode', value);
  }

  static set username(String value) {
    _username = value;
    _prefs.setString('username', value);
  }

  static set about(String value) {
    _about = value;
    _prefs.setString('about', value);
  }

  static set profileImage(String value) {
    _profileImage = value;
    _prefs.setString('profileImage', value);
  }

  static set pathGalleryImage(String value) {
    _pathGalleryImage = value;
    _prefs.setString('pathGalleryImage', value);
  }

  static set tempProfileImage(String value) {
    _tempProfileImage = value;
    _prefs.setString('tempProfileImage', value);
  }

  static set selectedAppBarName(String value) {
    _selectedAppBarName = value;
    _prefs.setString('selectedAppBarName', value);
  }

  static set tempStrategyImage(String value) {
    _tempStrategyImage = value;
    _prefs.setString('tempStrategyImage', value);
  }

  static set isActiveNewStrategy(bool value) {
    _isActiveNewStrategy = value;
    _prefs.setBool('isActiveNewStrategy', value);
  }

  static set isPublicNewStrategy(bool value) {
    _isPublicNewStrategy = value;
    _prefs.setBool('isPublicNewStrategy', value);
  }

  static set selectedTimeNewStrategy(String value) {
    _selectedTimeNewStrategy = value;
    _prefs.setString('selectedTimeNewStrategy', value);
  }

  static set createNewStrategy(bool value) {
    _createNewStrategy = value;
    _prefs.setBool('createNewStrategy', value);
  }

  static set formValidatorCounter(int value) {
    _formValidatorCounter = value;
    _prefs.setInt('formValidatorCounter', value);
  }

  static set navigationCurrentPage(int value) {
    _navigationCurrentPage = value;
    _prefs.setInt('navigationCurrentPage', value);
  }

  static set brokerNewUseTradingLong(bool value) {
    _brokerNewUseTradingLong = value;
    _prefs.setBool('brokerNewUseTradingLong', value);
  }

  static set brokerNewUseTradingShort(bool value) {
    _brokerNewUseTradingShort = value;
    _prefs.setBool('brokerNewUseTradingShort', value);
  }

}
