import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/services/http/services/editor_color_service.dart';
import 'package:onPlay/services/wallpaper_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:provider/provider.dart';

class PlayerService extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  PlayerStore? store;
  BuildContext context;
  stop() {
    _player.stop();
  }

  PlayerService(this.context);

  // setMusic(Song song) {
  //   song.metadata?.duration?.inMilliseconds;
  //   _player.play(DeviceFileSource(song.path));
  // }

  setPosition(int seconds) {
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

  _setMusic() {
    if (store != null) {
      if (store!.playlist.isEmpty) {
        _player.stop();
      } else if (store!.playingSong != null && store!.mudarMusica) {
        final settings = Provider.of<Settings>(context, listen: false);
        WallpaperService().setWallpaper(
            store!.playingSong!,
            MediaQuery.sizeOf(context).width,
            MediaQuery.sizeOf(context).height);
        _player.play(DeviceFileSource(store!.playingSong!.path));
        EditorColorService(settings).sendColors(store!.playingSong!
            .currentColors(
                settings.interface.colorPalette, settings.interface.colorTheme,
                context: context));
        store!.mudarMusica = false;
      }
    }
  }

  _setVelocity() {
    if (store != null) {
      if (_player.playbackRate != store!.velocity) {
        _player.setPlaybackRate(store!.velocity);
      }
    }
  }

  _listenPosition() {
    if (store != null) {
      _player.onPositionChanged.listen((event) {
        if (store!.position != event.inSeconds) {
          store!.position = event.inSeconds;
        }
      });
    }
  }

  _listenState() {
    if (store != null) {
      _player.onPlayerStateChanged.listen((state) {
        if (state == PlayerState.paused) {
          store!.onPause();
        } else if (state == PlayerState.completed) {
          store!.onComplete();
        } else if (state == PlayerState.playing) {
          if (store!.paused) store!.onPlay();
        }
      });
    }
  }

  update(PlayerStore store) {
    this.store = store;
    _setMusic();
    _setVelocity();
    _listenPosition();
    _listenState();

    return this;
  }
}
