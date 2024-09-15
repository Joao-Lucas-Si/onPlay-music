enum MusicCardStyle {
  normal("normal"),
  colorful("colorful"),
  listItem("listItem"),
  image("image"),
  gradientImage("gradientImage"),
  circular("circular");

  static MusicCardStyle fromString(String name) {
    return MusicCardStyle.values.firstWhere((value) => value.name == name);
  }

  final String _name;

  String get name => _name;

  const MusicCardStyle(this._name);
}