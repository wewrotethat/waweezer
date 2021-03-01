import 'package:flutter/material.dart';
import 'package:waweezer_mobile/screens/admin_screens/users_list.dart';
import 'package:waweezer_mobile/screens/playlist/playlists_list.dart';
import 'package:waweezer_mobile/screens/saved_playlists/saved_playlists_list.dart';
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
        if (index == 0) {
          return SongsList();
        } else if (index == 1) {
          return PlaylistsList();
        } else if (index == 2) {
          return SavedPlaylistsList();
        } else if (index == 3) {
          return UserProfile();
        } else if (index == 4) {
          return UsersList();
        }
      },
    );
  }
}
