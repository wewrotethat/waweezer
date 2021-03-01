import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/models/dto/sign_up_dto.dart';
import 'package:waweezer_mobile/models/user.dart';

abstract class UserEvent {}

class CreateUserEvent extends UserEvent {
  final SignUpDTO user;

  CreateUserEvent(this.user);
}

class ReadUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final User user;

  UpdateUserEvent({
    @required this.user,
  });
}

class DeleteUserEvent extends UserEvent {}
