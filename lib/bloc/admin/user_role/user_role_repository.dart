import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_data_provider.dart';
import 'package:waweezer_mobile/models/user.dart';

class UserRoleRepository {
  final UserRoleDataProvider userRoleDataProvider;

  UserRoleRepository({@required this.userRoleDataProvider});

  Future<List<User>> readUsers() async {
    return await userRoleDataProvider.readUsers();
  }

  Future<void> updateUserByID(String id, User userRole) async {
    return await userRoleDataProvider.updateUserByID(id, userRole);
  }
}
