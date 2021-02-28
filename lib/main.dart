import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waweezer_mobile/bloc/authentication/authentication_event.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_data_provider.dart';
import 'package:waweezer_mobile/bloc/playlist/playlist_event.dart';
import 'package:waweezer_mobile/bloc/user/user_bloc.dart';
import 'package:waweezer_mobile/bloc/user/user_data_provider.dart';
import 'package:waweezer_mobile/bloc/user/user_repository.dart';
import 'package:waweezer_mobile/screens/home.dart';
import 'package:waweezer_mobile/screens/login.dart';
import 'package:waweezer_mobile/screens/sign_up.dart';
import 'package:waweezer_mobile/screens/splash.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/authentication/authentication_data_provider.dart';
import 'bloc/authentication/authentication_repository.dart';
import 'bloc/playlist/playlist_bloc.dart';
import 'bloc/playlist/playlist_repository.dart';
import 'bloc/song/song_bloc.dart';
import 'bloc/song/song_data_provider.dart';
import 'bloc/song/song_event.dart';
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
  final authenticationDataProvider =
      AuthenticationDataProvider(apiHelper: apiHelper);
  final authenticationRepository = AuthenticationRepository(
      authenticationDataProvider: authenticationDataProvider);
  final userDataProvider = UserDataProvider(apiHelper: apiHelper);
  final userRepository = UserRepository(userDataProvider: userDataProvider);
  runApp(MultiBlocProvider(providers: [
    //TODO: remove one of these events
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
      ),
    ),
    BlocProvider<UserBloc>(
      create: (context) => UserBloc(
        userRepository: userRepository,
      ),
    ),
  ], child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (context) => Home(),
        '/login': (context) => Login(),
        '/signUp': (context) => SignUp(),
        '/splash': (context) => Splash(),
      },
      initialRoute: "/splash",
    );
  }
}
