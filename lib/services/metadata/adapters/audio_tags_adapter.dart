import 'package:audiotags/audiotags.dart';
import 'package:onPlay/dtos/metadata_dto.dart';
import 'package:onPlay/services/metadata/metadata_service_adapter.dart';

class AudioTagsAdapter extends MetadataServiceAdapter {
  @override
  Future<SongMetadata> read(String path) async {
    final tags = await AudioTags.read(path);
    return SongMetadata.fromAudioTags(tags);
  }

  @override
  Future<void> write(String path, SongMetadata metadata) async {
    await AudioTags.write(path, metadata.toAudioTags());
  }
}
