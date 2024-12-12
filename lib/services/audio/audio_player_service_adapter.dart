import 'package:flutter/material.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/http/services/youtube_service.dart';
import 'package:onPlay/store/player_store.dart';

abstract class AudioPlayerServiceAdapter {
  BuildContext context;
  int position = 0;
  AudioPlayerServiceAdapter(this.context,
      {required this.listenPosition, required this.notify});
  @protected
  void Function() notify;

  final void Function(int seconds) listenPosition;

  List<Song> _playlist = [];

  List<Song> get playlist => _playlist;

  set playlist(List<Song> playlist) {
    _playlist = playlist;
    currentSong = playlist.isEmpty ? -1 : 0;
  }

  int _currentSong = -1;

  int get currentSong => _currentSong;

  set currentSong(int index) {
    _currentSong = index;
    if (index != -1) {
      setMusic(playlist[index]);
    } else {
      stop();
    }
  }

  PlayLoopMode loopMode = PlayLoopMode.none;
  bool paused = true;

  void pause();
  void play();
  Future<void> setMusic(Song song);
  void seek(int seconds);
  void stop();

  void runNext() {
    if (hasNext) currentSong += 1;
  }

  void runPrevious() {
    if (hasPrevious) currentSong -= 1;
  }

  bool get hasPrevious => currentSong != 0;

  bool get hasNext => currentSong != -1 && currentSong < playlist.length - 1;

  @protected
  Future<String> getOnlineAudio(Song song) async {
    final youtubeService = YoutubeService(context);
    final video = await youtubeService.getVideo(song.path);
    return video?.formatStreams?.first.url ?? "";
  }
}
