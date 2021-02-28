import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/models/user_credentials.dart';
import 'package:waweezer_mobile/resources/constants.dart';

class AuthenticationDataProvider {
  final APIHelper apiHelper;
  AuthenticationDataProvider({@required this.apiHelper});
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await _prefs;
    if (!prefs.containsKey('token')) {
      return false;
    }
    return true;
  }

  Future<bool> login(UserCredentials credentials) async {
    var response =
        await apiHelper.post('$baseURL/users/login', credentials.toMap());
    String token = json.decode(response.body)['token'];
    SharedPreferences prefs = await _prefs;
    return await prefs.setString('token', token);
  }

  Future<bool> logOut() async {
    SharedPreferences prefs = await _prefs;
    return await prefs.clear();
  }
}
