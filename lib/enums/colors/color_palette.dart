enum ColorPalette {
  normal,
  polychromatic,
  monocromatic;

  

  static ColorPalette getByName(String name) {
    return ColorPalette.values.firstWhere((color) => color.name == name);
  }

}
