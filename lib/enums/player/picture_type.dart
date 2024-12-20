enum PictureType {
  background("background"),
  circular("circular"),
  gradient("gradient"),
  disk("disk"),
  square("square");

  static PictureType fromString(String name) {
    return PictureType.values.firstWhere((type) => type.name == name);
  }

  final String name;

  const PictureType(this.name);
}
