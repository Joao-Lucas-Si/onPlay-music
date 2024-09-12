import 'package:flutter/material.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/models/managers/album_manager.dart';
import 'package:onPlay/models/managers/artist_manager.dart';
import 'package:onPlay/models/managers/genre_manager.dart';
import 'package:onPlay/models/managers/song_manager.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/services/files_service.dart';
import 'package:collection/collection.dart';

class SongStore extends ChangeNotifier {
  late BoxManager _boxManager;
  late SongManager _songManager;
  late GenreManager _genreManager;
  late AlbumManager _albumManager;
  late ArtistManager _artistManager;
  List<Song> _songs = [];
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

  init(BoxManager boxManager) {
    if (boxManager.started) {
      _boxManager = boxManager;
      _artistManager = _boxManager.artistManager;
      _songManager = _boxManager.songManager;
      _albumManager = _boxManager.albumManager;
      _genreManager = _boxManager.genreManager;
      _getData();
    }
    return this;
  }

  SongStore() {
    activeListeners();
  }

  activeListeners() async {
    final dirs = await FilesService.getMusicFolders();
    print(dirs);
    for (final dir in dirs) {
      print(dir);
      FilesService.listenDirectory(
        dir: dir,
        onCreate: (event) async {
          final song = await FilesService.getSongByPath(event.path);
          debugPrint("nova musica $song");
          _saveOneToDb(song);
          _songs.add(song);
          notifyListeners();
        },
        onMove: (event) {
          debugPrint("musica movida");
          final oldPath = event.path;
          final newPath = event.destination;

          if (newPath != null) {
            final song = _songs.firstWhere((song) => song.path == oldPath);

            debugPrint("musica $song movida de $oldPath para $newPath");

            song.path = newPath;

            _saveOneToDb(song);
            notifyListeners();
          }
        },
        onDelete: (event) {
          debugPrint("musica deletada");
          final song = _songs.firstWhere((song) => song.path == event.path);

          debugPrint("$song foi deletado");
          _songs.remove(song);

          _remove(song);

          notifyListeners();
        },
        onModify: (event) async {
          updateSong(event.path);
        },
      );
    }
  }

  updateSong(String path) async {
    debugPrint("musica modificada");
    final newData = await FilesService.getSongByPath(path);
    final oldData = _songs.firstWhere((song) => song.path == path);

    oldData.year = newData.year;
    oldData.duration = newData.duration;
    oldData.title = newData.title;
    oldData.modified = newData.modified;
    oldData.picture = newData.picture;

    final album = _getAlbum(oldData);
    final artist = _getArtist(oldData);
    final genre = _getGenre(oldData);

    if (album != oldData.album.target) {
      album.songs.add(oldData);
      oldData.album.target = album;
    }

    _addAlbum(album);
    _addArtist(artist);
    _addGenre(genre);

    oldData.artist.target = newData.artist.target;
    oldData.genre.target = newData.genre.target;

    debugPrint("$oldData foi modificado para $newData");

    _saveOneToDb(oldData);

    notifyListeners();
  }

  _setLoading(String loading) {
    _loading = loading;
    notifyListeners();
  }

  Artist _getArtist(Song song) {
    var artist = _artists.firstWhereOrNull((value) =>
        value.name.toLowerCase() ==
        (song.metadata?.artist?.toLowerCase() ?? "desconhecido"));
    if (artist != null) {
      if (artist.picture == null && song.picture != null) {
        artist.picture = song.picture;
      }
    } else {
      artist = Artist(
          name: song.metadata?.artist ?? "desconhecido", picture: song.picture);
    }
    song.artist.target = artist;
    artist.songs.add(song);
    return artist;
  }

  _getArtists() {
    _setLoading("procurando artistas");
    _artists = [];
    for (final song in songs) {
      final artist = _getArtist(song);
      _addArtist(artist);
    }
    _setLoading("");
    notifyListeners();
  }

  _addArtist(Artist artist) {
    if (!_artists.contains(artist)) _artists.add(artist);
  }

  Genre _getGenre(Song song) {
    var genre = _genres.firstWhereOrNull((value) =>
        value.name.toLowerCase() ==
        (song.metadata?.genre?.toLowerCase() ?? "desconhecido"));
    if (genre != null) {
      if (genre.picture == null && song.picture != null) {
        genre.picture = song.picture;
      }
    } else {
      genre = Genre(
          name: song.metadata != null &&
                  song.metadata!.genre != null &&
                  song.metadata!.genre!.trim() != ""
              ? song.metadata!.genre!
              : "desconhecido",
          picture: song.picture);
    }
    genre.songs.add(song);
    song.genre.target = genre;
    return genre;
  }

  _getGenres() {
    _setLoading("procurando gêneros");
    _genres = [];
    for (final song in songs) {
      final genre = _getGenre(song);
      _addGenre(genre);
    }
    _setLoading("");
    notifyListeners();
  }

  _addGenre(Genre genre) {
    if (!_genres.contains(genre)) _genres.add(genre);
  }

  Album _getAlbum(Song song) {
    var album = _albums.firstWhereOrNull((value) =>
        value.name.toLowerCase() == song.metadata?.album?.toLowerCase() &&
        song.metadata?.artist?.toLowerCase() ==
            value.artist.target?.name.toLowerCase());
    if (album != null) {
      if (album.picture == null && song.picture != null) {
        album.picture = song.picture;
      }
      album.songs.add(song);
    } else {
      final artist = _artists.firstWhereOrNull((artist) =>
          artist.name.toLowerCase() == song.artist.target?.name.toLowerCase());

      album = Album(
          name: song.metadata?.album ?? "desconhecido", picture: song.picture);
      album.artist.target = artist;

      if (artist != null) artist.albums.add(album);
    }
    return album;
  }

  _getAlbums() {
    _setLoading("procurando albuns");
    _albums = [];
    for (final song in songs) {
      final album = _getAlbum(song);
      album.songs.add(song);
      _addAlbum(album);
    }
    _setLoading("");
    notifyListeners();
  }

  _addAlbum(Album album) {
    if (!_albums.contains(album)) _albums.add(album);
  }

  Future<bool> _getDataFromDb() async {
    if (_songManager.count() == 0) {
      return false;
    } else {
      _songs = _songManager.getAll();
      _albums = _albumManager.getAll();
      _artists = _artistManager.getAll();
      _genres = _genreManager.getAll();
      return true;
    }
  }

  _remove(Song song) {
    _songManager.remove(song);
  }

  _saveToDb() {
    _songManager.removeAll();
    _albumManager.removeAll();
    _artistManager.removeAll();
    _genreManager.removeAll();
    _songManager.saveAll(_songs);
    _albumManager.saveAll(_albums);
    _artistManager.saveAll(_artists);
    _genreManager.saveAll(_genres);
  }

  _saveOneToDb(Song song) {
    final album = _getAlbum(song);
    final artist = _getArtist(song);
    final genre = _getGenre(song);

    _addAlbum(album);
    _addArtist(artist);
    _addGenre(genre);

    _songManager.save(song);
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
