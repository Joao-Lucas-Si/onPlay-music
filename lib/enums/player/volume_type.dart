enum VolumeType {
  levels,
  steps,
  slider,
  option;

  static VolumeType fromString(String name) =>
      VolumeType.values.firstWhere((type) => type.name == name);
}
