import 'package:flutter/material.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/audio/adapters/audio_players_adapter.dart';

enum PlayLoopMode { none, replayPlaylist, replayMusic }

class PlayerStore extends ChangeNotifier {
  BuildContext context;

  late final player = AudioPlayersAdapter(context, listenPosition: (seconds) {
    position = seconds;
  }, notify: () {
    notifyListeners();
  });
  int? _currentSong;
  var _position = 0;
  var _velocity = 1.0;
  final velocityStep = 0.5;
  final maxVelocity = 5;
  var _mode = PlayLoopMode.none;

  double get velocity => _velocity;

  set velocity(double value) {
    _velocity = value;
    notifyListeners();
  }

  bool get paused => player.paused;

  set mode(PlayLoopMode mode) {
    _mode = mode;
    player.loopMode = mode;
    notifyListeners();
  }

  PlayLoopMode get mode => _mode;

  List<Song> get playlist => player.playlist;

  addSong(Song song) {
    player.playlist.add(song);
    notifyListeners();
  }

  addSongToNext(Song song) {
    player.playlist.insert((_currentSong ?? 0) + 1, song);
    notifyListeners();
  }

  set playlist(List<Song> playlist) {
    player.playlist = playlist;
    if (player.playlist.isEmpty) {
      _currentSong = null;
    } else {
      //mudarMusica = true;
      _currentSong = 0;
    }
    notifyListeners();
  }

  int get position => _position;

  set position(int value) {
    _position = value;
    notifyListeners();
  }

  int? get currentSong => player.currentSong;

  set currentSong(int? song) {
    _position = 0;
    _currentSong = song;
    player.currentSong = song ?? -1;
    //mudarMusica = true;
    notifyListeners();
  }

  Song? get playingSong =>
      player.currentSong != -1 ? player.playlist[_currentSong!] : null;

  reset() {
    player.playlist = [];

    player.paused = false;

    notifyListeners();
  }

  bool get hasNext => player.hasNext;

  runNext() {
    player.runNext();
    notifyListeners();
  }

  bool get hasPrevious => player.hasPrevious;

  runPrevious() {
    player.runPrevious();
    notifyListeners();
  }

  PlayerStore(this.context);
}
