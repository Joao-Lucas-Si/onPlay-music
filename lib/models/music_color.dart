import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/models/song.dart';

@Entity()
class MusicColor {
  @Id()
  int id = 0;
  @Transient()
  late Color background, text, other, icon, inactive;
  @Transient()
  late ColorPalette palette;
  @Transient()
  late ColorTheme theme;

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

  final song = ToOne<Song>();

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
