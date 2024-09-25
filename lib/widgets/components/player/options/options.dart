import 'package:flutter/material.dart';
import 'package:onPlay/enums/player/title_type.dart';
import 'package:onPlay/enums/player/volume_type.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_adapter.dart';
import 'package:onPlay/widgets/components/player/options/change_palette.dart';
import 'package:onPlay/widgets/components/player/options/change_theme.dart';
import 'package:onPlay/widgets/components/player/options/music_flow.dart';
import 'package:onPlay/widgets/components/player/options/velocity.dart';
import 'package:onPlay/widgets/components/player/title/title_option.dart';
import 'package:onPlay/widgets/components/player/volume/volume_option.dart';
import 'package:provider/provider.dart';

class Options extends StatelessWidget {
  final Song song;
  final MusicColor musicColor;
  final bool isVertical;
  const Options(
      {super.key,
      required this.song,
      required this.musicColor,
      this.isVertical = false});
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final layout = settings.layout;
    final interface = settings.interface;
    return Wrap(
      spacing: 10,
      alignment: isVertical ? WrapAlignment.center : WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        interface.showChangeTheme ? ChangeTheme(musicColor: musicColor) : null,
        VelocityController(musicColor: musicColor),
        // MusicPopup(
        //   song: playerStore.playingSong!,
        // ),
        interface.titleType == TitleType.option
            ? TitleOption(musicColor: musicColor, song: song)
            : null,
        MusicFlow(musicColor: musicColor),
        layout.volumeType == VolumeType.option
            ? VolumeOption(
                musicColor: musicColor,
              )
            : null,
        interface.showChangePalette
            ? ChangePalette(musicColor: musicColor)
            : null
      ].nonNulls.toList(),
    );
  }
}
