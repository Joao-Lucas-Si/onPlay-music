import 'package:flutter/material.dart';
import 'package:myapp/dto/artist.dart';
import 'package:myapp/store/song_store.dart';
import 'package:myapp/widgets/components/genre_card.dart';
import 'package:provider/provider.dart';

class Genres extends StatefulWidget {
  @override
  createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  late SongStore store;

  @override
  Widget build(BuildContext context) {
    store = Provider.of<SongStore>(context);
    final genres = store.genres;
    return Scaffold(
      body: store.loading != ""
          ? Text(store.loading)
          : ListView.builder(
              itemCount: genres.length,
              itemBuilder: (context, index) {
                final genre = genres[index];
                return GenreCard(genre: genre);
              }),
    );
  }
}
