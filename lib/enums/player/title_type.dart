enum TitleType {
  loop,
  option;

  static TitleType fromString(String name) =>
      TitleType.values.firstWhere((type) => type.name == name);
}
