import 'package:flutter/material.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_schema_type.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/enums/player/controls_type.dart';
import 'package:onPlay/enums/card_style.dart';
import 'package:onPlay/enums/player/picture_type.dart';
import 'package:onPlay/enums/player/progress_type.dart';
import 'package:onPlay/enums/player/relationship_style.dart';
import 'package:onPlay/enums/player/title_type.dart';
import 'package:onPlay/enums/themes.dart';
import 'package:onPlay/models/settings/interface.dart';

class InterfaceSettings {
  late Function() _notify;
  ColorSchemeType colorSchemeType = ColorSchemeType.totalMusicColor;
  bool _showChangeTheme = true;
  bool _showChangePalette = true;
  bool themeBasedOnTime = false;
  ColorPalette _colorPalette = ColorPalette.polychromatic;
  PictureType _pictureType = PictureType.gradient;
  ControlsType _controlsType = ControlsType.fill;
  CardStyle _songCardStyle = CardStyle.normal;
  bool _coloredSongCard = true,
      _coloredArtistCard = true,
      _coloredAlbumCard = true,
      _coloredGenreCard = true,
      _coloredPlaylistCard = true;
  CardStyle _artistCardStyle = CardStyle.image,
      _albumCardStyle = CardStyle.image,
      _genreCardStyle = CardStyle.image,
      _playlistCardStyle = CardStyle.image;
  RelationshipStyle _albumRelationStyle = RelationshipStyle.image,
      _artistRelationStyle = RelationshipStyle.circleImage,
      _genreRelationStyle = RelationshipStyle.name;

  RelationshipStyle get artistRelationStyle => _artistRelationStyle;
  RelationshipStyle get albumRelationStyle => _albumRelationStyle;
  RelationshipStyle get genreRelationStyle => _genreRelationStyle;

  set artistRelationStyle(RelationshipStyle value) {
    _artistRelationStyle = value;
    _notify();
  }

  set albumRelationStyle(RelationshipStyle value) {
    _albumRelationStyle = value;
    _notify();
  }

  set genreRelationStyle(RelationshipStyle value) {
    _genreRelationStyle = value;
    _notify();
  }

  ColorTheme _colorTheme = ColorTheme.totalDark;
  ProgressType _progressType = ProgressType.linear;
  TitleType _titleType = TitleType.loop;
  Themes _baseTheme = Themes.purple;

  bool get coloredSongCard => _coloredSongCard;
  bool get coloredAlbumCard => _coloredAlbumCard;
  bool get coloredPlaylistCard => _coloredPlaylistCard;
  bool get coloredGenreCard => _coloredGenreCard;
  bool get coloredArtistCard => _coloredArtistCard;

  set coloredSongCard(bool value) {
    _coloredSongCard = value;
    _notify();
  }

  set coloredAlbumCard(bool value) {
    _coloredAlbumCard = value;
    _notify();
  }

  set coloredArtistCard(bool value) {
    _coloredArtistCard = value;
    _notify();
  }

  set coloredGenreCard(bool value) {
    _coloredGenreCard = value;
    _notify();
  }

  set coloredPlaylistCard(bool value) {
    _coloredPlaylistCard = value;
    _notify();
  }

  CardStyle get songCardStyle => _songCardStyle;

  set songCardStyle(CardStyle style) {
    _songCardStyle = style;
    _notify();
  }

  CardStyle get albumCardStyle => _albumCardStyle;

  set albumCardStyle(CardStyle style) {
    _albumCardStyle = style;
    _notify();
  }

  CardStyle get artistCardStyle => _artistCardStyle;

  set artistCardStyle(CardStyle style) {
    _artistCardStyle = style;
    _notify();
  }

  CardStyle get playlistCardStyle => _playlistCardStyle;

  set playlistCardStyle(CardStyle style) {
    _playlistCardStyle = style;
    _notify();
  }

  CardStyle get genreCardStyle => _genreCardStyle;

  set genreCardStyle(CardStyle style) {
    _genreCardStyle = style;
    _notify();
  }

  Themes get baseTheme => _baseTheme;

  set baseTheme(Themes theme) {
    _baseTheme = theme;
    _notify();
  }

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

  set showChangePalette(bool value) {
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

  InterfaceSettings(
      {required Function(InterfaceSettings interface) notify,
      DatabaseInterfaceSettings? database}) {
    _notify = () {
      notify(this);
    };
    if (database != null) {
      debugPrint(database.colorTheme.name);
      _controlsType = database.controlsType;
      _colorPalette = database.colorPalette;
      _showChangePalette = database.showChangePalette;
      _baseTheme = database.baseTheme;
      themeBasedOnTime = database.themeBasedOnTime;
      _songCardStyle = database.songCardStyle;
      _albumCardStyle = database.albumCardStyle;
      _playlistCardStyle = database.playlistCardStyle;
      _artistCardStyle = database.artistCardStyle;
      _genreCardStyle = database.genreCardStyle;
      // _songCardStyle = database.songCardStyle;
      colorSchemeType = database.colorSchemeType;
      _progressType = database.progressType;
      _pictureType = database.pictureType;
      _colorTheme = database.colorTheme;
      _coloredAlbumCard = database.coloredAlbumCard;
      _coloredSongCard = database.coloredSongCard;
      _coloredArtistCard = database.coloredArtistCard;
      _coloredPlaylistCard = database.coloredPlaylistCard;
      _coloredGenreCard = database.coloredGenreCard;
    }
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
