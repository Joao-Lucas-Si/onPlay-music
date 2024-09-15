enum ControlsType {
  outline("outline"),
  circleButton("circleButton"),
  fill("fill");

  static ControlsType fromString(String name) {
    return ControlsType.values.firstWhere((type) => type.name == name);
  }

  final String name;
  const ControlsType(this.name);
}
