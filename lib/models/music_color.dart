import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/services/http/serializable.dart';

@Entity()
class MusicColor extends Serializable {
  @Id()
  int id = 0;
  @Transient()
  late Color background, text, other, icon, inactive;
  @Transient()
  late ColorPalette palette;
  @Transient()
  late ColorTheme theme;

  MusicColor.fromJson(Map json) {
    background = Color(json["background"]);
    text = Color(json["text"]);
    icon = Color(json["icon"]);
    other = Color(json["other"]);
    inactive = Color(json["inactive"]);
    palette = ColorPalette.getByName(json["pallete"]);
    theme = ColorTheme.getByName(json["them"]);
  }

  @override
  Map<String, dynamic> toJson() {
    String toHex(Color color) {
      return "#${(color.value).toRadixString(16).padLeft(6, '0').toUpperCase().substring(2)}";
    }

    return {
      "background": toHex(background),
      "text": toHex(text),
      "icon": toHex(icon),
      "inactive": toHex(inactive),
      "other": toHex(other),
    };
  }

  int get dbBackground => background.value;
  int get dbText => text.value;
  int get dbIcon => icon.value;
  int get dbInactive => inactive.value;
  int get dbOther => other.value;

  String get dbTheme => theme.name;
  String get dbPalette => palette.name;

  set dbTheme(String name) {
    theme = ColorTheme.getByName(name);
  }

  set dbPalette(String name) {
    palette = ColorPalette.getByName(name);
  }

  set dbBackground(int value) {
    background = Color(value);
  }

  set dbText(int value) {
    text = Color(value);
  }

  set dbIcon(int value) {
    icon = Color(value);
  }

  set dbInactive(int value) {
    inactive = Color(value);
  }

  set dbOther(int value) {
    other = Color(value);
  }

  @override
  String toString() {
    return """MusicColor { 
      background: $background, 
      text: $text, 
      icon: $icon, 
      inactive: $inactive, 
      other: $other,
      theme: ${theme.name},
      palette: ${palette.name}
    }""";
  }

  MusicColor.empty();

  MusicColor.create({
    required this.background,
    required this.text,
    required this.icon,
    required this.other,
    required this.inactive,
    required this.palette,
    required this.theme,
  });

  MusicColor({
    required int dbBackground,
    required int dbText,
    required int dbIcon,
    required int dbOther,
    required int dbInactive,
    required String dbPalette,
    required String dbTheme,
  }) {
    this.dbBackground = dbBackground;
    this.dbText = dbText;
    this.dbIcon = dbIcon;
    this.dbOther = dbOther;
    this.dbInactive = dbInactive;
    this.dbPalette = dbPalette;
    this.dbTheme = dbTheme;
  }
}
