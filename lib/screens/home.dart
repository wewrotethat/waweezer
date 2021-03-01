import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_bloc.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_event.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_state.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_bloc.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_data_provider.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_event.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_repository.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_bloc.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_event.dart';
import 'package:waweezer_mobile/bloc/song/song_bloc.dart';
import 'package:waweezer_mobile/bloc/song/song_data_provider.dart';
import 'package:waweezer_mobile/bloc/song/song_event.dart';
import 'package:waweezer_mobile/bloc/song/song_repository.dart';
import 'package:waweezer_mobile/bloc/user/user_bloc.dart';
import 'package:waweezer_mobile/bloc/user/user_event.dart';
import 'package:waweezer_mobile/bloc/user/user_state.dart';
import 'package:waweezer_mobile/helpers/api_helper.dart';
import 'package:waweezer_mobile/screens/playlist/create_playlist.dart';
import 'package:waweezer_mobile/screens/song/create_song.dart';
import 'package:waweezer_mobile/widgets/home/home_bottom_nav_bar.dart';
import 'package:waweezer_mobile/widgets/home/home_page_view.dart';

class Home extends StatefulWidget {
  final bool isAdmin;

  const Home({Key key, @required this.isAdmin}) : super(key: key);
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
    readCurrentItems();
  }

  void readCurrentItems() {
    if (pageController.page == 0) {
      BlocProvider.of<SongBloc>(context).add(
        ReadSongsEvent(),
      );
    } else if (pageController.page == 1) {
      BlocProvider.of<PlaylistBloc>(context).add(
        ReadPlaylistsEvent(),
      );
    } else if (pageController.page == 2) {
      BlocProvider.of<SavedPlaylistBloc>(context).add(
        ReadSavedPlaylistsEvent(),
      );
    } else if (pageController.page == 3) {
      BlocProvider.of<UserBloc>(context).add(
        ReadUserEvent(),
      );
    } else if (pageController.page == 4) {
      var state = BlocProvider.of<AuthenticationBloc>(context).state;
      if (state is UserLoggedIn && state.user.role?.toLowerCase() == 'admin') {
        BlocProvider.of<UserRoleBloc>(context).add(
          ReadUsersEvent(),
        );
      }
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      readCurrentItems();
    });
    tabController = TabController(
        length: widget.isAdmin ? 5 : 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) async {
            if (state is UserOperationFailed) {
              await showDialog(
                context: context,
                child: AlertDialog(
                  actions: [
                    FlatButton(
                      child: Text("Retry"),
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context)
                          ..add(ReadUserEvent());
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                  content: Text(state.error),
                ),
              );
            }
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            if (state is UserNotLoggedIn) {
              await Navigator.of(context)
                  .pushNamedAndRemoveUntil("/login", (route) => false);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Waweezer"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () async {
                readCurrentItems();
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
            : Container(),
      ),
    );
  }
}
