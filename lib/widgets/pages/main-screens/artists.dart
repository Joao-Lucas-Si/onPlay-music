import 'package:flutter/material.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/store/content/artist_store.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/artist_card.dart';
import 'package:provider/provider.dart';

class Artists extends StatefulWidget {
  const Artists({super.key});
  @override
  createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists> {
  late ArtistStore store;

  List<Artist> get artists {
    List<Artist> artists = List.from(store.artists);

    //return store.artistOrder == "desc" ? artists.reversed.toList() : artists;
    return artists;
  }

  @override
  Widget build(BuildContext context) {
    store = Provider.of<ArtistStore>(context);
    final settings = Provider.of<Settings>(context);
    final gridItems = settings.layout.artistGridItems;
    return Scaffold(
      body:
          // store.loading != ""
          //     ? Text(store.loading)
          //     :
          (gridItems == 1
              ? ListView.builder(
                  itemCount: artists.length,
                  itemBuilder: (context, index) {
                    final artist = artists[index];
                    return ArtistCard(
                      artist: artist,
                      key: ValueKey(artist.id),
                    );
                  })
              : GridView.builder(
                  itemCount: artists.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridItems),
                  itemBuilder: (context, index) => ArtistCard(
                    artist: artists[index],
                    key: ValueKey(artists[index].id),
                  ),
                )),
    );
  }
}
