import 'package:flutter/material.dart';
import 'package:myapp/dto/album.dart';
import 'package:myapp/widgets/components/song_card.dart';

class AlbumScreen extends StatelessWidget {
  Album album;

  AlbumScreen({required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Expanded(
            child: Column(
          children: [
            album.picture != null
                ? Image.memory(album.picture!)
                : const Icon(Icons.person, size: double.maxFinite),
            Text(
              album.name,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: album.songs.length,
                  itemBuilder: (context, index) {
                    final song = album.songs[index];

                    return SongCard(
                      song: song,
                      playlist: album.songs,
                    );
                  }),
            )
          ],
        )));
  }
}
