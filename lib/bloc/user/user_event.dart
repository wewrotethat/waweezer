import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/models/dto/sign_up_dto.dart';
import 'package:waweezer_mobile/models/user.dart';

abstract class UserEvent {}

class CreateUserEvent extends UserEvent {
  final SignUpDTO user;

  CreateUserEvent(this.user);
}

class ReadUsersEvent extends UserEvent {}

class ReadUserEvent extends UserEvent {}

class ReadUserByIDEvent extends UserEvent {
  final String userId;

  ReadUserByIDEvent(this.userId);
}

class UpdateUserEvent extends UserEvent {
  final User user;

  UpdateUserEvent({
    @required this.user,
  });
}

class UpdateUserByIDEvent extends UserEvent {
  final String userId;
  final User user;

  UpdateUserByIDEvent({
    @required this.userId,
    @required this.user,
  });
}

class DeleteUserEvent extends UserEvent {}

class DeleteUserByIDEvent extends UserEvent {
  final String userId;

  DeleteUserByIDEvent(this.userId);
}
