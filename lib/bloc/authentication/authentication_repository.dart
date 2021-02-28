import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_data_provider.dart';
import 'package:waweezer_mobile/models/user_credentials.dart';

class AuthenticationRepository {
  final AuthenticationDataProvider authenticationDataProvider;

  AuthenticationRepository({@required this.authenticationDataProvider});
  Future<bool> isUserLoggedIn() async {
    return await authenticationDataProvider.isUserLoggedIn();
  }

  Future<bool> login(UserCredentials credentials) async {
    return await authenticationDataProvider.login(credentials);
  }

  Future<bool> logout() async {
    return await authenticationDataProvider.logOut();
  }
}
