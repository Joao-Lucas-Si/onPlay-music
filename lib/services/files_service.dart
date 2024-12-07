import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onPlay/dtos/metadata_dto.dart';
import "package:collection/collection.dart";
import 'package:onPlay/services/colors/color_service.dart';
import 'package:onPlay/services/http/adapters/http_adapter.dart';
import 'package:onPlay/services/http/services/youtube_service.dart';
import 'package:onPlay/services/metadata/metadata_service.dart';
import 'package:path/path.dart' as p;
import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/models/song.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';

class FilesService {
  static final _metadataService = MetadataService();
  static bool permission = false;
  static Future<bool> requestPermission() async {
    if (FilesService.permission) {
      return FilesService.permission;
    }
    final permission = await Permission.manageExternalStorage.request();
    FilesService.permission = permission.isGranted;
    return permission.isGranted;
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
    paths = ["Music"].map((folder) => p.join(paths[0], folder)).toList();

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
                  "arquivo ${(await _metadataService.read(path)).title ?? ""}");
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

  static Future<void> writeAudioFile(Song song, BuildContext context) async {
    final dirs = await getMusicFolders();
    final dir = dirs.first;
    final file = File("${dir.path}/${song.title.replaceAll(" ", "+")}.mp3");
    debugPrint(file.path);
    final httpService = HttpAdapter();
    final youtubeService = YoutubeService(context);
    final video = await youtubeService.getVideo(song.path);
    debugPrint(video?.formatStreams?.length.toString());
    video?.formatStreams?.forEach((stream) {
      debugPrint(stream.type);
      debugPrint(stream.url);
    });
    debugPrint(video?.adaptiveFormats?.length.toString());
    // video?.adaptiveFormats?.forEach((stream) {
    //   debugPrint(stream.type);
    //   debugPrint(stream.url);
    // });
    // debugPrint(video?.adaptiveFormats
    //     ?.firstWhereOrNull(
    //         (format) => format.type?.startsWith("audio") ?? false)
    //     ?.url);
    debugPrint((await httpService.getBytes(video?.adaptiveFormats
                ?.firstWhereOrNull(
                    (format) => format.type?.startsWith("audio") ?? false)
                ?.url ??
            ""))
        .toString());
    final songFile = await file.writeAsBytes(
      await httpService.getBytes(video?.adaptiveFormats
              ?.firstWhereOrNull(
                  (format) => format.type?.startsWith("audio") ?? false)
              ?.url ??
          ""),
    );
    debugPrint(songFile.path);
    await _metadataService.write(songFile.path, song.generateMetadata());
  }

  static Future<Song> getSongByFile(FileSystemEntity file) async {
    final colorService = ColorService();
    final metadata = await _metadataService.read(file.path);
    final song = Song.withFileData(
        path: file.path,
        modified: file.statSync().modified,
        metadata: metadata,
        file: file,
        pictureMimeType: metadata.imageMimeType,
        duration: metadata.duration,
        year: metadata.year,
        picture: metadata.image,
        title: metadata.title ?? p.basenameWithoutExtension(file.path));
    song.colors.addAll(await colorService.getAllColorFromSong(song));
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

  static Future<List<SongMetadata>> extractAllMetadata() async {
    final files = await getAllMusicFiles(null);
    List<SongMetadata> metadatas = [];

    for (FileSystemEntity file in files) {
      metadatas.add(await _metadataService.read(file.path));
    }

    return metadatas;
  }
}
/*
private fun saveAudioMetadata(filePath: String, title: String, artist: String, album: String, genre: String = "Unknown", year: String = "2024") {
    try {
        // Carregar o arquivo MP3
        val mp3File = Mp3File(filePath)

        // Verificar se já existe uma tag ID3v2
        if (mp3File.hasId3v2Tag()) {
            // Se já existe, apenas atualizamos os metadados
            val id3v2 = mp3File.id3v2Tag
            id3v2.title = title
            id3v2.artist = artist
            id3v2.album = album
            id3v2.genre = genre
            id3v2.year = year
            mp3File.save(filePath) // Salva as alterações no arquivo
        } else {
            // Se não existe, cria uma nova tag ID3v2
            val id3v2 = ID3v2()

            // Definir os metadados
            id3v2.title = title
            id3v2.artist = artist
            id3v2.album = album
            id3v2.genre = genre
            id3v2.year = year

            // Adicionar a nova tag ID3v2 ao arquivo
            mp3File.id3v2Tag = id3v2

            // Salvar o arquivo com a nova tag ID3v2
            mp3File.save(filePath)
        }
    } catch (e: Exception) {
        Log.e("AudioMetadata", "Erro ao salvar metadados: ${e.message}")
        throw e
    }
} 
 */