import 'package:flutter/material.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/managers/genre_manager.dart';
import 'package:onPlay/models/song.dart';
import "package:collection/collection.dart";

class GenreStore extends ChangeNotifier {
  late GenreManager _manager;
  var _genres = <Genre>[];

  List<Genre> get genres => _genres;

  GenreStore(BuildContext context);

  extractAllGenres(List<Song> songs) {
    // _genres = [];
    for (final song in songs) {
      // final genre =
      extractFromSong(song);
    }
  }

  GenreStore init(BoxManager boxManager) {
    if (boxManager.started) {
      _manager = boxManager.genreManager;
    }
    return this;
  }

  Genre _extractFromOnlineSong(Song song) {
    var genre = _genres.firstWhereOrNull((value) =>
        value.name.toLowerCase() ==
        (song.metadata?.genre?.toLowerCase() ?? "desconhecido"));

    genre ??= Genre(name: "desconhecido");
    return genre;
  }

  Genre _extractFromName(String name) {
    final genreName = name.trim() == "" ? "desconhecido" : name;
    var genre = _genres.firstWhereOrNull(
        (value) => value.name.toLowerCase() == (genreName.toLowerCase()));

    genre ??= Genre(name: genreName);
    return genre;
  }

  Genre _extractFromLocalSong(Song song) {
    var genre = _genres.firstWhereOrNull((value) =>
        value.name.toLowerCase() ==
        (song.metadata?.genre?.toLowerCase() ?? "desconhecido"));

    genre ??= Genre(
      name: (song.metadata != null &&
              song.metadata!.genre != null &&
              song.metadata!.genre!.trim() != "")
          ? song.metadata!.genre!
          : "desconhecido",
    );
    return genre;
  }

  Genre extractFromSong(Song song, {String? name}) {
    Genre genre = name != null
        ? _extractFromName(name)
        : (song.isOnline
            ? _extractFromOnlineSong(song)
            : _extractFromLocalSong(song));

    if (!genre.songs.contains(song)) genre.songs.add(song);
    song.genre.target = genre;
    _addGenre(genre);
    return genre;
  }

  _addGenre(Genre genre) {
    if (!_genres.contains(genre)) {
      _genres.add(genre);
      notifyListeners();
    }
  }

  void getFromDb() {
    _genres = _manager.getAll();
  }

  void removeAll() {
    _manager.removeAll();
    _genres = [];
  }

  void removeEmpty() {
    _manager.removeEmpty();
    _genres = _manager.getAll();
    notifyListeners();
  }

  void saveAll() {
    _manager.saveAll(_genres);
  }
}
