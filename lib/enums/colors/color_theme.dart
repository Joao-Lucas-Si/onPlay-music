enum ColorTheme {
  totalDark("totalDark"),
  dark("dark"),
  light("light");

  final String name;

  static ColorTheme getByName(String name) {
    return ColorTheme.values.firstWhere((color) => color.name == name);
  }

  const ColorTheme(this.name);
}
