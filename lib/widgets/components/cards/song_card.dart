import 'package:flutter/material.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/cards/mini_artist_card.dart';
import 'package:onPlay/widgets/components/popup/music_popup.dart';
import 'package:provider/provider.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final bool showArtist;

  final List<Song>? playlist;

  const SongCard(
      {super.key, this.showArtist = true, required this.song, this.playlist});
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
          song.picture != null
              ? Image.memory(song.picture!)
              : const Icon(Icons.music_off, size: 200),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(
                  song.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                )),
            MusicPopup(song: song)
          ]),
          song.artist.target != null && showArtist
              ? MiniArtistCard(artist: song.artist.target!)
              : Container(
                  width: 0,
                )
        ],
      ),
    );
  }
}
