import 'package:audioplayers/audioplayers.dart';
import 'package:onPlay/dtos/json/editor_colors_dto.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/audio/audio_player_service_adapter.dart';
import 'package:onPlay/services/http/services/editor_color_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/settings.dart';
import "package:provider/provider.dart";

class AudioPlayersAdapter extends AudioPlayerServiceAdapter {
  final _instance = AudioPlayer();

  AudioPlayersAdapter(super.context,
      {required super.listenPosition, required super.notify}) {
    _listenState();
    _listenPosition();
  }

  @override
  void pause() {
    _instance.pause();
  }

  @override
  void play() {
    _instance.resume();
  }

  @override
  void seek(int seconds) {
    _instance.seek(Duration(seconds: seconds));
  }

  @override
  void stop() {
    _instance.stop();
  }

  @override
  Future<void> setMusic(Song song) async {
    if (song.isOnline) {
      final path = await super.getOnlineAudio(song);
      _instance.play(UrlSource(path));
    } else {
      _instance.play(DeviceFileSource(song.path));
    }
    
    EditorColorService(context.read<Settings>()).sendColors(
        EditorColorsDto.fromMusicColor(
            colors: song.currentColors(context),
            name: song.title,
            image: song.picture,
            imageMimeType: song.pictureMimeType));
  }

  void _listenPosition() {
    _instance.onPositionChanged.listen((event) {
      listenPosition(event.inSeconds);
      // if (store!.position != event.inSeconds) {
      //   store!.position = event.inSeconds;
      // }
    });
  }

  void _listenState() {
    _instance.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.paused) {
        paused = true;
        notify();
      } else if (state == PlayerState.completed) {
        switch (loopMode) {
          case PlayLoopMode.none:
            if (currentSong < playlist.length - 1) {
              runNext();
            } else {
              currentSong = -1;
            }
            break;
          case PlayLoopMode.replayMusic:
            currentSong = currentSong;
            break;
          case PlayLoopMode.replayPlaylist:
            if (currentSong < playlist.length - 1) {
              runNext();
            } else {
              currentSong = 0;
            }
            break;
        }
        notify();
      } else if (state == PlayerState.playing) {
        if (paused) {
          paused = false;
          notify();
        }
      }
    });
  }
}
