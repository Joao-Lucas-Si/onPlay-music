import 'package:flutter/material.dart';
import 'package:onPlay/database/objectbox.dart';
import 'package:onPlay/database/objectbox.g.dart';
import 'package:onPlay/dto/artist.dart';
import 'package:onPlay/dto/genre.dart';
import 'package:onPlay/dto/song.dart';
import 'package:onPlay/dto/album.dart';
import 'package:onPlay/services/FilesService.dart';
import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart';

class SongStore extends ChangeNotifier {
  List<Song> _songs = [];
  late ObjectBox _objectBox;
  String _loading = "";
  List<Artist> _artists = [];
  String _sort = "modification_date";
  String _order = "desc";
  String _artistSort = "name";
  String _artistOrder = "desc";
  List<Genre> _genres = [];
  List<Album> _albums = [];

  List<Album> get albums => _albums;

  List<Genre> get genres => _genres;

  String get artistSort => _artistSort;

  String get artistOrder => _artistOrder;

  set artistSort(String value) {
    _artistSort = value;
    notifyListeners();
  }

  set artistOrder(String value) {
    _artistOrder = value;
    notifyListeners();
  }

  String get order => _order;

  String get sort => _sort;

  set order(String value) {
    _order = value;
    notifyListeners();
  }

  set sort(String value) {
    _sort = value;
    notifyListeners();
  }

  List<Artist> get artists => _artists;

  String get loading => _loading;

  List<Song> get songs => _songs;

  SongStore() {
    _getData();
  }

  // _saveLocal(_SongStoreData data) async {
  //   final prefs = SharedPreferencesAsync();

  //   prefs.setString(_key, json.encode(data));
  // }

  // Future<_SongStoreData?> _getLocal() async {
  //   final prefs = SharedPreferencesAsync();

  //   final jsonStr = await prefs.getString(_key);

  //   return jsonStr != null
  //       ? _SongStoreData.fromJson(json.decode(jsonStr))
  //       : null;
  // }

  _setLoading(String loading) {
    _loading = loading;
    notifyListeners();
  }

  _getArtists() {
    _setLoading("procurando artistas");
    List<Artist> artists = [];
    for (final song in songs) {
      var artist = artists.firstWhereOrNull((value) =>
          value.name.toLowerCase() ==
          (song.metadata?.artist?.toLowerCase() ?? "desconhecido"));
      if (artist != null) {
        if (artist.picture == null && song.picture != null) {
          artist.picture = song.picture;
        }
        artist.songs.add(song);
      } else {
        artist = Artist(
            name: song.metadata?.artist ?? "desconhecido",
            picture: song.picture);
        artist.songs.add(song);
        artists.add(artist);
      }
      song.artist.target = artist;
    }
    _setLoading("");
    _artists = artists;
    notifyListeners();
  }

  _getGenres() {
    _setLoading("procurando gêneros");
    List<Genre> genres = [];
    for (final song in songs) {
      var genre = genres.firstWhereOrNull(
          (value) => value.name == (song.metadata?.genre ?? "desconhecido"));
      if (genre != null) {
        if (genre.picture == null && song.picture != null) {
          genre.picture = song.picture;
        }
        genre.songs.add(song);
      } else {
        genre = Genre(
            name: song.metadata?.genre ?? "desconhecido",
            picture: song.picture);
        genre.songs.add(song);
        genres.add(genre);
      }
    }
    _setLoading("");
    _genres = genres;
    notifyListeners();
  }

  _getAlbums() {
    _setLoading("procurando albuns");
    List<Album> albums = [];
    for (final song in songs) {
      var album = albums.firstWhereOrNull((value) =>
          value.name == (song.metadata?.album ?? "desconhecido") &&
          value.artist.target?.name.toLowerCase() ==
              song.artist.target?.name.toLowerCase());
      if (album != null) {
        if (album.picture == null && song.picture != null) {
          album.picture = song.picture;
        }
        album.songs.add(song);
      } else {
        final artist = artists.firstWhereOrNull((artist) =>
            artist.name.toLowerCase() ==
            song.artist.target?.name.toLowerCase());

        album = Album(
            name: song.metadata?.album ?? "desconhecido",
            picture: song.picture);
        album.artist.target = artist;
        album.songs.add(song);
        if (artist != null) artist.albums.add(album);
        albums.add(album);
      }
    }
    _setLoading("");
    _albums = albums;
    notifyListeners();
  }

  Future<bool> _getDataFromDb() async {
    _objectBox = await ObjectBox.create();

    final songBox = _objectBox.boxSong;
    final albumBox = _objectBox.albumBox;
    final artistBox = _objectBox.artistBox;
    final genreBox = _objectBox.genreBox;

    print(songBox.count());
    if (songBox.count() == 0) {
      return false;
    } else {
      _songs = songBox.getAll();
      _albums = albumBox.getAll();
      _artists = artistBox.getAll();
      _genres = genreBox.getAll();
      return true;
    }
  }

  _saveToDb() {
    final songBox = _objectBox.boxSong;
    final albumBox = _objectBox.albumBox;
    final artistBox = _objectBox.artistBox;
    final genreBox = _objectBox.genreBox;

    songBox.removeAll();
    albumBox.removeAll();
    artistBox.removeAll();
    genreBox.removeAll();
    songBox.putMany(_songs);
    albumBox.putMany(_albums);
    artistBox.putMany(_artists);
    genreBox.putMany(_genres);
  }

  _getDataFromFiles() {
    FilesService.getAllMusics(_setLoading).then((songs) async {
      _songs = songs;
      notifyListeners();
      _getArtists();
      _getGenres();
      _getAlbums();
      await _saveToDb();
    });
    // _saveLocal(_SongStoreData(
    //     songs: songs, artists: artists, genres: genres, albums: albums));
  }

  refresh() {
    _getDataFromFiles();
  }

  _getData() async {
    final collected = await _getDataFromDb();

    if (collected == false) {
      await _getDataFromFiles();
    }
  }
}
