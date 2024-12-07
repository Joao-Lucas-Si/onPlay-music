import 'package:flutter/material.dart';
import 'package:onPlay/models/album.dart';
import "package:collection/collection.dart";
import 'package:onPlay/models/managers/album_manager.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/content/artist_store.dart';
import "package:provider/provider.dart";

class AlbumStore extends ChangeNotifier {
  BuildContext context;
  late ArtistStore _artistStore;
  late AlbumManager _manager;
  // late SongStore songStore;
  List<Album> _albums = [];

  List<Album> get albums => _albums;

  AlbumStore(this.context) {
    _artistStore = context.read<ArtistStore>();
  }

  AlbumStore init(BoxManager boxManager) {
    if (boxManager.started) {
      _manager = boxManager.albumManager;
    }
    return this;
  }

  void saveAll() {
    _manager.saveAll(_albums);
    _albums = _manager.getAll();
    notifyListeners();
  }

  void removeAll() {
    _manager.removeAll();
    _albums = [];
  }

  void getFromDb() {
    _albums = _manager.getAll();
  }

  Album _extractFromLocalSong(Song song) {
    var album = _albums.firstWhereOrNull((value) =>
        value.name.toLowerCase() == song.metadata?.album?.toLowerCase() &&
        song.metadata?.artist?.toLowerCase() ==
            value.artist.target?.name.toLowerCase());

    album ??= Album(name: song.metadata?.album ?? "desconhecido");
    if (album.artist.target == null) {
      final artist = _artistStore.artists.firstWhereOrNull((artist) =>
          artist.name.toLowerCase() == song.artist.target?.name.toLowerCase());
      album.artist.target ??= artist;

      if (artist != null) artist.albums.add(album);
    }
    return album;
  }

  Album _extractFromOnlineSong(Song song) {
    var album = _albums.firstWhereOrNull((value) =>
        value.name.toLowerCase() == "desconhecido" &&
        song.videoData?.author?.toLowerCase() ==
            value.artist.target?.name.toLowerCase());

    album ??= Album(name: "desconhecido");
    if (album.artist.target == null) {
      final artist = _artistStore.artists.firstWhereOrNull((artist) =>
          artist.name.toLowerCase() == song.artist.target?.name.toLowerCase());
      album.artist.target ??= artist;

      if (artist != null) artist.albums.add(album);
    }
    return album;
  }

  Album _extractFromName(String name, String artistName) {
  
    final albumName = name.trim() == "" ? "desconhecido" : name;
    var album = _albums.firstWhereOrNull((value) =>
        value.name.toLowerCase() == albumName.toLowerCase() &&
        artistName.toLowerCase() == value.artist.target?.name.toLowerCase());

    album ??= Album(name: albumName);

    if (album.artist.target == null) {
      final artist = _artistStore.artists.firstWhereOrNull(
          (artist) => artist.name.toLowerCase() == artistName.toLowerCase());
      album.artist.target ??= artist;

      if (artist != null) artist.albums.add(album);
    }
    return album;
  }

  Album extractAlbumFromSong(Song song, {String? name, String? artist}) {

    var album = (name != null && artist != null)
        ? _extractFromName(name, artist)
        : (song.isOnline
            ? _extractFromOnlineSong(song)
            : _extractFromLocalSong(song));
    song.album.target = album;
    if (!album.songs.contains(song)) album.songs.add(song);
    _addAlbum(album);
    notifyListeners();
    return album;
  }

  void extractAllAlbums(List<Song> songs) {
    // final albums = <Album>[];
    for (final song in songs) {
      extractAlbumFromSong(song);
    }
  }

  void deleteEmpty() {
    _manager.deleteEmpty();
    _albums = _manager.getAll();
  }

  void _addAlbum(Album album) {
    if (!_albums.contains(album)) {
      _albums.add(album);
    }
  }
}
