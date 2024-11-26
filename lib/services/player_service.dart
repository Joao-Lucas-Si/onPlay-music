// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:onPlay/services/audio/adapters/audio_players_adapter.dart';
// import 'package:onPlay/services/http/services/youtube_service.dart';
// import 'package:onPlay/store/settings.dart';
// import 'package:onPlay/services/http/services/editor_color_service.dart';
// import 'package:onPlay/services/wallpaper_service.dart';
// import 'package:onPlay/store/player_store.dart';
// import 'package:provider/provider.dart';

// class PlayerService extends ChangeNotifier {
//   final AudioPlayer _player = AudioPlayer();
//   late final _playerAdapter = AudioPla(
//     context,
//     notify: () {},
//     listenPosition: (seconds) {
//       store?.position = seconds;
//     },
//   );
//   PlayerStore? store;
//   BuildContext context;

//   stop() {
//     _player.stop();
//   }

//   PlayerService(this.context);

//   // setMusic(Song song) {
//   //   song.metadata?.duration?.inMilliseconds;
//   //   _player.play(DeviceFileSource(song.path));
//   // }

//   setPosition(int seconds) async {
//     // if (store?.playingSong != null) {
//     //   if (store!.playingSong!.isOnline) {
//     //     final youtubeService = YoutubeService(context);
//     //     final video = await youtubeService.getVideo(store!.playingSong!.path);

//     //     _player.play(UrlSource(video!.formatStreams!.first.url!),
//     //         position: Duration(seconds: seconds));
//     //   } else {
//     //     _player.play(DeviceFileSource(store!.playingSong!.path),
//     //         position: Duration(seconds: seconds));
//     //   }
//     // }
//     _playerAdapter.seek(seconds);
//   }

//   pause() {
//     _playerAdapter.pause();
//   }

//   play() {
//     _playerAdapter.play();
//   }

//   _setMusic() async {
//     if (store != null) {
//       if (store!.playlist.isEmpty) {
//         _player.stop();
//       } else if (store!.playingSong != null && store!.mudarMusica) {
//         final settings = Provider.of<Settings>(context, listen: false);
//         WallpaperService().setWallpaper(
//             store!.playingSong!,
//             MediaQuery.sizeOf(context).width,
//             MediaQuery.sizeOf(context).height);
//         // if (store!.playingSong!.isOnline) {
//         //   final youtubeService = YoutubeService(context);
//         //   final video = await youtubeService.getVideo(store!.playingSong!.path);
//         //   video?.formatStreams?.forEach((stream) {
//         //     debugPrint(stream.type);
//         //   });

//         //   //debugPrint(video?.formatStreams?.first.url);
//         //   _player.play(UrlSource(video!.formatStreams!.first.url ?? ""
//         //       // ,
//         //       //     mimeType: video.formatStreams?.first.type
//         //       ));
//         // } else {
//         //   _player.play(DeviceFileSource(store!.playingSong!.path));
//         // }
//         _playerAdapter.setMusic(store!.playingSong!);

//         EditorColorService(settings)
//             .sendColors(store!.playingSong!.currentColors(context));
        
//       }
//     }
//   }

//   _setVelocity() {
//     if (store != null) {
//       if (_player.playbackRate != store!.velocity) {
//         _player.setPlaybackRate(store!.velocity);
//       }
//     }
//   }

//   update(PlayerStore store) {
//     this.store = store;
//     _setMusic();
//     _setVelocity();

//     return this;
//   }
// }
