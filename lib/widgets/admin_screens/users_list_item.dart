import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_state.dart';
import 'package:waweezer_mobile/models/user.dart';
import 'package:waweezer_mobile/screens/admin_screens/user_detail.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return UserDetail(user: user);
            },
          ),
        );
      },
      child: Card(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${user.name.first} ${user.name.middle} ${user.name.last}'),
              Text(user.role),
            ],
          ),
        ),
      ),
    );
  }
}
