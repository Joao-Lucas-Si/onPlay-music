import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/dto/album.dart';
import 'package:myapp/dto/artist.dart';
import 'package:myapp/services/player_service.dart';
import 'package:myapp/store/player_store.dart';
import 'package:myapp/store/song_store.dart';
import 'package:myapp/widgets/components/player.dart';
import 'package:myapp/widgets/components/mini_player.dart';
import 'package:myapp/widgets/pages/Artist.dart';
import 'package:myapp/widgets/pages/Config.dart';
import 'package:myapp/widgets/pages/album.dart';
import 'package:myapp/widgets/pages/main_screens.dart';
import 'package:myapp/widgets/pages/search.dart';
import 'package:myapp/widgets/pages/UserForm.dart';
import 'package:provider/provider.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => MainScreens(),
  ),
  GoRoute(
    path: "/settings",
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
    path: "/artist",
    builder: (context, state) =>
        _Layout(body: ArtistScreen(artist: state.extra as Artist)),
  ),
  GoRoute(path: "/player", builder: (context, state) => Player())
]);

class _Layout extends StatelessWidget {
  final Widget body;

  const _Layout({required this.body});

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<PlayerStore>(context);

    return Stack(
      children: [
        body,
        player.playingSong != null ? MiniPlayer() : const Stack()
      ],
    );
  }
}
