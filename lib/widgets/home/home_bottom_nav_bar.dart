import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_state.dart';
import 'package:waweezer_mobile/resources/constants.dart';

class HomeBottomNavBar extends StatelessWidget {
  final TabController controller;
  final Function(int) onTabChanged;
  HomeBottomNavBar({
    Key key,
    @required this.controller,
    @required this.onTabChanged,
  }) : super(key: key) {
    assert(controller != null);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 8,
      shape: CircularNotchedRectangle(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        return TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.music_note),
            ),
            Tab(
              icon: Icon(Icons.queue_music),
            ),
            Tab(
              icon: Icon(Icons.favorite),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
            if (state is UserLoggedIn &&
                state.user.role?.toLowerCase() == 'admin')
              Tab(
                icon: Icon(Icons.people),
              ),
          ],
          controller: controller,
          labelStyle: TextStyle(fontSize: 10),
          labelColor: primaryColor,
          unselectedLabelColor: Colors.grey,
          isScrollable: false,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: UnderlineTabIndicator(
            insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 45.0),
            borderSide: BorderSide(color: primaryColor, width: 3),
          ),
          onTap: (value) {
            onTabChanged(value);
          },
        );
      }),
    );
  }
}
