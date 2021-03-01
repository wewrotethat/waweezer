import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/user/user_bloc.dart';
import 'package:waweezer_mobile/bloc/user/user_event.dart';
import 'package:waweezer_mobile/bloc/user/user_state.dart';
import 'package:waweezer_mobile/models/dto/sign_up_dto.dart';
import 'package:waweezer_mobile/models/name.dart';
import 'package:waweezer_mobile/models/user.dart';
import 'package:waweezer_mobile/models/user_credentials.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final photoPathController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
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
                      controller: passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
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
                                CreateUserEvent(
                                  SignUpDTO(
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
                                    userCredentials: UserCredentials(
                                      password: passwordController.text,
                                    ),
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: Text("Create User"),
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
            Scaffold.of(context).showSnackBar(SnackBar(
                content:
                    Text('Sign up successful. Please log in to use the app.')));
            Navigator.of(context).pushNamed("/login");
          } else if (state is UserOperationFailed) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
      ),
    );
  }
}
