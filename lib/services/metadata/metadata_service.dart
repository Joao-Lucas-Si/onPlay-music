import 'package:onPlay/dtos/metadata_dto.dart';
import 'package:onPlay/services/metadata/adapters/metadata_god_adapter.dart';

class MetadataService {
  final _adapter = MetadataGodAdapter();
  Future<SongMetadata> read(String path) => _adapter.read(path);
  Future<void> write(String path, SongMetadata metadata) =>
      _adapter.write(path, metadata);
}
