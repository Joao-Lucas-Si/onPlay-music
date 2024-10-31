import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onPlay/models/song.dart';

enum PlayModes {
  none("none"),
  replayPlaylist("replayPlaylist"),
  replayMusic("replayMusic");

  final String name;

  const PlayModes(this.name);
}

class PlayerStore extends ChangeNotifier {
  List<Song> _playlist = [];
  int? _currentSong;
  var _position = 0;
  var _velocity = 1.0;
  final velocityStep = 0.5;
  final maxVelocity = 5;
  var _paused = false;
  var _mode = PlayModes.none;

  double get velocity => _velocity;

  set velocity(double value) {
    _velocity = value;
    notifyListeners();
  }

  bool get paused => _paused;

  set mode(PlayModes mode) {
    _mode = mode;
    notifyListeners();
  }

  PlayModes get mode => _mode;

  List<Song> get playlist => _playlist;

  addSong(Song song) {
    _playlist.add(song);
    notifyListeners();
  }

  addSongToNext(Song song) {
    _playlist.insert((_currentSong ?? 0) + 1, song);
    notifyListeners();
  }

  set playlist(List<Song> playlist) {
    _playlist = playlist;
    if (_playlist.isEmpty) {
      _currentSong = null;
    } else {
      mudarMusica = true;
      _currentSong = 0;
    }
    notifyListeners();
  }

  int get position => _position;

  set position(int value) {
    _position = value;
    notifyListeners();
  }

  int? get currentSong => _currentSong;

  set currentSong(int? song) {
    _position = 0;
    _currentSong = song;
    mudarMusica = true;
    notifyListeners();
  }

  Song? get playingSong =>
      _currentSong != null ? _playlist[_currentSong!] : null;

  reset() {
    _playlist = [];
    _currentSong = null;
    _paused = false;

    notifyListeners();
  }

  bool get hasNext =>
      _currentSong != null && _currentSong! < _playlist.length - 1;

  runNext() {
    if (hasNext) {
      mudarMusica = true;
      _currentSong = _currentSong! + 1;
    }
    notifyListeners();
  }

  bool get hasPrevious => _currentSong != null && _currentSong! > 0;

  runPrevious() {
    if (hasPrevious) {
      mudarMusica = true;
      _currentSong = _currentSong! - 1;
    }
    notifyListeners();
  }

  onPause() {
    _paused = true;

    notifyListeners();
  }

  onPlay() {
    _paused = false;
    notifyListeners();
  }

  var mudarMusica = false;

  onComplete() {
    if (_currentSong != null && !mudarMusica) {
      switch (mode) {
        case PlayModes.none:
          if (_currentSong! < _playlist.length - 1) {
            runNext();
          } else {
            _currentSong = null;
          }
          break;
        case PlayModes.replayMusic:
          _currentSong = _currentSong;
          break;
        case PlayModes.replayPlaylist:
          if (_currentSong! < _playlist.length - 1) {
            runNext();
          } else {
            _currentSong = 0;
          }
          break;
      }
      _position = 0;
      mudarMusica = true;
      notifyListeners();
    }
  }

  onRun() {}
}
