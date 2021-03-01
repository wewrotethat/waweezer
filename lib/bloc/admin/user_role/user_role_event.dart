import 'package:flutter/foundation.dart';
import 'package:waweezer_mobile/models/user.dart';

abstract class UserRoleEvent {}

class ReadUsersEvent extends UserRoleEvent {}

class UpdateUserRoleEvent extends UserRoleEvent {
  final String userId;
  final User user;

  UpdateUserRoleEvent({
    @required this.userId,
    @required this.user,
  });
}
