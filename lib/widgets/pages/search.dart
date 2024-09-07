import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/dto/artist.dart';
import 'package:myapp/dto/genre.dart';
import 'package:myapp/dto/song.dart';
import 'package:myapp/dto/album.dart';
import 'package:myapp/store/song_store.dart';
import 'package:myapp/widgets/components/album_card.dart';
import 'package:myapp/widgets/components/artist_card.dart';
import 'package:myapp/widgets/components/genre_card.dart';
import 'package:myapp/widgets/components/song_card.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  createState() => SearchState();
}

class SearchState extends State<Search> {
  var queryValue = "";
  var selectedResult = "musics";
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SongStore>(context);

    final musics = store.songs;

    final artists = store.artists;

    final genres = store.genres;

    final albums = store.albums;

    final query = queryValue.toLowerCase();

    final getResult = (String name) => name == "musics"
        ? musics.where((music) =>
            music.metadata?.title?.toLowerCase().contains(query) ?? false)
        : name == "artists"
            ? artists
                .where((artist) => artist.name.toLowerCase().contains(query))
            : name == "genres"
                ? genres
                    .where((genre) => genre.name.toLowerCase().contains(query))
                : name == "albums"
                    ? albums.where(
                        (album) => album.name.toLowerCase().contains(query))
                    : [].where((a) => true);

    final result = getResult(selectedResult).toList();

    final resultCategory = [
      ResultType(icon: Icons.music_note, name: "musics", text: "músicas"),
      ResultType(icon: Icons.person, name: "artists", text: "artistas"),
      ResultType(icon: Icons.category, name: "genres", text: "gêneros"),
      ResultType(icon: Icons.disc_full, name: "albums", text: "albuns"),
      ResultType(
          icon: Icons.playlist_play, name: "playlists", text: "playlists")
    ];

    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: double.infinity,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  queryValue = value;
                });
              },
              decoration: const InputDecoration(
                  labelText: "pesquisa", prefixIcon: Icon(Icons.search)),
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: resultCategory
                  .map((category) => IconButton(
                      onPressed: () {
                        setState(() {
                          selectedResult = category.name;
                        });
                      },
                      icon: Badge(
                        smallSize: 40,
                        textStyle: const TextStyle(fontSize: 14),
                        label: Text(
                          getResult(category.name).length.toString(),
                        ),
                        isLabelVisible: true,
                        offset: const Offset(8, 15),
                        child: Icon(
                          category.icon,
                          size: 35,
                        ),
                      )))
                  .toList(),
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) {
              final value = result[index];

              if (value is Song) {
                return SongCard(song: value, playlist: result as List<Song>);
              } else if (value is Artist) {
                return ArtistCard(artist: value);
              } else if (value is Genre) {
                return GenreCard(
                  genre: value,
                );
              } else {
                return AlbumCard(album: value as Album);
              }
            }));
  }
}

class ResultType {
  IconData icon;
  String text;
  String name;

  ResultType({required this.icon, required this.text, required this.name});
}
