import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/widgets/components/album_card.dart';
import 'package:onPlay/widgets/components/artist_card.dart';
import 'package:onPlay/widgets/components/genre_card.dart';
import 'package:onPlay/widgets/components/song_card.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  createState() => SearchState();
}

class SearchState extends State<Search> {
  var queryValue = "";
  var selectedResult = "musics";

  List<Song> musics = [];

  List<Artist> artists = [];

  List<Genre> genres = [];

  List<Album> albums = [];

  List<Song> searchMusics(String query) => musics
      .where((music) => music.title.toLowerCase().contains(query))
      .toList();

  List<Album> searchAlbums(String query) => albums
      .where((album) => album.name.toLowerCase().contains(query))
      .toList();

  List<Artist> searchArtists(String query) => artists
      .where((artist) => artist.name.toLowerCase().contains(query))
      .toList();

  List<Genre> searchGenres(String query) => genres
      .where((genre) => genre.name.toLowerCase().contains(query))
      .toList();

  List<dynamic> search(String name, String query) => name == "musics"
      ? searchMusics(query)
      : name == "artists"
          ? searchArtists(query)
          : name == "genres"
              ? searchGenres(query)
              : name == "albums"
                  ? searchAlbums(query)
                  : [].where((a) => true).toList();

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SongStore>(context);

    musics = store.songs;

    artists = store.artists;

    genres = store.genres;

    albums = store.albums;

    final query = queryValue.toLowerCase();

    final result = search(selectedResult, query);

    final colorScheme = Theme.of(context).colorScheme;

    final resultCategory = [
      ResultType(
        icon: Icons.music_note,
        name: "musics",
        text: "músicas",
      ),
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
              decoration: InputDecoration(
                  labelText: "pesquisa",
                  labelStyle: TextStyle(color: colorScheme.secondary),
                  fillColor: colorScheme.secondary,
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.secondary,
                  )),
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
                        backgroundColor: colorScheme.secondary,
                        textColor: colorScheme.tertiary,
                        textStyle: const TextStyle(fontSize: 14),
                        label: Text(
                          search(category.name, "").length.toString(),
                        ),
                        isLabelVisible: true,
                        offset: const Offset(8, 15),
                        child: Icon(
                          category.icon,
                          size: 35,
                          color: colorScheme.secondary,
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
