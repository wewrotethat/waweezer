import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/models/user_credentials.dart';

abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final UserCredentials credentials;

  LoginEvent({@required this.credentials});
}

class LogoutEvent extends AuthenticationEvent {}

class CheckAuthenticationStatusEvent extends AuthenticationEvent {}
