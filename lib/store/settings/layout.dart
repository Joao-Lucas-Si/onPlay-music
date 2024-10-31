import 'package:onPlay/enums/player/container_style.dart';
import 'package:onPlay/enums/main_screens.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/enums/player/volume_type.dart';
import 'package:onPlay/models/settings/layout.dart';

class LayoutSettings {
  var _songGridItems = 1,
      _artistGridItems = 1,
      _genreGridItems = 1,
      _playlistGridItems = 1,
      _albumGridItems = 2;
  var _containerStyle = ContainerStyle.lateral;
  var _mainScreens = [
    MainScreens.home,
    MainScreens.musics,
    MainScreens.artists,
    MainScreens.albums,
    MainScreens.playlists,
    MainScreens.genres,
  ];
  List<MainScreens> _hiddenScreens = [];

  int get songGridItems => _songGridItems;

  set songGridItems(int items) {
    _songGridItems = items;
    _notify();
  }

  int get artistGridItems => _artistGridItems;

  set artistGridItems(int items) {
    _artistGridItems = items;
    _notify();
  }

  int get albumGridItems => _albumGridItems;

  set albumGridItems(int items) {
    _albumGridItems = items;
    _notify();
  }

  int get playlistGridItems => _playlistGridItems;

  set playlistGridItems(int items) {
    _playlistGridItems = items;
    _notify();
  }

  int get genreGridItems => _genreGridItems;

  set genreGridItems(int items) {
    _genreGridItems = items;
    _notify();
  }

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
    _mainScreens = _mainScreens;
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

  LayoutSettings(
      {required Function(LayoutSettings data) notify,
      DatabaseLayoutSettings? database}) {
    _notify = () {
      notify(this);
    };
    if (database != null) {
      _playerElements = database.playerElements;
      _containerStyle = database.containerStyle;
      _volumeType = database.volumeType;
      _songGridItems = database.songGridItems;
      _artistGridItems = database.artistGridItems;
      _albumGridItems = database.albumGridItems;
      _playlistGridItems = database.playlistGridItems;

      _genreGridItems = database.genreGridItems;

      _mainScreens = database.mainScreens;
      _lateralElements = database.lateralElements
          .map((element) => LateralPlayerElement(
              element: element.element, position: element.position))
          .toList();
      _hiddenScreens = database.hiddenScreens;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is LayoutSettings) {
      return other.volumeType == volumeType;
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

  static LateralPosition getByName(String name) =>
      LateralPosition.values.firstWhere((position) => position.name == name);
}
