import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/models/playlist.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/player/player.dart';
import 'package:onPlay/widgets/pages/artist.dart';
import 'package:onPlay/widgets/pages/genre.dart';
import 'package:onPlay/widgets/pages/home/home.dart';
import 'package:onPlay/widgets/pages/home/recent.dart';
import 'package:onPlay/widgets/pages/playlist.dart';
import 'package:onPlay/widgets/pages/profiles.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';
import 'package:onPlay/widgets/pages/album.dart';
import 'package:onPlay/widgets/pages/main-screens/main_screens.dart';
import 'package:onPlay/widgets/pages/player_screen.dart';
import 'package:onPlay/widgets/pages/search.dart';
import 'package:onPlay/widgets/pages/settings/files.dart';
import 'package:onPlay/widgets/pages/settings/interface.dart';
import 'package:onPlay/widgets/pages/settings/layout.dart';
import 'package:onPlay/widgets/pages/settings/player.dart';
import 'package:onPlay/widgets/pages/settings/share.dart';
import 'package:onPlay/widgets/pages/song_form.dart';
import 'package:onPlay/widgets/pages/user_form.dart';
import 'package:onPlay/widgets/pages/settings/about.dart';
import 'package:provider/provider.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => MainScreen(
      key: state.extra as UniqueKey?,
    ),
  ),
  GoRoute(path: Home.path, redirect: (context, state) => Recents.path, routes: [
    GoRoute(
      path: Recents.route,
      builder: (context, state) => _Layout(body: Recents()),
    )
  ]),
  GoRoute(
    path: Config.path,
    routes: [
      GoRoute(
        path: About.route,
        builder: (context, state) => const _Layout(body: About()),
      ),
      GoRoute(
        path: InterfaceSettingsScreen.route,
        builder: (context, state) =>
            const _Layout(body: InterfaceSettingsScreen()),
      ),
      GoRoute(
        path: LayoutSettingsScreen.route,
        builder: (context, state) =>
            const _Layout(body: LayoutSettingsScreen()),
      ),
      GoRoute(
        path: PlayerSettingsScreens.route,
        builder: (context, state) =>
            const _Layout(body: PlayerSettingsScreens()),
      ),
      GoRoute(
        path: FilesSettingsScreen.route,
        builder: (context, state) => const _Layout(body: FilesSettingsScreen()),
      ),
      GoRoute(
        path: ShareSettingsScreen.route,
        builder: (context, state) => const _Layout(body: ShareSettingsScreen()),
      ),
    ],
    builder: (context, state) => const _Layout(body: Config()),
  ),
  GoRoute(
    path: "/search",
    builder: (context, state) => const _Layout(body: Search()),
  ),
  GoRoute(
      path: "/user",
      builder: (context, state) =>
          _Layout(body: UserForm(newUser: state.extra as bool? ?? false))),
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
  GoRoute(path: "/player", builder: (context, state) => const Player()),
  GoRoute(
      path: SongForm.url,
      builder: (context, state) => SongForm(song: state.extra as Song)),
  GoRoute(
    path: ProfilesPage.path,
    builder: (context, state) => ProfilesPage(
      key: UniqueKey(),
    ),
  ),
  GoRoute(
    path: PlaylistPage.path,
    builder: (context, state) =>
        _Layout(body: PlaylistPage(playlist: state.extra as Playlist)),
  )
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
            ? const PlayerScreen(
                inMainScreen: false,
              )
            : const Stack()
      ],
    ));
  }
}
