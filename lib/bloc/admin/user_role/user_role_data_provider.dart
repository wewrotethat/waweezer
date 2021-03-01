import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/models/user.dart';
import 'package:waweezer_mobile/resources/constants.dart';

class UserRoleDataProvider {
  final APIHelper apiHelper;
  UserRoleDataProvider({@required this.apiHelper});

  Future<User> readUserByID(String id) async {
    assert(id != null);
    var response = await apiHelper.get(
      '$baseURL/userRoles/$id',
    );
    return User.fromJson(response.body);
  }

  Future<List<User>> readUsers() async {
    var response = await apiHelper.get(
      '$baseURL/users',
    );
    List<dynamic> userRoleListResponse = json.decode(response.body);
    List<User> userRoles = List<User>();
    userRoleListResponse.forEach((userRoleMap) {
      userRoles.add(User.fromMap(userRoleMap));
    });
    return userRoles;
  }

  Future<void> updateUserByID(String id, User userRole) async {
    assert(id != null && userRole != null);
    await apiHelper.patch(
      '$baseURL/users/$id',
      userRole.toMap(),
    );
  }
}
