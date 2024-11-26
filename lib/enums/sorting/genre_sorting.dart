import 'package:onPlay/services/utils/get_enum_by_name.dart';

enum GenreSorting {
  name,
  songs,
  color;

  static GenreSorting fromString(String name) =>
      getEnumByName(values: values, name: name);
}