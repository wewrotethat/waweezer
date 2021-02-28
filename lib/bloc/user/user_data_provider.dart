import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/models/dto/sign_up_dto.dart';
import 'package:waweezer_mobile/models/user.dart';
import 'package:waweezer_mobile/resources/constants.dart';

class UserDataProvider {
  final APIHelper apiHelper;
  UserDataProvider({@required this.apiHelper});
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<User> createUser(SignUpDTO user) async {
    var response = await apiHelper.post('$baseURL/users/sign-up', user.toMap());
    print(response.body);
    return User.fromJson(response.body);
  }

  Future<User> readUser() async {
    SharedPreferences prefs = await _prefs;
    var response = await apiHelper.get('$baseURL/users/me',
        token: prefs.getString('token'));
    var user = User.fromJson(response.body);
    return user;
  }

  Future<User> readUserByID(String id) async {
    assert(id != null);
    SharedPreferences prefs = await _prefs;
    var response = await apiHelper.get('$baseURL/users/$id',
        token: prefs.getString('token'));
    return User.fromJson(response.body);
  }

  Future<List<User>> readUsers() async {
    SharedPreferences prefs = await _prefs;
    var response =
        await apiHelper.get('$baseURL/users', token: prefs.getString('token'));
    List<dynamic> userListResponse = json.decode(response.body);
    List<User> users = List<User>();
    userListResponse.forEach((userMap) {
      users.add(User.fromMap(userMap));
    });
    return users;
  }

  Future<void> updateUser(User user) async {
    assert(user != null);
    SharedPreferences prefs = await _prefs;
    await apiHelper.patch('$baseURL/users/me', user.toMap(),
        token: prefs.getString('token'));
  }

  Future<void> updateUserByID(String id, User user) async {
    assert(id != null && user != null);
    SharedPreferences prefs = await _prefs;
    await apiHelper.patch('$baseURL/users/$id', user.toMap(),
        token: prefs.getString('token'));
  }

  Future<void> deleteUser() async {
    SharedPreferences prefs = await _prefs;
    await apiHelper.delete('$baseURL/users/me',
        token: prefs.getString('token'));
  }

  Future<void> deleteUserByID(String id) async {
    assert(id != null);
    SharedPreferences prefs = await _prefs;
    await apiHelper.delete('$baseURL/users/$id',
        token: prefs.getString('token'));
  }
}
