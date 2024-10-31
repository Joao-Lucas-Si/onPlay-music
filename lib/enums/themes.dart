
enum Themes {
  red,
  orange,
  green,
  blue,
  yellow,
  pink,
  purple;

  static Themes fromString(String name) {
    return Themes.values.firstWhere((theme) => theme.name == name);
  }
}
