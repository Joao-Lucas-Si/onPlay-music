import 'package:onPlay/constants/themes/blue.dart';
import 'package:onPlay/constants/themes/green.dart';
import 'package:onPlay/constants/themes/orange.dart';
import 'package:onPlay/constants/themes/pink.dart';
import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/constants/themes/red.dart';
import 'package:onPlay/constants/themes/yellow.dart';
import 'package:onPlay/enums/themes.dart';
import 'package:onPlay/models/music_color.dart';

MusicColor getBaseTheme(Themes theme) {
  switch (theme) {
    case Themes.orange:
      return orangeTheme;

    case Themes.red:
      return redTheme;
    case Themes.purple:
      return purpleTheme;

    case Themes.green:
      return greenTheme;
    case Themes.blue:
      return blueTheme;
    case Themes.yellow:
      return yellowTheme;
    case Themes.pink:
      return pinkTheme;
  }
}
