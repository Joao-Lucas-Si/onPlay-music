enum ColorSchemeType {
  selectedColor("selected"),
  totalMusicColor("totalMusic"),
  partialMusicColor("partialMusic"),
  appColor("app");

  static ColorSchemeType fromString(String name) {
    return ColorSchemeType.values.firstWhere((value) => value.name == name);
  }

  final String name;

  const ColorSchemeType(this.name);
}