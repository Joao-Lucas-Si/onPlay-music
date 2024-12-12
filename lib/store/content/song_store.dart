import 'package:flutter/material.dart';
import 'package:onPlay/enums/sorting/song_sorting.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/managers/song_manager.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/files_service.dart';
import 'package:onPlay/store/content/artist_store.dart';
import 'package:onPlay/store/content/genre_store.dart';
import "package:provider/provider.dart";
import 'package:onPlay/store/content/album_store.dart';

class SongStore extends ChangeNotifier {
  late SongManager _songManager;
  late AlbumStore _albumStore;
  late ArtistStore _artistStore;
  late GenreStore _genreStore;

  List<Song> _songs = [];
  String _loading = "";
  SongSorting _sort = SongSorting.color;
  String _order = "desc";
  String _artistSort = "name";
  String _artistOrder = "desc";

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

  SongSorting get sort => _sort;

  set order(String value) {
    _order = value;
    notifyListeners();
  }

  setSongSortByName(String name) {
    _sort = SongSorting.fromString(name);
    notifyListeners();
  }

  set sort(SongSorting value) {
    _sort = value;
    notifyListeners();
  }

  String get loading => _loading;

  List<Song> get songs => _songs;

  init(BoxManager boxManager) {
    if (boxManager.started) {
      _songManager = boxManager.songManager;
      // _artistStore.init(boxManager);
      // _albumStore.init(boxManager);
      // _genreStore.init(boxManager);
      _getData();
    }
    return this;
  }

  SongStore(BuildContext context) {
    _albumStore = context.read<AlbumStore>();
    _genreStore = context.read<GenreStore>();
    _artistStore = context.read<ArtistStore>();
    activeListeners();
  }

  activeListeners() async {
    final dirs = await FilesService.getMusicFolders();
    // print(dirs);
    for (final dir in dirs) {
      // print(dir);
      FilesService.listenDirectory(
        dir: dir,
        onCreate: (event) async {
          onCreateSong(event.path);
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

  onCreateSong(String path) async {
    final song = await FilesService.getSongByPath(path);
    debugPrint("nova musica $song");
    _saveOneToDb(song);
    _songs.add(song);
    notifyListeners();
  }

  updateSong(String path) async {
    debugPrint("musica modificada");
    final newData = await FilesService.getSongByPath(path);
    debugPrint(newData.metadata?.artist);
    final oldData = _songs.firstWhere((song) => song.path == path);

    oldData.year = newData.year;
    oldData.duration = newData.duration;
    oldData.title = newData.title;
    oldData.modified = newData.modified;
    oldData.picture = newData.picture;

    oldData.metadata = newData.metadata;

    // final album =
    _albumStore.extractAlbumFromSong(oldData);
    // final artist =
    _artistStore.extractArtistFromSong(oldData);
    // final genre =
    _genreStore.extractFromSong(oldData);

    // if (album.name != oldData.album.target?.name) {
    //   album.songs.add(oldData);
    //   oldData.album.target = album;
    // }

    // if (artist.name != oldData.artist.target?.name) {
    //   album.songs.add(oldData);
    //   oldData.artist.target = artist;
    // }

    // oldData.artist.target = newData.artist.target;
    // oldData.genre.target = newData.genre.target;

    // debugPrint("$oldData foi modificado para $newData");

    _saveOneToDb(oldData);
    _artistStore.removeEmpty();
    _albumStore.deleteEmpty();
    _genreStore.removeEmpty();
    notifyListeners();
  }

  saveOnlineSong(
    Song song,
  ) {
    _artistStore.extractArtistFromSong(song);
    _albumStore.extractAlbumFromSong(song);
    _genreStore.extractFromSong(song);
    _songManager.save(song);
    _songs.add(song);

    notifyListeners();
  }

  updateOnlineSong(
      {required Song song,
      required String name,
      required int year,
      required String artist,
      required String album,
      required String genre}) {
    song.title = name;
    song.year = year;
    _albumStore.extractAlbumFromSong(song, name: album, artist: artist);
    _artistStore.extractArtistFromSong(song, name: artist);
    _genreStore.extractFromSong(song, name: genre);
    _songManager.save(song);
    // _songs.add(song);
    _artistStore.removeEmpty();
    _genreStore.removeEmpty();
    _albumStore.deleteEmpty();
    _songs = _songManager.getAll();
    notifyListeners();
  }

  _setLoading(String loading) {
    _loading = loading;
    notifyListeners();
  }

  void save(Song song) {
    _songManager.save(song);
    notifyListeners();
  }

  Future<bool> _getDataFromDb() async {
    debugPrint(_songManager.count().toString());
    if (_songManager.count() == 0) {
      return false;
    } else {
      debugPrint("extraindo");
      _songs = _songManager.getAll();
      _albumStore.getFromDb();
      _artistStore.getFromDb();
      _genreStore.getFromDb();

      return true;
    }
  }

  _remove(Song song) {
    _songManager.remove(song);
    _albumStore.deleteEmpty();
    _artistStore.removeEmpty();
    _genreStore.removeEmpty();
  }

  _saveToDb() async {
    debugPrint("chegou");
    //_songManager.removeAll();
    // _albumStore.removeAll();
    // _artistStore.removeAll();
    // _genreStore.removeAll();
    //_songManager.saveAll(List.from(songs));
    // _genreStore.saveAll();
    // _albumStore.saveAll();
    _artistStore.saveAll();

    debugPrint("chegou");

    // _songs = _songManager.getAll();
    // _genreStore.getFromDb();
    // _albumStore.getFromDb();
    // _artistStore.getFromDb();
    // notifyListeners();
  }

  _saveOneToDb(Song song) {
    // final album =
    _albumStore.extractAlbumFromSong(song);
    // final artist =
    _artistStore.extractArtistFromSong(song);
    // final genre =
    _genreStore.extractFromSong(song);

    _songManager.save(song);
  }

  _getDataFromFiles() {
    _songManager.removeAll();
    _songs = [];
    _artistStore.removeAll();
    _genreStore.removeAll();
    _albumStore.removeAll();
    notifyListeners();
    FilesService.getAllMusics(_setLoading).then((songs) async {
      _songs = songs;

      _artistStore.extractAllArtists(songs);
      debugPrint(songs.length.toString());
      debugPrint(_artistStore.artists.length.toString());
      _genreStore.extractAllGenres(songs);
      debugPrint(songs.length.toString());
      debugPrint(_artistStore.artists.length.toString());
      debugPrint(_genreStore.genres.length.toString());
      _albumStore.extractAllAlbums(songs);
      debugPrint(songs.length.toString());
      debugPrint(_artistStore.artists.length.toString());
      debugPrint(_albumStore.albums.length.toString());

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
    debugPrint(collected.toString());
    if (collected == false) {
      await _getDataFromFiles();
    }
  }
}
