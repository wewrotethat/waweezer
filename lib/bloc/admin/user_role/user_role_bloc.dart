import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_event.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_repository.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_state.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  final UserRoleRepository userRoleRepository;
  UserRoleBloc({@required this.userRoleRepository})
      : super(UserRoleInitialState());

  @override
  Stream<UserRoleState> mapEventToState(UserRoleEvent event) async* {
    if (event is UpdateUserRoleEvent) {
      yield UserRoleOperationInProgress();
      try {
        await userRoleRepository.updateUserByID(event.userId, event.user);
        var users = await userRoleRepository.readUsers();

        yield UserRoleOperationSuccess(users);
      } catch (e) {
        yield UserRoleOperationFailed(e.toString());
      }
    } else if (event is ReadUsersEvent) {
      yield UserRoleOperationInProgress();
      try {
        var users = await userRoleRepository.readUsers();
        yield UserRoleOperationSuccess(users);
      } catch (e) {
        yield UserRoleOperationFailed(e.toString());
      }
    }
  }
}
