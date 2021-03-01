import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waweezer_mobile/helpers/exceptions/network_exceptions.dart';

class APIHelper {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<dynamic> get(
    String url,
  ) async {
    SharedPreferences prefs = await _prefs;
    var responseJson;
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    SharedPreferences prefs = await _prefs;
    // print(jsonEncode(body));
    var responseJson;
    try {
      final response = await http.post(
        url,
        body: json.encode(body),
        headers: <String, String>{
          'content-type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException catch (e) {
      print('post socket exception $e');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(
    String url,
    Map<String, dynamic> body,
  ) async {
    SharedPreferences prefs = await _prefs;
    var responseJson;
    try {
      final response = await http.put(
        url,
        body: jsonEncode(body),
        headers: <String, String>{
          'content-type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> patch(
    String url,
    Map<String, dynamic> body,
  ) async {
    SharedPreferences prefs = await _prefs;
    var responseJson;
    try {
      final response = await http.patch(
        url,
        body: jsonEncode(body),
        headers: <String, String>{
          'content-type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(
    String url,
  ) async {
    SharedPreferences prefs = await _prefs;
    var responseJson;
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    if (200 <= response.statusCode && response.statusCode < 300) {
      return response;
    } else if (response.statusCode == 400) {
      throw BadRequestException(response.body.toString());
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      throw UnauthorizedException(response.body.toString());
    } else {
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
