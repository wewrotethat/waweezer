import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_bloc.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_event.dart';
import 'package:waweezer_mobile/models/user.dart';

class UserDetail extends StatefulWidget {
  final User user;

  const UserDetail({Key key, @required this.user}) : super(key: key);
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  var role;

  @override
  void initState() {
    role = widget.user.role;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              hint: Text('Select role'),
              items: [
                DropdownMenuItem(
                  child: Text("Admin"),
                  value: 'admin',
                ),
                DropdownMenuItem(
                  child: Text("User"),
                  value: 'user',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  role = value.toString().toLowerCase();
                });
              },
              value: role,
            ),
            FlatButton(
                onPressed: () {
                  BlocProvider.of<UserRoleBloc>(context)
                    ..add(
                      UpdateUserRoleEvent(
                        user: widget.user..role = role,
                        userId: widget.user.id,
                      ),
                    );
                  Navigator.of(context).pop();
                },
                child: Text('Update Role'))
          ],
        ),
      ),
    );
  }
}
