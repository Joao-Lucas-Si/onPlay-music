import 'package:just_audio/just_audio.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/audio/audio_player_service_adapter.dart';

class JustAudioAdapter extends AudioPlayerServiceAdapter {
  final _instance = AudioPlayer();

  JustAudioAdapter(super.context,
      {required super.listenPosition, required super.notify});

  @override
  void pause() {
    _instance.pause();
  }

  @override
  void play() {
    _instance.play();
  }

  @override
  void seek(int seconds) {
    _instance.seek(Duration(seconds: seconds));
  }

  @override
  Future<void> setMusic(Song song) async {
    if (song.isOnline) {
      final url = await getOnlineAudio(song);
      _instance.setUrl(url);
    } else {
      _instance.setFilePath(song.path);
    }
    _instance.play();
  }

  @override
  void stop() {
    _instance.stop();
  }
}
