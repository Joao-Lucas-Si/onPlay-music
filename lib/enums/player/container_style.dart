enum ContainerStyle {
  normal("normal"),
  card("card"),
  lateral("lateral");

  final String value;

  const ContainerStyle(this.value);

  static ContainerStyle getByValue(String value) =>
      ContainerStyle.values.firstWhere((style) => style.value == value);
}
