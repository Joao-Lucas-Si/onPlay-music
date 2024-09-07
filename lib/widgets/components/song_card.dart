import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/dto/song.dart';
import 'package:myapp/store/player_store.dart';
import 'package:myapp/store/song_store.dart';
import 'package:provider/provider.dart';

class SongCard extends StatelessWidget {
  final Song song;

  final List<Song>? playlist;

  const SongCard({super.key, required this.song, this.playlist});
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PlayerStore>(context);
    final newPlaylist = playlist != null
        ? [...playlist!.where((music) => music.path != song.path)]
        : [];
    newPlaylist.shuffle();
    return GestureDetector(
      onTap: () {
        store.playlist = [song, ...newPlaylist];
      },
      child: Column(
        children: [
          Text(
            song.title ?? "",
            textAlign: TextAlign.center,
          ),
          song.picture != null
              ? Image.memory(song.picture!)
              : const Icon(Icons.music_off, size: 200),
          Text(song.artist.target?.name ?? "desconhecido"),
        ],
      ),
    );
  }
}
