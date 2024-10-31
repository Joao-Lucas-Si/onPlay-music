import 'package:flutter/material.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:provider/provider.dart';

class ChangePalette extends StatelessWidget {
  final MusicColor musicColor;
  const ChangePalette({super.key, required this.musicColor});
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final interface = settings.interface;
    final theme = settings.interface.colorPalette;

    return GestureDetector(
      onTap: () {
        if (theme == ColorPalette.normal) {
          interface.colorPalette = ColorPalette.monocromatic;
        } else if (theme == ColorPalette.monocromatic) {
          interface.colorPalette = ColorPalette.polychromatic;
        } else {
          interface.colorPalette = ColorPalette.normal;
        }
      },
      child: Text(
        interface.colorPalette.name,
        style: TextStyle(color: musicColor.text),
      ),
    );
  }
}
