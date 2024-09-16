import 'dart:convert';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_schema_type.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/enums/player/controls_type.dart';
import 'package:onPlay/enums/music_card_type.dart';
import 'package:onPlay/enums/player/picture_type.dart';
import 'package:onPlay/enums/player/progress_type.dart';
import 'package:onPlay/enums/player/title_type.dart';

class InterfaceSettings {
  late Function() _notify;
  ColorSchemeType colorSchemeType = ColorSchemeType.totalMusicColor;
  bool _showChangeTheme = true;
  bool _showChangePalette = true;
  bool themeBasedOnTime = false;
  ColorPalette _colorPalette = ColorPalette.monocromatic;
  PictureType _pictureType = PictureType.gradient;
  ControlsType _controlsType = ControlsType.outline;
  MusicCardStyle style = MusicCardStyle.normal;
  ColorTheme _colorTheme = ColorTheme.totalDark;
  ProgressType _progressType = ProgressType.linear;
  TitleType _titleType = TitleType.loop;

  TitleType get titleType => _titleType;

  set titleType(TitleType value) {
    _titleType = value;
    _notify();
  }

  ProgressType get progressType => _progressType;

  set progressType(ProgressType value) {
    _progressType = value;
    _notify();
  }

  bool get showChangeTheme => _showChangeTheme;

  set showChangeTheme(bool value) {
    _showChangeTheme = value;
    _notify();
  }

  bool get showChangePalette => _showChangePalette;

  set showChangePallete(bool value) {
    _showChangePalette = value;
    _notify();
  }

  ColorPalette get colorPalette => _colorPalette;

  set colorPalette(ColorPalette value) {
    _colorPalette = value;
    _notify();
  }

  ColorTheme get colorTheme => _colorTheme;

  set colorTheme(ColorTheme theme) {
    _colorTheme = theme;
    _notify();
  }

  PictureType get pictureType => _pictureType;

  set pictureType(PictureType type) {
    _pictureType = type;
    _notify();
  }

  ControlsType get controlsType => _controlsType;

  set controlsType(ControlsType type) {
    _controlsType = type;
    _notify();
  }

  InterfaceSettings(Function() notify) {
    _notify = notify;
  }

  toJson() {
    return json.encode(
      this,
      toEncodable: (object) {
        final jsonMap = {};
        jsonMap["colorSchemeType"] = colorSchemeType.name;
        return jsonMap;
      },
    );
  }

  static toObject(Map<String, dynamic> map, Function() notify) {
    final obj = InterfaceSettings(notify);
    obj.colorSchemeType = ColorSchemeType.fromString(map["colorSchemeType"]);
    return obj;
  }

  @override
  bool operator ==(Object other) {
    if (other is InterfaceSettings) {
      return other.colorTheme == colorTheme &&
          other.colorPalette == colorPalette &&
          other.showChangePalette == showChangePalette &&
          other.showChangeTheme == showChangeTheme &&
          other.pictureType == pictureType &&
          other.controlsType == controlsType &&
          other.colorSchemeType == colorSchemeType;
    }
    return false;
  }
}
