import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_event.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_state.dart';
import 'package:waweezer_mobile/models/user_credentials.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) => Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  TextFormField(
                    enabled: !(state is AuthenticationProcessInProgress),
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextFormField(
                    enabled: !(state is AuthenticationProcessInProgress),
                    controller: passwordController,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  FlatButton(
                    onPressed: !(state is AuthenticationProcessInProgress)
                        ? () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(LoginEvent(
                                    credentials: UserCredentials(
                              email: emailController.text,
                              password: passwordController.text,
                            )));
                          }
                        : null,
                    child: Text("Log in"),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New here?"),
                      TextButton(
                        onPressed: !(state is AuthenticationProcessInProgress)
                            ? () {
                                Navigator.of(context).pushNamed("/signUp");
                              }
                            : null,
                        child: Text("Register"),
                      ),
                    ],
                  )
                ],
              ),
              if (state is AuthenticationProcessInProgress)
                CircularProgressIndicator()
            ],
          ),
          listener: (context, state) {
            if (state is AuthenticationError) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is UserLoggedIn) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            }
          },
        ),
      ),
    );
  }
}
