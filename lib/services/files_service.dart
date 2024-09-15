import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/models/song.dart';
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

  static listenDirectory({
    required Directory dir,
    required Function(FileSystemCreateEvent event) onCreate,
    required Function(FileSystemMoveEvent event) onMove,
    required Function(FileSystemDeleteEvent event) onDelete,
    required Function(FileSystemModifyEvent event) onModify,
  }) {
    dir
        .watch(
      recursive: true,
    )
        .listen(
      (event) {
        debugPrint("evento, ${event.isDirectory}");
        if (!event.isDirectory &&
            musicExtensions
                .any((extension) => event.path.endsWith(extension))) {
          switch (event) {
            case FileSystemCreateEvent e:
              onCreate(e);
              break;
            case FileSystemModifyEvent e:
              onModify(e);
              break;
            case FileSystemDeleteEvent e:
              onDelete(e);
              break;
            case FileSystemMoveEvent e:
              onMove(e);
              break;
          }
        }
      },
    );
  }

  static Future<Metadata> extractMetadata(String path) async {
    return await MetadataGod.readMetadata(file: path);
  }

  static Future<List<Directory>> getMusicFolders() async {
    List<String> paths = [];
    try {
      paths = await ExternalPath.getExternalStorageDirectories();
    } catch (e) {
      paths = ["/storage/emulated/0"];
    }
    // paths = paths
    //     .expand((path) =>
    //         ["Music", "Download"].map((folder) => p.join(path, folder)))
    //     .toList();
    paths = ["Music", "Download"]
        .map((folder) => p.join(paths[0], folder))
        .toList();

    final dirs = paths.map((path) => Directory(path)).toList();

    return dirs;
  }

  static const musicExtensions = ["mp3", "opus", "m4a"];

  static Future<List<FileSystemEntity>> getAllMusicFiles(
      Function(String message)? setLoading) async {
    if (setLoading != null) setLoading("obtendo permissao");
    final permission = await requestPermission();
    if (permission) {
      if (setLoading != null) setLoading("acessando armazenamento");
      final dirs = await getMusicFolders();

      List<FileSystemEntity> musics = [];
      for (final dir in dirs) {
        if (setLoading != null) setLoading("acessando armazenamento");
        if (setLoading != null) setLoading(dir.path);
        if (setLoading != null) setLoading("coletando todos os arquivos");
        final files = dir.listSync(
          recursive: true,
          followLinks: false,
        );
        if (setLoading != null) setLoading("filtrando arquivos mp3");
        for (FileSystemEntity entity in files) {
          String path = entity.path;
          if (musicExtensions
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

  static Future<Song> getSongByPath(String path) async {
    final file = File(path);
    final song = await getSongByFile(file);

    return song;
  }

  static editMetadata(String path, Metadata metadata) async {
    await MetadataGod.writeMetadata(file: path, metadata: metadata);
  }

  static Future<Song> getSongByFile(FileSystemEntity file) async {
    final metadata = await extractMetadataFromFile(file);
    final song = Song.withFileData(
        path: file.path,
        metadata: metadata,
        file: file,
        duration: metadata.duration?.inSeconds,
        year: metadata.year,
        picture: metadata.picture?.data,
        title: metadata.title ?? p.basenameWithoutExtension(file.path));

    return song;
  }

  static Future<List<Song>> getAllMusics(
      Function(String state) setLoading) async {
    setLoading("coletando os arquivos");
    final files = await getAllMusicFiles(setLoading);
    List<Song> songs = [];
    for (FileSystemEntity file in files) {
      final song = await getSongByFile(file);
      setLoading(song.title);
      songs.add(song);
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
