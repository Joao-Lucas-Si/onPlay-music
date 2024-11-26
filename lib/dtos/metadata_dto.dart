import 'dart:typed_data';

import 'package:audiotags/audiotags.dart';
import 'package:metadata_god/metadata_god.dart' as MetadataGod;

class SongMetadata {
  String? artist, album, genre, title, imageMimeType;
  Uint8List? image;
  int? year;
  int? duration;

  MetadataGod.Metadata toMedatadaGod() {
    final metadata = MetadataGod.Metadata(
      album: album,
      artist: artist,
      title: title,
      genre: genre,
      year: year,
      durationMs: (duration ?? 0) / 60,
      picture: (imageMimeType != null && image != null)
          ? MetadataGod.Picture(mimeType: imageMimeType!, data: image!)
          : null,
    );
    return metadata;
  }

  factory SongMetadata.fromMetadataGod(MetadataGod.Metadata metadata) =>
      SongMetadata(
          album: metadata.album,
          artist: metadata.artist,
          genre: metadata.genre,
          image: metadata.picture?.data,
          imageMimeType: metadata.picture?.mimeType,
          title: metadata.title,
          duration: metadata.duration?.inSeconds,
          year: metadata.year);

  Tag toAudioTags() => Tag(
        pictures: imageMimeType != null && image != null
            ? [Picture(pictureType: PictureType.band, bytes: image!)]
            : [],
        album: album,
        albumArtist: artist,
        duration: duration,
        genre: genre,
        year: year,
        title: title,
      );

  factory SongMetadata.fromAudioTags(Tag? metadata) => SongMetadata(
      album: metadata?.album,
      artist: metadata?.albumArtist,
      genre: metadata?.genre,
      image: metadata?.pictures.first.bytes,
      imageMimeType: metadata?.pictures.first.mimeType?.name,
      title: metadata?.title,
      duration: metadata?.duration,
      year: metadata?.year);

  SongMetadata(
      {this.album,
      this.year,
      this.title,
      this.duration,
      this.artist,
      this.genre,
      this.image,
      this.imageMimeType});
}
