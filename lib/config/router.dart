import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/widgets/components/player.dart';
import 'package:onPlay/widgets/components/mini_player.dart';
import 'package:onPlay/widgets/pages/artist.dart';
import 'package:onPlay/widgets/pages/genre.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';
import 'package:onPlay/widgets/pages/album.dart';
import 'package:onPlay/widgets/pages/main-screens/main_screens.dart';
import 'package:onPlay/widgets/pages/player_screen.dart';
import 'package:onPlay/widgets/pages/search.dart';
import 'package:onPlay/widgets/pages/song_form.dart';
import 'package:onPlay/widgets/pages/user_form.dart';
import 'package:onPlay/widgets/pages/settings/about.dart';
import 'package:provider/provider.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => MainScreens(),
  ),
  GoRoute(
    path: "/settings",
    routes: [
      GoRoute(
        path: "about",
        builder: (context, state) => _Layout(body: About()),
      )
    ],
    builder: (context, state) => _Layout(body: Config()),
  ),
  GoRoute(
    path: "/search",
    builder: (context, state) => _Layout(body: Search()),
  ),
  GoRoute(
      path: "/user", builder: (context, state) => _Layout(body: UserForm())),
  GoRoute(
    path: "/album",
    builder: (context, state) =>
        _Layout(body: AlbumScreen(album: state.extra as Album)),
  ),
  GoRoute(
      path: "/genre",
      builder: (context, state) => _Layout(
            body: GenreScreen(genre: state.extra as Genre),
          )),
  GoRoute(
    path: "/artist",
    builder: (context, state) =>
        _Layout(body: ArtistScreen(artist: state.extra as Artist)),
  ),
  GoRoute(path: "/player", builder: (context, state) => Player()),
  GoRoute(
      path: SongForm.url,
      builder: (context, state) => SongForm(song: state.extra as Song))
]);

class _Layout extends StatelessWidget {
  final Widget body;

  const _Layout({required this.body});

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<PlayerStore>(context);

    return Scaffold(
        body: Stack(
      children: [
        body,
        player.playingSong != null
            ? PlayerScreen(
                inMainScreen: false,
              )
            : const Stack()
      ],
    ));
  }
}
