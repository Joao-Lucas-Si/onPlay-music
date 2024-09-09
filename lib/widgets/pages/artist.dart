import 'package:flutter/material.dart';
import 'package:onPlay/dto/artist.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/widgets/components/album_card.dart';
import 'package:onPlay/widgets/components/song_card.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatelessWidget {
  final Artist artist;

  const ArtistScreen({required this.artist, super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SongStore>(context);
    print(artist.albums);
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          artist.picture != null
              ? Image.memory(artist.picture!,
                  width: MediaQuery.of(context).size.width / 0.6)
              : Icon(Icons.person,
                  size: MediaQuery.of(context).size.width / 0.6),
          Text(
            artist.name,
            textAlign: TextAlign.center,
          ),
          // Row(children: artist.albums.map((album) => AlbumCard(album: album)).toList(),)
          const Text(
            "Àlbuns",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: artist.albums.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    AlbumCard(album: artist.albums[index]),
              )),
          const Text(
            "Músicas",
            style: TextStyle(fontSize: 20),
          ),
          ...artist.songs
              .map((song) => SongCard(
                    song: song,
                    playlist: artist.songs,
                    showArtist: false,
                  ))
              .toList()
        ])));
  }
}
