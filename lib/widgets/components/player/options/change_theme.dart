import 'package:flutter/material.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatelessWidget {
  final MusicColor musicColor;
  const ChangeTheme({super.key, required this.musicColor});
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final interface = settings.interface;
    final theme = settings.interface.colorTheme;

    return IconButton(
        onPressed: () {
          if (theme == ColorTheme.totalDark) {
            interface.colorTheme = ColorTheme.light;
          } else if (theme == ColorTheme.dark) {
            interface.colorTheme = ColorTheme.totalDark;
          } else {
            interface.colorTheme = ColorTheme.dark;
          }
        },
        icon: Icon(
          theme == ColorTheme.totalDark
              ? Icons.dark_mode
              : theme == ColorTheme.dark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode,
          color: musicColor.text,
        ));
  }
}
