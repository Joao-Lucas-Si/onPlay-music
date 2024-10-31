import 'package:objectbox/objectbox.dart';
import 'package:onPlay/enums/player/container_style.dart';
import 'package:onPlay/enums/main_screens.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/enums/player/volume_type.dart';
import 'package:onPlay/store/settings/layout.dart';

@Entity()
class DatabaseLayoutSettings {
  @Id()
  int id = 0;

  String get dbContainerStyle => containerStyle.value;

  int songGridItems = 1,
      artistGridItems = 1,
      genreGridItems = 1,
      albumGridItems = 1,
      playlistGridItems = 1;

  set dbContainerStyle(String value) {
    containerStyle = ContainerStyle.getByValue(value);
  }

  @Transient()
  var containerStyle = ContainerStyle.lateral;

  @Transient()
  var mainScreens = [
    MainScreens.home,
    MainScreens.musics,
    MainScreens.artists,
    MainScreens.albums,
    MainScreens.playlists,
    MainScreens.genres,
  ];

  List<String> get dbMainScreens =>
      mainScreens.map((screen) => screen.name).toList();

  set dbMainScreens(List<String> screens) {
    mainScreens =
        screens.map((screen) => MainScreens.fromString(screen)).toList();
  }

  @Transient()
  List<MainScreens> hiddenScreens = [];

  List<String> get dbHiddenScreens =>
      hiddenScreens.map((screen) => screen.name).toList();

  set dbHiddenScreens(List<String> screens) {
    hiddenScreens =
        screens.map((screen) => MainScreens.fromString(screen)).toList();
  }

  final lateralElements = ToMany<LateralPlayerElement>();

  VolumeType volumeType = VolumeType.levels;

  String get dbVolumeType => volumeType.name;

  set dbVolumeType(String name) {
    volumeType = VolumeType.fromString(name);
  }

  List<PlayerElement> playerElements = [
    PlayerElement.picture,
    PlayerElement.options,
    PlayerElement.title,
    PlayerElement.position,
    PlayerElement.controls,
    PlayerElement.volume,
  ];

  List<String> get dbPlayerElements =>
      playerElements.map((element) => element.name).toList();
  set dbPlayerElements(List<String> elements) {
    playerElements =
        elements.map((element) => PlayerElement.fromString(element)).toList();
  }
}

@Entity()
class LateralPlayerElement {
  @Id()
  int id = 0;
  @Transient()
  late LateralPosition position;
  @Transient()
  late PlayerElement element;

  String get dbElement => element.name;

  set dbElement(String name) {
    element = PlayerElement.fromString(name);
  }

  String get dbPosition => position.name;

  set dbPosition(String name) {
    position = LateralPosition.getByName(name);
  }

  LateralPlayerElement(
      {required String dbPosition, required String dbElement}) {
    this.dbPosition = dbPosition;
    this.dbElement = dbElement;
  }

  LateralPlayerElement.create({required this.element, required this.position});
}
