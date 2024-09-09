import 'dart:typed_data';

import 'package:onPlay/dto/artist.dart';
import 'package:onPlay/dto/song.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Album {
  @Id()
  int id = 0;
  String name = "";

  @Property(type: PropertyType.byteVector)
  Uint8List? picture;

  final artist = ToOne<Artist>();

  @Backlink("album")
  final songs = ToMany<Song>();

  Album({required this.name, this.picture});
}
