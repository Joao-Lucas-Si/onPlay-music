import 'package:flutter/material.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/managers/artist_manager.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/song.dart';
import "package:collection/collection.dart";

class ArtistStore extends ChangeNotifier {
  late ArtistManager _manager;
  List<Artist> _artists = [];

  List<Artist> get artists => _artists;

  ArtistStore(BuildContext context);

  ArtistStore init(BoxManager boxManager) {
    if (boxManager.started) {
      _manager = boxManager.artistManager;
    }
    return this;
  }

  void removeEmpty() {
    _manager.removeEmpty();

    _artists = _manager.getAll();
    notifyListeners();
  }

  void extractAllArtists(List<Song> songs) {
    for (final song in songs) {
      final artist = extractArtistFromSong(song);
      _addArtist(artist);
    }
    // _setLoading("");
    // notifyListeners();
  }

  Artist _extractFromLocalSong(Song song) {
    var artist = _artists.firstWhereOrNull((value) =>
        value.name.toLowerCase() ==
        (song.metadata?.artist?.toLowerCase() ?? "desconhecido"));
    artist ??= Artist(name: song.metadata?.artist ?? "desconhecido");
    return artist;
  }

  Artist _extractFromOnlineSong(Song song) {
    var artist = _artists.firstWhereOrNull((value) =>
        value.name.toLowerCase() ==
        (song.videoData?.author?.toLowerCase() ?? "desconhecido"));
    artist ??= Artist(name: song.videoData?.author ?? "desconhecido");
    return artist;
  }

  Artist _extractFromName(String name) {
    var artist = _artists.firstWhereOrNull((value) =>
        value.name.toLowerCase() ==
        (name.trim() == "" ? "desconhecido" : name));
    artist ??= Artist(name: name.trim() == "" ? "desconhecido" : name);
    return artist;
  }

  Artist extractArtistFromSong(Song song, {String? name}) {
    var artist = name != null
        ? _extractFromName(name)
        : (song.isOnline
            ? _extractFromOnlineSong(song)
            : _extractFromLocalSong(song));
    song.artist.target = artist;
    if (!artist.songs.contains(song)) artist.songs.add(song);
    return artist;
  }

  void removeAll() {
    _manager.removeAll();
    _artists = [];
  }

  void saveAll() {
    debugPrint(_artists.toString());
    _manager.saveAll(_artists);
  }

  void getFromDb() {
    _artists = _manager.getAll();
  }

  void _addArtist(Artist artist) {
    if (!_artists.contains(artist)) {
      _artists.add(artist);
    }
  }
}
