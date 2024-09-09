import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:onPlay/store/player_store.dart';

class PlayerService extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  PlayerStore? store;
  var _currentSong = "";

  stop() {
    _player.stop();
  }

  // setMusic(Song song) {
  //   song.metadata?.duration?.inMilliseconds;
  //   _player.play(DeviceFileSource(song.path));
  // }

  setPosition(int seconds) {
    print(store?.playingSong?.path);
    if (store?.playingSong != null) {
      _player.play(DeviceFileSource(store!.playingSong!.path),
          position: Duration(seconds: seconds));
    }
  }

  pause() {
    _player.pause();
  }

  play() {
    _player.resume();
  }

  update(PlayerStore store) {
    this.store = store;
    if (store.playlist.isEmpty) {
      _player.stop();
    } else if (store.playingSong != null) {
      if (_currentSong != store.playingSong?.path) {
        _player.play(DeviceFileSource(store.playingSong!.path));
        _currentSong = store.playingSong!.path;
      }
    }

    _player.onPositionChanged.listen((event) {
      if (store.position != event.inSeconds) {
        store.position = event.inSeconds;
      }
    });
    _player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.paused) {
        store.onPause();
      } else if (state == PlayerState.completed) {
        store.onComplete();
      } else if (state == PlayerState.playing) {
        if (store.paused) store.onPlay();
      }
    });

    return this;
  }
}
