import 'package:flutter/material.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/playlist_card.dart';
import 'package:provider/provider.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});
  @override
  Widget build(BuildContext context) {
    final managers = Provider.of<BoxManager>(context);

    final userManager = managers.userManager;
    // final PlaylistManager
    final user = userManager.getActiveProfile();

    final playlists = user.playlists;

    debugPrint(playlists.length.toString());
    final settings = Provider.of<Settings>(context);
    final gridItems = settings.layout.playlistGridItems;
    return gridItems == 1
        ? Scaffold(
            body: ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];

                return PlaylistCard(playlist: playlist);
              },
            ),
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridItems),
            itemCount: playlists.length,
            itemBuilder: (context, index) => PlaylistCard(
              playlist: playlists[index],
              key: ValueKey(playlists[index].id),
            ),
          );
  }
}
