import 'package:onPlay/dtos/metadata_dto.dart';

abstract class MetadataServiceAdapter {
  Future<SongMetadata> read(String path);
  Future<void> write(String path, SongMetadata metadata);
}
