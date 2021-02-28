import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_event.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_state.dart';
import 'package:waweezer_mobile/bloc/user/user_bloc.dart';
import 'package:waweezer_mobile/bloc/user/user_event.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 5,
            ),
            Text(
              "Waweezer",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 4,
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is CheckAuthenticationStatusEvent) {
                  return CircularProgressIndicator();
                } else if (state is AuthenticationError ||
                    state is UserNotLoggedIn) {
                  return FlatButton(
                    onPressed: () async {
                      await Navigator.of(context).pushNamed('/login');
                    },
                    child: Text("Log in"),
                  );
                } else {
                  return Container();
                }
              },
              listener: (context, state) async {
                if (state is UserLoggedIn) {
                  await Navigator.of(context)
                      .pushNamedAndRemoveUntil('/home', (_) => false);
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
