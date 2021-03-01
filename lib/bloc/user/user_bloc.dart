import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/user/user_event.dart';
import 'package:waweezer_mobile/bloc/user/user_repository.dart';
import 'package:waweezer_mobile/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({@required this.userRepository}) : super(UserInitialState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is CreateUserEvent) {
      yield UserOperationInProgress();
      try {
        var user = await userRepository.createUser(event.user);

        yield SingleUserOperationSuccess(user);
      } catch (e) {
        yield UserOperationFailed(e.toString());
      }
    } else if (event is UpdateUserEvent) {
      yield UserOperationInProgress();
      try {
        await userRepository.updateUser(event.user);
        var user = await userRepository.readUser();

        yield SingleUserOperationSuccess(user);
      } catch (e) {
        yield UserOperationFailed(e.toString());
      }
    }  else if (event is ReadUserEvent) {
      yield UserOperationInProgress();
      try {
        var user = await userRepository.readUser();
        yield SingleUserOperationSuccess(user);
      } catch (e) {
        yield UserOperationFailed(e.toString());
      }
    } else if (event is DeleteUserEvent) {
      yield UserOperationInProgress();
      try {
        await userRepository.deleteUser();
        var user = await userRepository.readUser();

        yield SingleUserOperationSuccess(user);
      } catch (e) {
        yield UserOperationFailed(e.toString());
      }
    }
  }
}
