import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/dto/song.dart';

enum PlayModes { none, replayPlaylist, replayMusic }

class PlayerStore extends ChangeNotifier {
  List<Song> _playlist = [];
  int? _currentSong;
  var _position = 0;
  var _paused = false;
  var mode = PlayModes.none;

  bool get paused => _paused;

  List<Song> get playlist => _playlist;

  set playlist(List<Song> playlist) {
    _playlist = playlist;
    if (_playlist.isEmpty) {
      _currentSong = null;
    } else {
      _currentSong = 0;
    }
    notifyListeners();
  }

  int get position => _position;

  set position(int value) {
    _position = value;
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
      _currentSong = _currentSong! + 1;
    }
  }

  bool get hasPrevious => _currentSong != null && _currentSong! > 0;

  runPrevious() {
    if (hasPrevious) {
      _currentSong = _currentSong! - 1;
    }
  }

  onPause() {
    _paused = true;
    notifyListeners();
  }

  onPlay() {
    _paused = false;
    notifyListeners();
  }

  onComplete() {
    if (_currentSong != null) {
      switch (mode) {
        case PlayModes.none:
          if (_currentSong! < _playlist.length) {
            runNext();
          } else {
            _currentSong = null;
          }
          break;
        case PlayModes.replayMusic:
          _currentSong = _currentSong;
          break;
        case PlayModes.replayPlaylist:
          if (_currentSong! < _playlist.length) {
            runNext();
          } else {
            _currentSong = 0;
          }
          break;
      }
      notifyListeners();
      ;
    }
  }

  onRun() {}
}
