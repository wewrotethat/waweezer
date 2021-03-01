import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/models/dto/sign_up_dto.dart';
import 'package:waweezer_mobile/models/user.dart';
import 'package:waweezer_mobile/resources/constants.dart';

class UserDataProvider {
  final APIHelper apiHelper;
  UserDataProvider({@required this.apiHelper});

  Future<User> createUser(SignUpDTO user) async {
    var response = await apiHelper.post('$baseURL/users/sign-up', user.toMap());
    print(response.body);
    return User.fromJson(response.body);
  }

  Future<User> readUser() async {
    var response = await apiHelper.get(
      '$baseURL/users/me',
    );
    var user = User.fromJson(response.body);
    return user;
  }

  Future<void> updateUser(User user) async {
    assert(user != null);
    await apiHelper.patch(
      '$baseURL/users/me',
      user.toMap(),
    );
  }

  Future<void> deleteUser() async {
    await apiHelper.delete(
      '$baseURL/users/me',
    );
  }
}
