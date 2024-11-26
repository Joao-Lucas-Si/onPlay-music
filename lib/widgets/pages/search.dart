import 'package:flutter/material.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/services/colors/color_type.dart';
import 'package:onPlay/store/content/album_store.dart';
import 'package:onPlay/store/content/artist_store.dart';
import 'package:onPlay/store/content/genre_store.dart';
import 'package:onPlay/store/content/song_store.dart';
import 'package:onPlay/widgets/components/cards/album_card.dart';
import 'package:onPlay/widgets/components/cards/artist_card.dart';
import 'package:onPlay/widgets/components/cards/genre_card.dart';
import 'package:onPlay/widgets/components/cards/song_card.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  createState() => SearchState();
}

class SearchState extends State<Search> {
  var queryValue = "";
  var selectedResult = "musics";
  Color? colorQuery;

  List<Song> musics = [];

  List<Artist> artists = [];

  List<Genre> genres = [];

  List<Album> albums = [];

  List<Song> searchMusics(String query) => musics
      .where((music) =>
          music.title.toLowerCase().contains(query) &&
          (colorQuery == null ||
              getColorGroup(colorQuery!) ==
                  getColorGroup(music.currentColors(context).background)))
      .toList();

  List<Album> searchAlbums(String query) => albums
      .where((album) =>
          album.name.toLowerCase().contains(query) &&
          (colorQuery == null ||
              getColorGroup(colorQuery!) ==
                  getColorGroup(album.getColors(context).background)))
      .toList();

  List<Artist> searchArtists(String query) => artists
      .where((artist) =>
          artist.name.toLowerCase().contains(query) &&
          (colorQuery == null ||
              getColorGroup(colorQuery!) ==
                  getColorGroup(artist.getColors(context).background)))
      .toList();

  List<Genre> searchGenres(String query) => genres
      .where((genre) =>
          genre.name.toLowerCase().contains(query) &&
          (colorQuery == null ||
              getColorGroup(colorQuery!) ==
                  getColorGroup(genre.getColors(context).background)))
      .toList();

  List<dynamic> search(String name, String query) => name == "musics"
      ? searchMusics(query)
      : name == "artists"
          ? searchArtists(query)
          : name == "genres"
              ? searchGenres(query)
              : name == "albums"
                  ? searchAlbums(query)
                  : [];

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SongStore>(context);
    final albumStore = Provider.of<AlbumStore>(context);
    final artistStore = Provider.of<ArtistStore>(context);
    final genreStore = Provider.of<GenreStore>(context);
    musics = store.songs;

    artists = artistStore.artists;

    genres = genreStore.genres;

    albums = albumStore.albums;

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
          actions: [
            GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Filtro por cor"),
                      content: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: [
                            Colors.red,
                            Colors.green,
                            Colors.black,
                            Colors.pink,
                            Colors.purple,
                            Colors.blue,
                            Colors.white,
                            Colors.grey,
                            Colors.orange,
                            Colors.yellow,
                            Colors.brown
                          ]
                              .map((color) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      colorQuery = color;
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      color: color,
                                    ),
                                  )))
                              .toList()),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                colorQuery = null;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("resetar")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("fechar"))
                      ],
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.grey[500],
                  child: Container(
                    width: 50,
                    height: 50,
                    color: colorQuery ?? Colors.white54,
                  ),
                ))
          ],
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
                          search(category.name, query).length.toString(),
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
