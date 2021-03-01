import 'package:waweezer_mobile/models/user.dart';

abstract class AuthenticationState {}

class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationProcessInProgress extends AuthenticationState {}

class UserLoggedIn extends AuthenticationState {
  final User user;

  UserLoggedIn(this.user);
}

class UserNotLoggedIn extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String error;

  AuthenticationError(this.error);
}
