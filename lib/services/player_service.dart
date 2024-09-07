import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:myapp/dto/song.dart';
import 'package:myapp/store/player_store.dart';
import 'package:myapp/store/song_store.dart';
import 'package:myapp/widgets/pages/Playlists.dart';

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

  pause() {
    _player.pause();
  }

  play() {
    _player.resume();
  }

  update(PlayerStore store) {
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
