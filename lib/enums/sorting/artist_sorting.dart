import 'package:onPlay/services/utils/get_enum_by_name.dart';

enum ArtistSorting {
  name, 
  songs,
  color,
  albums;

  static ArtistSorting fromString(String name) =>
      getEnumByName(values: values, name: name);
}