import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_data_provider.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_event.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_repository.dart';
import 'package:waweezer_mobile/bloc/song/song_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_data_provider.dart';
import 'package:waweezer_mobile/bloc/song/song_event.dart';
import 'package:waweezer_mobile/bloc/song/song_repository.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/screens/playlist/create_playlist.dart';
import 'package:waweezer_mobile/screens/song/create_song.dart';
import 'package:waweezer_mobile/widgets/home/home_bottom_nav_bar.dart';
import 'package:waweezer_mobile/widgets/home/home_page_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //tab and page view controllers
  TabController tabController;
  final PageController pageController = PageController(initialPage: 1);

  //Bloc related fields
  APIHelper apiHelper;
  SongDataProvider songDataProvider;
  SongRepository songRepository;
  PlaylistDataProvider playlistDataProvider;
  PlaylistRepository playlistRepository;

  void onTabChanged(int index) {
    if (pageController.page != index) {
      setState(() {
        pageController.jumpToPage(index);
      });
    }
  }

  void onPageChanged(int index) {
    if (tabController.index != index) {
      setState(() {
        tabController.animateTo(index);
      });
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Waweezer"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () async {
                if (pageController.page == 0) {
                  BlocProvider.of<SongBloc>(context).add(
                    ReadSongsEvent(),
                  );
                } else if (pageController.page == 1) {
                  BlocProvider.of<PlaylistBloc>(context).add(
                    ReadPlaylistsEvent(),
                  );
                }
              },
            )
          ],
        ),
        body: HomePageView(
            pageController: pageController, onPageChanged: onPageChanged),
        bottomNavigationBar: HomeBottomNavBar(
          controller: tabController,
          onTabChanged: onTabChanged,
        ),
        floatingActionButton: tabController.index == 0 ||
                tabController.index == 1
            ? FloatingActionButton(
                onPressed: () {
                  if (tabController.index == 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateSong(),
                    ));
                  } else if (tabController.index == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreatePlaylist(),
                    ));
                  }
                },
                child: Icon(
                    tabController.index == 0 ? Icons.add : Icons.playlist_add),
              )
            : Container());
  }
}
