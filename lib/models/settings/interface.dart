import 'package:objectbox/objectbox.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_schema_type.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/enums/player/controls_type.dart';
import 'package:onPlay/enums/card_type.dart';
import 'package:onPlay/enums/player/picture_type.dart';
import 'package:onPlay/enums/player/progress_type.dart';
import 'package:onPlay/enums/player/title_type.dart';
import 'package:onPlay/enums/themes.dart';

@Entity()
class DatabaseInterfaceSettings {
  @Id()
  int id = 0;
  @Transient()
  ColorSchemeType colorSchemeType = ColorSchemeType.totalMusicColor;
  bool showChangeTheme = true;
  bool showChangePalette = true;
  bool themeBasedOnTime = false;
  @Transient()
  ColorPalette colorPalette = ColorPalette.polychromatic;
  @Transient()
  PictureType pictureType = PictureType.gradient;
  @Transient()
  ControlsType controlsType = ControlsType.fill;
  @Transient()
  CardStyle songCardStyle = CardStyle.normal,
      genreCardStyle = CardStyle.normal,
      artistCardStyle = CardStyle.normal,
      albumCardStyle = CardStyle.normal,
      playlistCardStyle = CardStyle.normal;
  @Transient()
  ColorTheme colorTheme = ColorTheme.totalDark;
  @Transient()
  ProgressType progressType = ProgressType.linear;
  @Transient()
  TitleType titleType = TitleType.loop;
  @Transient()
  Themes baseTheme = Themes.purple;

  bool coloredSongCard,
      coloredAlbumCard,
      coloredGenreCard,
      coloredArtistCard,
      coloredPlaylistCard = true;

  String get dbBaseTheme => baseTheme.name;

  set dbBaseTheme(String name) {
    baseTheme = Themes.fromString(name);
  }

  String get dbSongCardStyle => songCardStyle.name;

  set dbSongCardStyle(String dbStyle) {
    songCardStyle = CardStyle.fromString(dbStyle);
  }

  String get dbAlbumCardStyle => albumCardStyle.name;

  set dbAlbumCardStyle(String dbStyle) {
    albumCardStyle = CardStyle.fromString(dbStyle);
  }

  String get dbArtistCardStyle => artistCardStyle.name;

  set dbArtistCardStyle(String dbStyle) {
    artistCardStyle = CardStyle.fromString(dbStyle);
  }

  String get dbPlaylistCardStyle => songCardStyle.name;

  set dbPlaylistCardStyle(String dbStyle) {
    songCardStyle = CardStyle.fromString(dbStyle);
  }

  String get dbGenreCardStyle => genreCardStyle.name;

  set dbGenreCardStyle(String dbStyle) {
    genreCardStyle = CardStyle.fromString(dbStyle);
  }

  String get dbTitleType => titleType.name;

  set dbTitleType(String value) {
    titleType = TitleType.fromString(value);
  }

  String get dbProgressType => progressType.name;

  set dbProgressType(String value) {
    progressType = ProgressType.fromString(value);
  }

  String get dbColorPalette => colorPalette.name;

  set dbColorPalette(String value) {
    colorPalette = ColorPalette.getByName(value);
  }

  String get dbColorTheme => colorTheme.name;

  set dbColorTheme(String theme) {
    colorTheme = ColorTheme.getByName(theme);
  }

  String get dbPictureType => pictureType.name;

  set dbPictureType(String type) {
    pictureType = PictureType.fromString(type);
  }

  String get dbControlsType => controlsType.name;

  set dbControlsType(String type) {
    controlsType = ControlsType.fromString(type);
  }

  DatabaseInterfaceSettings(
      {required this.showChangePalette,
      required this.showChangeTheme,
      required this.themeBasedOnTime,
      required String dbControlsType,
      required String dbPictureType,
      required String dbColorPalette,
      required String dbTitleType,
      required String dbProgressType,
      required String dbBaseTheme,
      required String dbColorTheme,
      required this.coloredAlbumCard,
      required this.coloredGenreCard,
      required this.coloredArtistCard,
      required this.coloredPlaylistCard,
      required this.coloredSongCard,
      required String dbSongCardStyle,
      required String dbAlbumCardStyle,
      required String dbGenreCardStyle,
      required String dbArtistCardStyle,
      required String dbPlaylistCardStyle}) {
    this.dbControlsType = dbControlsType;
    this.dbColorPalette = dbColorPalette;
    this.dbPictureType = dbPictureType;
    this.dbBaseTheme = dbBaseTheme;
    this.dbTitleType = dbTitleType;
    this.dbProgressType = dbProgressType;
    this.dbColorTheme = dbColorTheme;
    this.dbSongCardStyle = dbSongCardStyle;
    this.dbAlbumCardStyle = dbAlbumCardStyle;
    this.dbGenreCardStyle = dbGenreCardStyle;
    this.dbPlaylistCardStyle = dbPlaylistCardStyle;
    this.dbArtistCardStyle = dbArtistCardStyle;
  }
}
