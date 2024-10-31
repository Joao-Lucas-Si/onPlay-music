enum ProgressType {
  linear,
  disk,
  skip;

   static ProgressType fromString(String name) =>
      ProgressType.values.firstWhere((type) => type.name == name);
}
