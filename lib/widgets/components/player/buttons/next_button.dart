import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/controls_type.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:provider/provider.dart';

class NextButton extends StatelessWidget {
  final bool isSmall;
  final bool isInMiniPlayer;
  final MusicColor musicColor;
  const NextButton(
      {this.isSmall = false, this.isInMiniPlayer = false, super.key, required this.musicColor});

  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    final settings = Provider.of<Settings>(context);
    final interfaceSettings = settings.interface;

    return playerStore.hasNext
        ? InkWell(
            onTap: () {
              playerStore.runNext();
            },
            child: DecoratedBox(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: interfaceSettings.controlsType ==
                            ControlsType.circleButton
                        ? musicColor.text
                        : Colors.transparent),
                child: Icon(
                  interfaceSettings.controlsType == ControlsType.outline
                      ? Icons.skip_next_outlined
                      : Icons.skip_next,
                  size: isSmall ? 30 : 40,
                  color: interfaceSettings.controlsType ==
                          ControlsType.circleButton
                      ? musicColor.background
                      : isInMiniPlayer
                          ? musicColor.background
                          : musicColor.text,
                )))
        : const SizedBox(
            width: 40,
            height: 40,
          );
  }
}
