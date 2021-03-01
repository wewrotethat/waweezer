import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_event.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_state.dart';
import 'package:waweezer_mobile/bloc/user/user_bloc.dart';
import 'package:waweezer_mobile/bloc/user/user_event.dart';
import 'package:waweezer_mobile/bloc/user/user_state.dart';
import 'package:waweezer_mobile/models/name.dart';
import 'package:waweezer_mobile/models/user.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final photoPathController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      enabled: !(state is UserOperationInProgress),
                      controller: firstNameController,
                      decoration: InputDecoration(labelText: "First Name"),
                    ),
                    TextFormField(
                      enabled: !(state is UserOperationInProgress),
                      controller: middleNameController,
                      decoration: InputDecoration(labelText: "Middle Name"),
                    ),
                    TextFormField(
                      enabled: !(state is UserOperationInProgress),
                      controller: lastNameController,
                      decoration: InputDecoration(labelText: "Last Name"),
                    ),
                    TextFormField(
                      enabled: !(state is UserOperationInProgress),
                      controller: emailController,
                      decoration: InputDecoration(labelText: "Email"),
                    ),
                    TextFormField(
                      enabled: !(state is UserOperationInProgress),
                      controller: ageController,
                      decoration: InputDecoration(labelText: "Age"),
                    ),
                    TextFormField(
                      enabled: !(state is UserOperationInProgress),
                      controller: photoPathController,
                      decoration: InputDecoration(labelText: "Photo Path"),
                    ),
                    FlatButton(
                      onPressed: !(state is UserOperationInProgress)
                          ? () {
                              BlocProvider.of<UserBloc>(context).add(
                                UpdateUserEvent(
                                  user: User(
                                    name: Name(
                                      first: firstNameController.text,
                                      middle: middleNameController.text,
                                      last: lastNameController.text,
                                    ),
                                    email: emailController.text,
                                    age: int.parse(ageController.text),
                                    photoPath: photoPathController.text,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: Text("Update User"),
                    ),
                    FlatButton(
                      onPressed: !(state is UserOperationInProgress)
                          ? () {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                LogoutEvent(),
                              );
                            }
                          : null,
                      child: Text("Log out"),
                    ),
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is UserLoggedIn &&
                            state.user.role?.toLowerCase() != 'admin') {
                          return FlatButton(
                            onPressed: !(state is UserOperationInProgress)
                                ? () async {
                                    await showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        content: Text("Are you sure?"),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                BlocProvider.of<UserBloc>(
                                                        context)
                                                    .add(
                                                  DeleteUserEvent(),
                                                );
                                                BlocProvider.of<
                                                            AuthenticationBloc>(
                                                        context)
                                                    .add(
                                                  LogoutEvent(),
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Yes")),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No"),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                : null,
                            child: Text("Delete Account"),
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
              if (state is UserOperationInProgress)
                CircularProgressIndicator()
              else
                Container()
            ],
          ),
        ),
        listener: (context, state) {
          if (state is SingleUserOperationSuccess) {
            firstNameController.text = state.user.name.first;
            middleNameController.text = state.user.name.middle;
            lastNameController.text = state.user.name.last;
            ageController.text = state.user.age.toString();
            emailController.text = state.user.email;
            photoPathController.text = state.user.photoPath;
          }
        },
      ),
    );
  }
}
