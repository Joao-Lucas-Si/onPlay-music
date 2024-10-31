enum SongSorting {
  name,
  year,
  duration,
  modificationDate,
  color;

  static SongSorting fromString(String name) {
    return SongSorting.values.firstWhere((sorting) => sorting.name == name);
  }
}
