import 'package:onPlay/services/utils/get_enum_by_name.dart';

enum SongSorting {
  name,
  year,
  duration,
  modificationDate,
  color;

  static SongSorting fromString(String name) =>
      getEnumByName(values: values, name: name);
}
