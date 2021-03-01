import 'package:waweezer_mobile/models/user.dart';

abstract class UserRoleState {}

class UserRoleInitialState extends UserRoleState {}

class UserRoleOperationSuccess extends UserRoleState {
  final List<User> users;

  UserRoleOperationSuccess(this.users);
}

class UserRoleOperationInProgress extends UserRoleState {}

class UserRoleOperationFailed extends UserRoleState {
  final String error;

  UserRoleOperationFailed(this.error);
}
