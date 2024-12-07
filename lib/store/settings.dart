import 'package:flutter/material.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/settings/interface.dart';
import 'package:onPlay/models/settings/layout.dart';
import 'package:onPlay/models/settings/settings.dart';
import 'package:onPlay/models/settings/share.dart';
import 'package:onPlay/models/settings/source.dart';
import 'package:onPlay/store/settings/interface.dart';
import 'package:onPlay/store/settings/layout.dart' as lay;
import 'package:onPlay/store/settings/player.dart';
import 'package:onPlay/store/settings/share.dart';
import 'package:onPlay/store/settings/source.dart';
import 'package:provider/provider.dart';

class Settings extends ChangeNotifier {
  var _change = false;
  BuildContext context;
  bool get change => _change;

  var recentRange = 30;

  InterfaceSettings get interface => _interface;

  PlayerSettings get player => _player;

  ShareSettings get share => _share;

  lay.LayoutSettings get layout => _layout;

  SourceSettings get source => _source;

  late InterfaceSettings _interface;
  late lay.LayoutSettings _layout;
  late SourceSettings _source;
  late ShareSettings _share;
  late PlayerSettings _player;

  reload() {
    notify() {
      _change = true;
      notifyListeners();
    }

    final managers = Provider.of<BoxManager>(context, listen: false);
    final user = managers.userManager.getActiveProfile();
    final settings = user.settings.target ?? DatabaseSettings(recentRange: 30);

    final interfaceManager = managers.interfaceManager;
    final shareManager = managers.shareManager;
    final layoutManager = managers.layoutManager;
    final manager = managers.settingsManager;

    _interface = InterfaceSettings(
        notify: (data) {
          notify();
          final showChangePalette = data.showChangePalette;
          final showChangeTheme = data.showChangeTheme;
          final themeBasedOnTime = data.themeBasedOnTime;
          final controlsType = data.controlsType;
          final pictureType = data.pictureType;
          final colorPalette = data.colorPalette;
          final titleType = data.titleType;
          final progressType = data.progressType;
          final colorTheme = data.colorTheme;
          final InterfaceSettings(
            :albumCardStyle,
            :songCardStyle,
            :genreCardStyle,
            :artistCardStyle,
            :playlistCardStyle,
            :coloredArtistCard,
            :coloredGenreCard,
            :coloredSongCard,
            :coloredAlbumCard,
            :coloredPlaylistCard,
            :albumRelationStyle,
            :genreRelationStyle,
            :artistRelationStyle
          ) = data;

          final interface = settings.interface.target ??
              DatabaseInterfaceSettings(
                dbBaseTheme: data.baseTheme.name,
                showChangePalette: showChangePalette,
                showChangeTheme: showChangeTheme,
                themeBasedOnTime: themeBasedOnTime,
                dbControlsType: controlsType.name,
                dbPictureType: pictureType.name,
                dbColorPalette: colorPalette.name,
                dbTitleType: titleType.name,
                dbProgressType: progressType.name,
                dbColorTheme: colorTheme.name,
                dbAlbumCardStyle: albumCardStyle.name,
                dbArtistCardStyle: artistCardStyle.name,
                dbGenreCardStyle: genreCardStyle.name,
                dbPlaylistCardStyle: playlistCardStyle.name,
                dbSongCardStyle: songCardStyle.name,
                coloredAlbumCard: coloredAlbumCard,
                coloredArtistCard: coloredArtistCard,
                coloredGenreCard: coloredGenreCard,
                coloredPlaylistCard: coloredPlaylistCard,
                coloredSongCard: coloredSongCard,
                dbAlbumRelationStyle: albumRelationStyle.name,
                dbGenreRelationStyle: genreRelationStyle.name,
                dbArtistRelationStyle: artistRelationStyle.name,
              );
          interface.showChangePalette = showChangePalette;
          interface.showChangeTheme = showChangeTheme;
          interface.themeBasedOnTime = themeBasedOnTime;
          interface.controlsType = controlsType;
          interface.pictureType = pictureType;
          interface.colorPalette = colorPalette;
          interface.titleType = titleType;
          interface.progressType = progressType;
          interface.colorTheme = colorTheme;
          interface.songCardStyle = songCardStyle;
          interface.albumCardStyle = albumCardStyle;
          interface.artistCardStyle = artistCardStyle;
          interface.genreCardStyle = genreCardStyle;
          interface.playlistCardStyle = playlistCardStyle;
          interface.baseTheme = data.baseTheme;
          interface.coloredSongCard = coloredSongCard;
          interface.coloredAlbumCard = coloredAlbumCard;
          interface.coloredArtistCard = coloredArtistCard;
          interface.coloredPlaylistCard = coloredPlaylistCard;
          interface.coloredGenreCard = coloredGenreCard;
          interface.albumRelationStyle = albumRelationStyle;
          interface.artistRelationStyle = artistRelationStyle;
          interface.genreRelationStyle = genreRelationStyle;

          settings.interface.target = interface;

       

          interfaceManager.save(interface);
          manager.save(settings);
        },
        database: settings.interface.target);
    _layout = lay.LayoutSettings(
        notify: (data) {
          notify();
          final layout = settings.layout.target ?? DatabaseLayoutSettings();
          layout.containerStyle = data.containerStyle;
          layout.hiddenScreens = data.hiddenScreens;
          // layout.lateralElements.clear();
          // layout.lateralElements.addAll(data.lateralElements.map((lateral) => LateralPlayer))
          layout.playerElements = data.playerElements;
          layout.volumeType = data.volumeType;
          layout.songGridItems = data.songGridItems;
          layout.albumGridItems = data.albumGridItems;
          layout.playlistGridItems = data.playlistGridItems;
          layout.artistGridItems = data.artistGridItems;
          layout.genreGridItems = data.genreGridItems;

          layout.lateralElements.clear();
          data.lateralElements.asMap().forEach((i, element) {
            layout.lateralElements.add(LateralPlayerElement(
                dbPosition: element.position.name,
                dbElement: element.element.name));
          });

          layoutManager.save(layout);
          settings.layout.target = layout;
          manager.save(settings);
        },
        database: settings.layout.target);
    _share = ShareSettings(
        notify: (data) {
          notify();
          final share = settings.share.target ??
              DatabaseShareSettings(editorUrls: data.editorUrls);
          share.editorUrls = data.editorUrls;

          shareManager.save(share);
          settings.share.target = share;
          manager.save(settings);
        },
        database: settings.share.target);
    _player = PlayerSettings(notify: notify, database: settings.player.target);
    _source = SourceSettings(
        notify: (data) {
          final source = settings.source.target ?? DatabaseSourceSettings();

          source.invidiousInstances = data.invidiousInstances;

          settings.source.target = source;
          manager.save(settings);
        },
        database: settings.source.target);
    notify();
  }

  Settings(this.context) {
    reload();
  }

  desableChange() {
    _change = false;
  }

  @override
  bool operator ==(Object other) {
    if (other is Settings) {
      return other.interface == interface &&
          other.layout == layout &&
          other.player == player &&
          other.recentRange == recentRange;
    }
    return false;
  }
}
