import 'dart:typed_data';

import 'package:onPlay/models/song.dart';
import 'package:onPlay/models/album.dart';
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

  @override
  bool operator ==(Object other) {
    if (other is Artist) {
      return (other.id != 0 && id != 0 && other.id == id) || other.name == name;
    }
    return false;
  }
}
