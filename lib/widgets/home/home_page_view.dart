import 'package:flutter/material.dart';
import 'package:waweezer_mobile/screens/admin_screens/users_list.dart';
import 'package:waweezer_mobile/screens/playlist/playlists_list.dart';
import 'package:waweezer_mobile/screens/song/songs_list.dart';
import 'package:waweezer_mobile/screens/user/user_profile.dart';

class HomePageView extends StatelessWidget {
  final PageController pageController;
  final Function(int) onPageChanged;

  const HomePageView({
    Key key,
    @required this.pageController,
    @required this.onPageChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: (value) {
        onPageChanged(value);
      },
      itemBuilder: (context, index) {
        if (index == 1) {
          return Builder(builder: (context) => PlaylistsList());
        } else if (index == 0) {
          return Builder(builder: (context) => SongsList());
        } else if (index == 4) {
          return Builder(builder: (context) => UserProfile());
        } else if (index == 3) {
          return UsersList();
        } else {
          return Container(
            child: Text("Placeholder"),
          );
        }
      },
    );
  }
}
