import 'dart:typed_data';

import 'package:myapp/dto/song.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Genre {
  @Id()
  int id = 0;
  String name;

  @Property(type: PropertyType.byteVector)
  Uint8List? picture;

  @Backlink("genre")
  final songs = ToMany<Song>();

  Genre({required this.name, this.picture});
}
