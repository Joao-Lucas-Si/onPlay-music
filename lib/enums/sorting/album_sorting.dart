import 'package:onPlay/services/utils/get_enum_by_name.dart';

enum AlbumSorting {
  name,
  artist,
  songs,
  color;

  static AlbumSorting fromString(String name) =>
      getEnumByName(values: values, name: name);
}
