import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/title_type.dart';
import 'package:onPlay/enums/player/volume_type.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/widgets/components/player/controls.dart';
import 'package:onPlay/widgets/components/player/current_playlist.dart';
import 'package:onPlay/widgets/components/player/title/loop_title.dart';
import 'package:onPlay/widgets/components/player/options/options.dart';
import 'package:onPlay/widgets/components/player/time-progress/time_progress.dart';
import 'package:onPlay/widgets/components/player/volume/volume.dart';
import 'package:provider/provider.dart';

class LateralPlayer extends StatelessWidget {
  final MusicColor musicColor;
  final Song song;

  LateralPlayer({super.key, required this.song, required this.musicColor});
  late Size deviceSize;
  late Settings settings;
  @override
  Widget build(BuildContext context) {
    //final store = Provider.of<SongStore>(context);
    settings = Provider.of<Settings>(context);
    deviceSize = MediaQuery.sizeOf(context);
    return DecoratedBox(
        decoration: BoxDecoration(
            color: musicColor.background,
            image: song.picture != null
                ? DecorationImage(
                    image: MemoryImage(
                      song.picture!,
                    ),
                    fit: BoxFit.cover)
                : null),
        child: SafeArea(
          child: Stack(
            children: [
              titleLateral(),
              progressLateral(),
              volumeLateral(),
              controlsLateral(),
              optionLateral(),
            ].nonNulls.toList(),
          ),
        ));
  }

  Widget? volumeLateral() {
    final layout = settings.layout;
    return layout.volumeType != VolumeType.option
        ? Positioned.fill(
            child: Align(
            alignment: Alignment.centerLeft,
            child: Card(
                color: musicColor.background,
                child: SizedBox(
                  width: layout.volumeType == VolumeType.steps ? 80 : 50,
                  height: deviceSize.height * 0.47,
                  child: Center(
                      child: Volume(
                    musicColor: musicColor,
                    vertical: true,
                  )),
                )),
          ))
        : null;
  }

  Widget progressLateral() {
    return Positioned.fill(
        child: Align(
      alignment: Alignment.centerRight,
      child: Card(
          color: musicColor.background,
          child: SizedBox(
            width: 50,
            height: deviceSize.height * 0.5,
            child: Center(
                child: TimeProgress(
              vertical: true,
              musicColor: musicColor,
            )),
          )),
    ));
  }

  Widget controlsLateral() {
    final layout = settings.layout;
    final interface = settings.interface;
    final isInRight = layout.volumeType == VolumeType.option;
    return Positioned.fill(
        top: interface.titleType == TitleType.option ? 0 : 45,
        bottom: 45,
        child: Align(
          alignment: isInRight ? Alignment.centerRight : Alignment.topCenter,
          child: Card(
              color: musicColor.background,
              child: SizedBox(
                width: isInRight ? 50 : deviceSize.width * 0.5,
                height: isInRight ? deviceSize.height * 0.25 : 50,
                child: Center(child: Controls(musicColor: musicColor)),
              )),
        ));
  }

  Widget? titleLateral() {
    final interface = settings.interface;
    return interface.titleType != TitleType.option
        ? Positioned.fill(
            child: Align(
                alignment: Alignment.topCenter,
                child: Card(
                  color: musicColor.background,
                  child: SizedBox(
                    width: deviceSize.width * 0.8,
                    height: 40,
                    child: Center(
                        child: LoopTitle(musicColor: musicColor, song: song)),
                  ),
                )),
          )
        : null;
  }

  Widget optionLateral() {
    return Positioned.fill(
        bottom: deviceSize.height * CurrentPlaylist.minSize,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Card(
              color: musicColor.background,
              child: SizedBox(
                width: deviceSize.width * 0.95,
                height: 50,
                child: Center(
                    child: Options(
                  musicColor: musicColor,
                  song: song,
                )),
              )),
        ));
  }
}
