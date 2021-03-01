import 'package:waweezer_mobile/models/user.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class SingleUserOperationSuccess extends UserState {
  final User user;

  SingleUserOperationSuccess(this.user);
}

class UserOperationInProgress extends UserState {}

class UserOperationFailed extends UserState {
  final String error;

  UserOperationFailed(this.error);
}
