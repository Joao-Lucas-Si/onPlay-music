enum CardStyle {
  normal("normal"),
  listItem("listItem"),
  image("image"),
  circular("circular");

  static CardStyle fromString(String name) {
    return CardStyle.values.firstWhere((value) => value.name == name);
  }

  final String _name;

  String get name => _name;

  const CardStyle(this._name);
}
