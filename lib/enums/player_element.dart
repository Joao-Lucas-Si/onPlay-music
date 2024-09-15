enum PlayerElement {
  options("options"),
  title("title"),
  position("position"),
  volume("volume"),
  controls("controls"),
  picture("picture");

  static PlayerElement fromString(String name) {
    return PlayerElement.values.firstWhere((element) => element.name == name);
  }

  final String name;

  const PlayerElement(this.name);
}