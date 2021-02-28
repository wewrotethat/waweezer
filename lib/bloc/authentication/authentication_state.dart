abstract class AuthenticationState {}

class AuthenticationProcessInProgress extends AuthenticationState {}

class UserLoggedIn extends AuthenticationState {}

class UserNotLoggedIn extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String error;

  AuthenticationError(this.error);
}
