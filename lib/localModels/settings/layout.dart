import 'dart:convert';
import 'package:onPlay/enums/player/container_style.dart';
import 'package:onPlay/enums/main_screens.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/enums/player/volume_type.dart';

class LayoutSettings {
  var showArtists = true;
  var showGenres = true;
  var showPlaylists = true;
  var _containerStyle = ContainerStyle.lateral;
  var _mainScreens = const [
    MainScreens.home,
    MainScreens.musics,
    MainScreens.artists,
    MainScreens.albums,
    MainScreens.playlists,
    MainScreens.genres,
  ];
  List<MainScreens> _hiddenScreens = [];

  var _lateralElements = [
    LateralPlayerElement(
        element: PlayerElement.controls, position: LateralPosition.topBottom),
    LateralPlayerElement(
        element: PlayerElement.title, position: LateralPosition.bottom),
    LateralPlayerElement(
        element: PlayerElement.options, position: LateralPosition.top),
    LateralPlayerElement(
        element: PlayerElement.volume, position: LateralPosition.left),
    LateralPlayerElement(
        element: PlayerElement.position, position: LateralPosition.nextLeft),
  ];

  List<LateralPlayerElement> get lateralElements => _lateralElements;

  set lateralElements(List<LateralPlayerElement> value) {
    _lateralElements = value;
    _notify();
  }

  ContainerStyle get containerStyle => _containerStyle;

  set containerStyle(ContainerStyle value) {
    _containerStyle = value;
    _notify();
  }

  List<MainScreens> get hiddenScreens => _hiddenScreens;

  List<MainScreens> get mainScreens => _mainScreens;

  replaceMainScreens(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final screen = _mainScreens[oldIndex];
    _mainScreens.removeAt(oldIndex);
    _mainScreens.insert(newIndex, screen);
    _notify();
  }

  hiddenScreen(MainScreens screen) {
    hiddenScreens.add(screen);
    mainScreens.remove(screen);
    _notify();
  }

  showScreen(MainScreens screen) {
    hiddenScreens.remove(screen);
    mainScreens.add(screen);
    _notify();
  }

  VolumeType _volumeType = VolumeType.levels;

  VolumeType get volumeType => _volumeType;

  set volumeType(VolumeType value) {
    _volumeType = value;
    _notify();
  }

  late final Function() _notify;
  List<PlayerElement> _playerElements = [
    PlayerElement.picture,
    PlayerElement.options,
    PlayerElement.title,
    PlayerElement.position,
    PlayerElement.controls,
    PlayerElement.volume,
  ];

  List<PlayerElement> get playerElements => _playerElements;

  set playerElements(List<PlayerElement> value) {
    _playerElements = value;
    _notify();
  }

  LayoutSettings(Function() notify) {
    _notify = notify;
  }

  toJson() {
    return json.encode(
      this,
      toEncodable: (object) {
        final jsonMap = {};
        jsonMap["showArtists"] = showArtists;
        jsonMap["showGenres"] = showGenres;
        jsonMap["showPlaylists "] = showPlaylists;
        return jsonMap;
      },
    );
  }

  static toObject(Map<String, dynamic> map) {
    // final obj = InterfaceSettings();
    // obj.primaryColor = map["primaryColor"];
    // obj.colorSchemeType = map["colorSchemeType"];
    // return obj;
  }

  @override
  bool operator ==(Object other) {
    if (other is LayoutSettings) {
      return showArtists == other.showArtists &&
          showGenres == other.showArtists &&
          other.showPlaylists == showPlaylists &&
          other.volumeType == volumeType;
    }
    return false;
  }
}

class LateralPlayerElement {
  LateralPosition position;
  final PlayerElement element;

  LateralPlayerElement({required this.element, required this.position});
}

enum LateralPosition {
  top,
  underTop,
  bottom,
  topBottom,
  center,
  left,
  nextLeft,
  nextRight,
  right;
}
