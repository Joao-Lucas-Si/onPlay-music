import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/dto/song.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';

class FilesService {
  static bool permission = false;
  static Future<bool> requestPermission() async {
    if (FilesService.permission) {
      return FilesService.permission;
    } else {
      final permission = await Permission.storage.request();
      FilesService.permission = permission.isGranted;
      return permission.isGranted;
    }
  }

  static Future<Metadata> extractMetadata(String path) async {
    return await MetadataGod.readMetadata(file: path);
  }

  static Future<List<FileSystemEntity>> getAllMusicFiles(
      Function(String message)? setLoading) async {
    if (setLoading != null) setLoading("obtendo permissao");
    final permission = await requestPermission();
    if (permission) {
      if (setLoading != null) setLoading("acessando armazenamento");
      List<String> paths = [];
      try {
        paths = await ExternalPath.getExternalStorageDirectories();
      } catch (e) {
        paths = ["/storage/emulated/0"];
      }
      if (setLoading != null) setLoading(paths.toString());
      print(paths);

      // paths = paths
      //     .expand((path) =>
      //         ["Music", "Download"].map((folder) => p.join(path, folder)))
      //     .toList();
      paths = ["Music"].map((folder) => p.join(paths[0], folder)).toList();

      print(paths);

      List<FileSystemEntity> musics = [];
      for (final path in paths) {
        if (setLoading != null) setLoading("acessando armazenamento");
        if (setLoading != null) setLoading(path);
        Directory dir = Directory(path);
        if (setLoading != null) setLoading("coletando todos os arquivos");
        final files = dir.listSync(
          recursive: true,
          followLinks: false,
        );
        if (setLoading != null) setLoading("filtrando arquivos mp3");
        for (FileSystemEntity entity in files) {
          String path = entity.path;
          if (["mp3", "opus", "m4a"]
              .any((extension) => path.endsWith('.$extension'))) {
            if (setLoading != null) {
              setLoading(
                  "arquivo ${(await extractMetadata(path)).title ?? ""}");
            }
            musics.add(entity);
          }
        }
      }
      return musics;
    }
    if (setLoading != null) setLoading("sem permissão");
    return [];
  }

  static Future<List<Song>> getAllMusics(
      Function(String state) setLoading) async {
    setLoading("coletando os arquivos");
    final files = await getAllMusicFiles(setLoading);
    List<Song> songs = [];
    for (FileSystemEntity file in files) {
      final metadata = await extractMetadataFromFile(file);
      setLoading("arquivo - ${metadata.title}");
      songs.add(Song.withFileData(
          path: file.path,
          metadata: metadata,
          file: file,
          duration: metadata.duration?.inSeconds,
          year: metadata.year,
          picture: metadata.picture?.data,
          title: metadata.title));
    }
    setLoading("");
    return songs;
  }

  static Future<Metadata> extractMetadataFromFile(FileSystemEntity file) async {
    return await MetadataGod.readMetadata(file: file.path);
  }

  static Future<List<Metadata>> extractAllMetadata() async {
    final files = await getAllMusicFiles(null);
    List<Metadata> metadatas = [];

    for (FileSystemEntity file in files) {
      metadatas.add(await extractMetadataFromFile(file));
    }

    return metadatas;
  }
}
