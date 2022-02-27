import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tactictrade/services/auth_service.dart';

class PositionServices {
  final String baseUrl = 'localhost:8000';

  Future getPositions() async {
    final url = Uri.http(baseUrl, '/trading/positions');
    final token = 'Bearer ' + await AuthService.getToken();

    final response = await http.get(url,
        headers: {'Content-Type': 'applicaction/json', 'Authorization': token});

    final body = json.decode(response.body);

    //TODO use status for invalidate token.
    final status = body['status'];

    return body['positions'];
  }

  Future closePosition(String closePositionId) async {
    final token = 'Bearer ' + await AuthService.getToken();

    final url =
        Uri.http(baseUrl, '/trading/positions/close/${closePositionId}');

    final response = await http.delete(url,
        headers: {'Content-Type': 'applicaction/json', 'Authorization': token});

    final body = json.decode(response.body);

    return body['message'];
  }
}
