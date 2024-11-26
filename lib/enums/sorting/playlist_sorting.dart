import 'package:onPlay/services/utils/get_enum_by_name.dart';

enum PlaylistSorting {
  name,
  songs,
  color;

  static PlaylistSorting fromString(String name) =>
      getEnumByName(values: values, name: name);
}
