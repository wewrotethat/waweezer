import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_data_provider.dart';
import 'package:waweezer_mobile/bloc/admin/user_role/user_role_repository.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_event.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_state.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_data_provider.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_event.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_bloc.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_data_provider.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_event.dart';
import 'package:waweezer_mobile/bloc/saved_playlist/saved_playlist_repository.dart';
import 'package:waweezer_mobile/bloc/user/user_bloc.dart';
import 'package:waweezer_mobile/bloc/user/user_data_provider.dart';
import 'package:waweezer_mobile/bloc/user/user_repository.dart';
import 'package:waweezer_mobile/screens/home.dart';
import 'package:waweezer_mobile/screens/login.dart';
import 'package:waweezer_mobile/screens/sign_up.dart';
import 'package:waweezer_mobile/screens/splash.dart';

import 'bloc/admin/user_role/user_role_bloc.dart';
import 'bloc/admin/user_role/user_role_event.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/authentication/authentication_data_provider.dart';
import 'bloc/authentication/authentication_repository.dart';
import 'bloc/playlist/playlist_bloc.dart';
import 'bloc/playlist/playlist_repository.dart';
import 'bloc/song/song_bloc.dart';
import 'bloc/song/song_data_provider.dart';
import 'bloc/song/song_repository.dart';
import 'helpers/api_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final apiHelper = APIHelper();
  final songDataProvider = SongDataProvider(apiHelper: apiHelper);
  final songRepository = SongRepository(songDataProvider: songDataProvider);
  final playlistDataProvider = PlaylistDataProvider(apiHelper: apiHelper);
  final playlistRepository =
      PlaylistRepository(playlistDataProvider: playlistDataProvider);
  final userDataProvider = UserDataProvider(apiHelper: apiHelper);
  final userRepository = UserRepository(userDataProvider: userDataProvider);
  final authenticationDataProvider =
      AuthenticationDataProvider(apiHelper: apiHelper);
  final authenticationRepository = AuthenticationRepository(
      authenticationDataProvider: authenticationDataProvider,
      userDataProvider: userDataProvider);
  final userRoleDataProvider = UserRoleDataProvider(apiHelper: APIHelper());
  final userRoleRepository =
      UserRoleRepository(userRoleDataProvider: userRoleDataProvider);
  final savedPlaylistDataProvider =
      SavedPlaylistDataProvider(apiHelper: apiHelper);
  final savedPlaylistRepository = SavedPlaylistRepository(
      savedPlaylistDataProvider: savedPlaylistDataProvider);

  runApp(MultiBlocProvider(providers: [
    BlocProvider<SongBloc>(
      create: (context) => SongBloc(
        songRepository: songRepository,
      ),
    ),
    BlocProvider<PlaylistBloc>(
      create: (context) => PlaylistBloc(
        playlistRepository: playlistRepository,
      ),
    ),
    BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      )..add(CheckAuthenticationStatusEvent()),
    ),
    BlocProvider<UserBloc>(
      create: (context) => UserBloc(
        userRepository: userRepository,
      ),
    ),
    BlocProvider<UserRoleBloc>(
      create: (context) => UserRoleBloc(userRoleRepository: userRoleRepository)
        ..add(
          ReadUsersEvent(),
        ),
    ),
    BlocProvider<SavedPlaylistBloc>(
      create: (context) =>
          SavedPlaylistBloc(savedPlaylistRepository: savedPlaylistRepository)
            ..add(
              ReadSavedPlaylistsEvent(),
            ),
    ),
  ], child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (context) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is UserLoggedIn &&
                  state.user.role?.toLowerCase() == 'admin') {
                return Home(isAdmin: true);
              } else {
                return Home(isAdmin: false);
              }
            },
          );
        },
        '/login': (context) => Login(),
        '/signUp': (context) => SignUp(),
        '/splash': (context) => Splash(),
      },
      initialRoute: "/splash",
    );
  }
}
