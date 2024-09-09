import 'dart:typed_data';

import 'package:onPlay/dto/song.dart';
import 'package:onPlay/dto/album.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Artist {
  @Id()
  int id = 0;
  final String name;

  @Property(type: PropertyType.byteVector)
  Uint8List? picture;

  @Backlink("artist")
  final songs = ToMany<Song>();
  @Backlink("artist")
  final albums = ToMany<Album>();

  Artist({
    required this.name,
    this.picture,
  });
}
