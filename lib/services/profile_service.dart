import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tactictrade/models/environments_models.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/services/auth_service.dart';

class ProfileService extends ChangeNotifier {
  final String baseUrl = Environment.baseUrl;

  Future<String?> updateProfil(
    String username,
    String about,
    String pathGalleryImage,
  ) async {
    final urlProfile = Uri.http(Environment.baseUrl, '/account/profile/');

    final _storage = new FlutterSecureStorage();

    final token = await _storage.read(key: 'token_access') ?? '';

    if (token == '') {
      return '';
    }

    Map<String, String> headers = {
      'Content-Type': 'applicaction/json',
      'Authorization': 'Bearer ' + token
    };

    final imageUploadRequest = await http.MultipartRequest('PUT', urlProfile);

    imageUploadRequest.headers.addAll(headers);
    imageUploadRequest.fields['username'] = username;
    imageUploadRequest.fields['about'] = about;

    //TODO add one control for not upload old images.

    // if pathGalleryImage.contains('http')

    if (!pathGalleryImage.contains('http')) {
      final profile_image =
          await http.MultipartFile.fromPath('profile_image', pathGalleryImage);

      imageUploadRequest.files.add(profile_image);
    }
    ;

    final response = await imageUploadRequest.send();

    print('--- 111 ---- --- @@@ @@@ @@@ @@@@ @@@ --------------');
    print(response);
    // print('--- 222 ---- --- @@@ @@@ @@@ @@@@ @@@ --------------');

    return '';
  }
}
