import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_event.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_repository.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({@required this.authenticationRepository})
      : super(AuthenticationStateInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoginEvent) {
      try {
        yield AuthenticationProcessInProgress();
        bool loggedIn = await authenticationRepository.login(event.credentials);
        if (!loggedIn) {
          throw Exception("Login Failed");
        }
        var user = await authenticationRepository.getUser();
        yield UserLoggedIn(user);
      } catch (e) {
        yield AuthenticationError(e.toString());
      }
    } else if (event is LogoutEvent) {
      try {
        yield AuthenticationProcessInProgress();
        bool loggedIn = await authenticationRepository.logout();
        if (!loggedIn) {
          throw Exception("Logout Failed");
        }
        yield UserNotLoggedIn();
      } catch (e) {
        yield state;
      }
    } else if (event is CheckAuthenticationStatusEvent) {
      try {
        yield AuthenticationProcessInProgress();
        bool loggedIn = await authenticationRepository.isUserLoggedIn();
        if (!loggedIn) {
          throw UserNotLoggedIn();
        }
        var user = await authenticationRepository.getUser();
        yield UserLoggedIn(user);
      } catch (e) {
        yield AuthenticationError(e.toString());
      }
    }
  }
}
