import 'package:flutter/material.dart';
import 'package:onPlay/store/content/genre_store.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/genre_card.dart';
import 'package:provider/provider.dart';

class Genres extends StatefulWidget {
  const Genres({super.key});
  @override
  createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  late GenreStore store;

  @override
  Widget build(BuildContext context) {
    store = Provider.of<GenreStore>(context);
    final genres = store.genres;
    final settings = Provider.of<Settings>(context);
    final gridItems = settings.layout.genreGridItems;
    return Scaffold(
      body:
          // store.loading != ""
          //     ? Text(store.loading)
          //     :
          (gridItems == 1
              ? ListView.builder(
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    final genre = genres[index];
                    return GenreCard(
                      genre: genre,
                      key: ValueKey(genre.id),
                    );
                  })
              : GridView.builder(
                  itemCount: genres.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridItems),
                  itemBuilder: (context, index) => GenreCard(
                    genre: genres[index],
                    key: ValueKey(genres[index].id),
                  ),
                )),
    );
  }
}
