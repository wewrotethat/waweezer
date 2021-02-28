import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/bloc/user/user_data_provider.dart';
import 'package:waweezer_mobile/models/dto/sign_up_dto.dart';
import 'package:waweezer_mobile/models/user.dart';

class UserRepository {
  final UserDataProvider userDataProvider;

  UserRepository({@required this.userDataProvider});

  Future<User> createUser(SignUpDTO user) async {
    return await userDataProvider.createUser(user);
  }

  Future<List<User>> readUsers() async {
    return await userDataProvider.readUsers();
  }

  Future<User> readUser() async {
    var user = await userDataProvider.readUser();
    return user;
  }

  Future<void> updateUser(User user) async {
    return await userDataProvider.updateUser(user);
  }

  Future<void> deleteUser() async {
    return await userDataProvider.deleteUser();
  }
}
