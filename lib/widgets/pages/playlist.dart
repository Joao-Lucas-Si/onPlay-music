import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/playlist.dart';
import 'package:onPlay/widgets/components/cards/song_card.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist playlist;

  const PlaylistPage({required this.playlist, super.key});
  static const path = "/playlist";
  static void navigate(BuildContext context, Playlist extra) {
    GoRouter.of(context).push(path, extra: extra);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          playlist.image != null
              ? Image.memory(playlist.image!)
              : const Icon(Icons.playlist_play),
          Text(playlist.name),
          SizedBox(
            height: 320,
            child: ListView.builder(
              itemCount: playlist.songs.length,
              itemBuilder: (context, index) => SongCard(
                  song: playlist.songs[index],
                  playlist: playlist.songs,
                  key: ValueKey(
                    playlist.songs[index].id,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
