import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_data_provider.dart';
import 'package:waweezer_mobile/bloc/user/user_data_provider.dart';
import 'package:waweezer_mobile/models/user.dart';
import 'package:waweezer_mobile/models/user_credentials.dart';

class AuthenticationRepository {
  final AuthenticationDataProvider authenticationDataProvider;
  final UserDataProvider userDataProvider;

  AuthenticationRepository(
      {@required this.authenticationDataProvider,
      @required this.userDataProvider});
  Future<bool> isUserLoggedIn() async {
    return await authenticationDataProvider.isUserLoggedIn();
  }

  Future<User> getUser() async {
    return await userDataProvider.readUser();
  }

  Future<bool> login(UserCredentials credentials) async {
    return await authenticationDataProvider.login(credentials);
  }

  Future<bool> logout() async {
    return await authenticationDataProvider.logOut();
  }
}
