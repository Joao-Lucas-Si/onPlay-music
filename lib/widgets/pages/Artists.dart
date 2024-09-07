import 'package:flutter/material.dart';
import 'package:myapp/dto/artist.dart';
import 'package:myapp/store/song_store.dart';
import 'package:myapp/widgets/components/artist_card.dart';
import 'package:provider/provider.dart';

class Artists extends StatefulWidget {
  @override
  createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  late SongStore store;

  List<Artist> get artists {
    List<Artist> artists = List.from(store.artists);

    return store.artistOrder == "desc" ? artists.reversed.toList() : artists;
  }

  @override
  Widget build(BuildContext context) {
    store = Provider.of<SongStore>(context);
    return Scaffold(
      body: store.loading != ""
          ? Text(store.loading)
          : ListView.builder(
              itemCount: artists.length,
              itemBuilder: (context, index) {
                final artist = artists[index];
                return ArtistCard(artist: artist);
              }),
    );
  }
}
