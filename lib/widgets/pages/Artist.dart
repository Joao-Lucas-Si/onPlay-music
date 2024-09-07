import 'package:flutter/material.dart';
import 'package:myapp/dto/artist.dart';
import 'package:myapp/store/song_store.dart';
import 'package:myapp/widgets/components/album_card.dart';
import 'package:myapp/widgets/components/song_card.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatelessWidget {
  Artist artist;

  ArtistScreen({required this.artist, super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SongStore>(context);

    return Scaffold(
        appBar: AppBar(),
        body: Expanded(
            child: Column(
          children: [
            artist.picture != null
                ? Image.memory(artist.picture!,
                    width: MediaQuery.of(context).size.width / 0.6)
                : Icon(Icons.person,
                    size: MediaQuery.of(context).size.width / 0.6),
            Text(
              artist.name,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: artist.songs.length,
                  itemBuilder: (context, index) {
                    final song = artist.songs[index];

                    return SongCard(song: song, playlist: artist.songs,);
                  }),
            )
          ],
        )));
  }
}
