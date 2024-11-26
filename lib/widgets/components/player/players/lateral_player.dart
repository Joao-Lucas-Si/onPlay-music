import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/volume_type.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/store/settings/layout.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
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
            children: settings.layout.lateralElements
                .map((element) {
                  Widget getElement() {
                    final isVertical = [
                      LateralPosition.left,
                      LateralPosition.left,
                      LateralPosition.nextLeft,
                      LateralPosition.nextRight,
                      LateralPosition.right
                    ].contains(element.position);
                    switch (element.element) {
                      case PlayerElement.controls:
                        return controlsLateral(isVertical);
                      case PlayerElement.options:
                        return optionLateral(isVertical);
                      case PlayerElement.title:
                        return titleLateral(
                            isVertical,
                            [LateralPosition.right, LateralPosition.right]
                                .contains(element.position));
                      case PlayerElement.volume:
                        return volumeLateral(isVertical);
                      case PlayerElement.position:
                        return progressLateral(isVertical);
                      case PlayerElement.picture:
                        return TimeProgress(musicColor: musicColor);
                      default :
                        return TimeProgress(musicColor: musicColor);
                    }
                  }

                  return positionedLaterally(element.position, getElement());
                })
                .nonNulls
                .toList(),
          ),
        ));
  }

  Widget volumeLateral(bool isVertical) {
    final layout = settings.layout;
    return Card(
        color: musicColor.background,
        child: SizedBox(
          width: isVertical
              ? (layout.volumeType == VolumeType.steps ? 80 : 50)
              : deviceSize.width * 0.98,
          height: isVertical
              ? deviceSize.height * 0.47
              : layout.volumeType == VolumeType.steps
                  ? 60
                  : 50,
          child: Center(
              child: Volume(
            musicColor: musicColor,
            vertical: isVertical,
          )),
        ));
  }

  Widget progressLateral(bool isVertical) {
    return Card(
        color: musicColor.background,
        child: SizedBox(
          width: isVertical ? 60 : deviceSize.width * 0.95,
          height: isVertical ? deviceSize.height * 0.5 : 60,
          child: Center(
              child: TimeProgress(
            vertical: isVertical,
            musicColor: musicColor,
          )),
        ));
  }

  Widget controlsLateral(isVertical) {
    return Card(
        color: musicColor.background,
        child: SizedBox(
          width: isVertical ? 50 : deviceSize.width * 0.5,
          height: isVertical ? deviceSize.height * 0.25 : 50,
          child: Center(child: Controls(musicColor: musicColor)),
        ));
  }

  Widget titleLateral(bool isVertical, bool isRight) {
    return Card(
      color: musicColor.background,
      child: SizedBox(
        width: isVertical ? 50 : deviceSize.width * 0.95,
        height: isVertical ? deviceSize.height * 0.6 : 50,
        child: Center(
            child: isVertical
                ? RotatedBox(
                    quarterTurns: isRight ? 1 : 3,
                    child: LoopTitle(musicColor: musicColor, song: song))
                : LoopTitle(musicColor: musicColor, song: song)),
      ),
    );
  }

  Widget optionLateral(bool isVertical) {
    return Card(
        color: musicColor.background,
        child: SizedBox(
          width: isVertical ? 50 : deviceSize.width * 0.95,
          height: isVertical ? deviceSize.height * 0.6 : 50,
          child: Center(
              child: Options(
            musicColor: musicColor,
            song: song,
            isVertical: isVertical,
          )),
        ));
  }

  Widget positionedLaterally(LateralPosition position, Widget widget) {
    switch (position) {
      case LateralPosition.bottom:
        return bottomPosition(widget);
      case LateralPosition.center:
        return centerPosition(widget);
      case LateralPosition.left:
        return leftPosition(widget);
      case LateralPosition.right:
        return rightPosition(widget);
      case LateralPosition.top:
        return topPosition(widget);
      case LateralPosition.underTop:
        return underTopPosition(widget);
      case LateralPosition.topBottom:
        return topBottomPosition(widget);
      case LateralPosition.nextLeft:
        return nextLeftPosition(widget);
      case LateralPosition.nextRight:
        return nextRightPosition(widget);
    }
  }

  Widget leftPosition(Widget widget) {
    return Positioned.fill(
        child: Align(
      alignment: Alignment.centerLeft,
      child: widget,
    ));
  }

  Widget rightPosition(Widget widget) {
    return Positioned.fill(
        child: Align(
      alignment: Alignment.centerRight,
      child: widget,
    ));
  }

  Widget topPosition(Widget widget) {
    return Positioned.fill(
        child: Align(
      alignment: Alignment.topCenter,
      child: widget,
    ));
  }

  Widget bottomPosition(Widget widget) {
    return Positioned.fill(
        bottom: deviceSize.height * CurrentPlaylist.minSize,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: widget,
        ));
  }

  Widget centerPosition(Widget widget) {
    return Positioned.fill(
        child: Align(
      alignment: Alignment.center,
      child: widget,
    ));
  }

  Widget topBottomPosition(Widget widget) {
    return Positioned.fill(
        bottom: (deviceSize.height * CurrentPlaylist.minSize) + 60,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: widget,
        ));
  }

  Widget underTopPosition(Widget widget) {
    return Positioned.fill(
        top: 60,
        child: Align(
          alignment: Alignment.topCenter,
          child: widget,
        ));
  }

  Widget nextLeftPosition(Widget widget) {
    return Positioned.fill(
        left: 60,
        child: Align(
          alignment: Alignment.centerLeft,
          child: widget,
        ));
  }

  Widget nextRightPosition(Widget widget) {
    return Positioned.fill(
        right: 60,
        child: Align(
          alignment: Alignment.centerRight,
          child: widget,
        ));
  }
}
