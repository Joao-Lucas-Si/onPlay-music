import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/dtos/metadata_dto.dart';
import 'package:onPlay/services/metadata/metadata_service_adapter.dart';

class MetadataGodAdapter extends MetadataServiceAdapter {
  @override
  Future<SongMetadata> read(String path) async {
    try {
      final metadata = await MetadataGod.readMetadata(file: path);
      debugPrint(metadata.toString());
      return SongMetadata.fromMetadataGod(metadata);
    } catch (e) {
      return SongMetadata();
    }
  }

  @override
  Future<void> write(String path, SongMetadata metadata) async {
    await MetadataGod.writeMetadata(
        file: path, metadata: metadata.toMedatadaGod());
  }
}
