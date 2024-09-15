import 'package:flutter/material.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/widgets/components/cards/mini_artist_card.dart';
import 'package:onPlay/widgets/components/cards/song_card.dart';

class AlbumScreen extends StatelessWidget {
  final Album album;

  const AlbumScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            album.picture != null
                ? Image.memory(album.picture!)
                : const Icon(Icons.person, size: double.maxFinite),
            Text(
              album.name,
              textAlign: TextAlign.center,
            ),
            album.artist.target != null
                ? MiniArtistCard(artist: album.artist.target!)
                : Container(
                    height: 0,
                    width: 0,
                  ),
            ...album.songs.map(
              (song) => SongCard(
                song: song,
                playlist: album.songs,
              ),
            )
          ],
        )));
  }
}
