// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../dto/album.dart';
import '../dto/artist.dart';
import '../dto/genre.dart';
import '../dto/song.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 3753969085187834715),
      name: 'Album',
      lastPropertyId: const obx_int.IdUid(4, 8911839718158500614),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6793528873903971774),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1996543169184153104),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2389012060959067104),
            name: 'picture',
            type: 23,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 8911839718158500614),
            name: 'artistId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(1, 2403088141832592711),
            relationTarget: 'Artist')
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'songs', srcEntity: 'Song', srcField: 'album')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 4729627340817172911),
      name: 'Artist',
      lastPropertyId: const obx_int.IdUid(3, 1141855647864400535),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6521791777869840391),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 4007955896124351483),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 1141855647864400535),
            name: 'picture',
            type: 23,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'songs', srcEntity: 'Song', srcField: 'artist'),
        obx_int.ModelBacklink(
            name: 'albums', srcEntity: 'Album', srcField: 'artist')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(3, 2106505394272298166),
      name: 'Genre',
      lastPropertyId: const obx_int.IdUid(3, 7353579647072852157),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 7739092095824926247),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 3835786940586414800),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 7353579647072852157),
            name: 'picture',
            type: 23,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'songs', srcEntity: 'Song', srcField: 'genre')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(4, 8496794660331941598),
      name: 'Song',
      lastPropertyId: const obx_int.IdUid(10, 6376765681133665625),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 7177794810790779745),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 6174174371052304555),
            name: 'title',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 1957551580538011014),
            name: 'path',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 2938931899495651044),
            name: 'picture',
            type: 23,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 4353517935591229210),
            name: 'artistId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(2, 8938190836539803908),
            relationTarget: 'Artist'),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 8702351926890062935),
            name: 'albumId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(3, 5111472700926710710),
            relationTarget: 'Album'),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 645802691372003559),
            name: 'genreId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(5, 1164243167884953154),
            relationTarget: 'Genre'),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 2132772723654386675),
            name: 'duration',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 6376765681133665625),
            name: 'year',
            type: 6,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(4, 8496794660331941598),
      lastIndexId: const obx_int.IdUid(5, 1164243167884953154),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [2475274630606279602],
      retiredPropertyUids: const [229436917259459677],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Album: obx_int.EntityDefinition<Album>(
        model: _entities[0],
        toOneRelations: (Album object) => [object.artist],
        toManyRelations: (Album object) => {
              obx_int.RelInfo<Song>.toOneBacklink(
                      6, object.id, (Song srcObject) => srcObject.album):
                  object.songs
            },
        getId: (Album object) => object.id,
        setId: (Album object, int id) {
          object.id = id;
        },
        objectToFB: (Album object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final pictureOffset = object.picture == null
              ? null
              : fbb.writeListInt8(object.picture!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, pictureOffset);
          fbb.addInt64(3, object.artist.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final pictureParam = const fb.Uint8ListReader(lazy: false)
              .vTableGetNullable(buffer, rootOffset, 8) as Uint8List?;
          final object = Album(name: nameParam, picture: pictureParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          object.artist.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.artist.attach(store);
          obx_int.InternalToManyAccess.setRelInfo<Album>(
              object.songs,
              store,
              obx_int.RelInfo<Song>.toOneBacklink(
                  6, object.id, (Song srcObject) => srcObject.album));
          return object;
        }),
    Artist: obx_int.EntityDefinition<Artist>(
        model: _entities[1],
        toOneRelations: (Artist object) => [],
        toManyRelations: (Artist object) => {
              obx_int.RelInfo<Song>.toOneBacklink(
                      5, object.id, (Song srcObject) => srcObject.artist):
                  object.songs,
              obx_int.RelInfo<Album>.toOneBacklink(
                      4, object.id, (Album srcObject) => srcObject.artist):
                  object.albums
            },
        getId: (Artist object) => object.id,
        setId: (Artist object, int id) {
          object.id = id;
        },
        objectToFB: (Artist object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final pictureOffset = object.picture == null
              ? null
              : fbb.writeListInt8(object.picture!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, pictureOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final pictureParam = const fb.Uint8ListReader(lazy: false)
              .vTableGetNullable(buffer, rootOffset, 8) as Uint8List?;
          final object = Artist(name: nameParam, picture: pictureParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          obx_int.InternalToManyAccess.setRelInfo<Artist>(
              object.songs,
              store,
              obx_int.RelInfo<Song>.toOneBacklink(
                  5, object.id, (Song srcObject) => srcObject.artist));
          obx_int.InternalToManyAccess.setRelInfo<Artist>(
              object.albums,
              store,
              obx_int.RelInfo<Album>.toOneBacklink(
                  4, object.id, (Album srcObject) => srcObject.artist));
          return object;
        }),
    Genre: obx_int.EntityDefinition<Genre>(
        model: _entities[2],
        toOneRelations: (Genre object) => [],
        toManyRelations: (Genre object) => {
              obx_int.RelInfo<Song>.toOneBacklink(
                      8, object.id, (Song srcObject) => srcObject.genre):
                  object.songs
            },
        getId: (Genre object) => object.id,
        setId: (Genre object, int id) {
          object.id = id;
        },
        objectToFB: (Genre object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final pictureOffset = object.picture == null
              ? null
              : fbb.writeListInt8(object.picture!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, pictureOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final pictureParam = const fb.Uint8ListReader(lazy: false)
              .vTableGetNullable(buffer, rootOffset, 8) as Uint8List?;
          final object = Genre(name: nameParam, picture: pictureParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          obx_int.InternalToManyAccess.setRelInfo<Genre>(
              object.songs,
              store,
              obx_int.RelInfo<Song>.toOneBacklink(
                  8, object.id, (Song srcObject) => srcObject.genre));
          return object;
        }),
    Song: obx_int.EntityDefinition<Song>(
        model: _entities[3],
        toOneRelations: (Song object) =>
            [object.artist, object.album, object.genre],
        toManyRelations: (Song object) => {},
        getId: (Song object) => object.id,
        setId: (Song object, int id) {
          object.id = id;
        },
        objectToFB: (Song object, fb.Builder fbb) {
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final pathOffset = fbb.writeString(object.path);
          final pictureOffset = object.picture == null
              ? null
              : fbb.writeListInt8(object.picture!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, pathOffset);
          fbb.addOffset(3, pictureOffset);
          fbb.addInt64(4, object.artist.targetId);
          fbb.addInt64(5, object.album.targetId);
          fbb.addInt64(7, object.genre.targetId);
          fbb.addInt64(8, object.duration);
          fbb.addInt64(9, object.year);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final pathParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final pictureParam = const fb.Uint8ListReader(lazy: false)
              .vTableGetNullable(buffer, rootOffset, 10) as Uint8List?;
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final durationParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 20);
          final yearParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 22);
          final object = Song(
              path: pathParam,
              picture: pictureParam,
              title: titleParam,
              duration: durationParam,
              year: yearParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          object.artist.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.artist.attach(store);
          object.album.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.album.attach(store);
          object.genre.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 18, 0);
          object.genre.attach(store);
          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Album] entity fields to define ObjectBox queries.
class Album_ {
  /// See [Album.id].
  static final id = obx.QueryIntegerProperty<Album>(_entities[0].properties[0]);

  /// See [Album.name].
  static final name =
      obx.QueryStringProperty<Album>(_entities[0].properties[1]);

  /// See [Album.picture].
  static final picture =
      obx.QueryByteVectorProperty<Album>(_entities[0].properties[2]);

  /// See [Album.artist].
  static final artist =
      obx.QueryRelationToOne<Album, Artist>(_entities[0].properties[3]);

  /// see [Album.songs]
  static final songs = obx.QueryBacklinkToMany<Song, Album>(Song_.album);
}

/// [Artist] entity fields to define ObjectBox queries.
class Artist_ {
  /// See [Artist.id].
  static final id =
      obx.QueryIntegerProperty<Artist>(_entities[1].properties[0]);

  /// See [Artist.name].
  static final name =
      obx.QueryStringProperty<Artist>(_entities[1].properties[1]);

  /// See [Artist.picture].
  static final picture =
      obx.QueryByteVectorProperty<Artist>(_entities[1].properties[2]);

  /// see [Artist.songs]
  static final songs = obx.QueryBacklinkToMany<Song, Artist>(Song_.artist);

  /// see [Artist.albums]
  static final albums = obx.QueryBacklinkToMany<Album, Artist>(Album_.artist);
}

/// [Genre] entity fields to define ObjectBox queries.
class Genre_ {
  /// See [Genre.id].
  static final id = obx.QueryIntegerProperty<Genre>(_entities[2].properties[0]);

  /// See [Genre.name].
  static final name =
      obx.QueryStringProperty<Genre>(_entities[2].properties[1]);

  /// See [Genre.picture].
  static final picture =
      obx.QueryByteVectorProperty<Genre>(_entities[2].properties[2]);

  /// see [Genre.songs]
  static final songs = obx.QueryBacklinkToMany<Song, Genre>(Song_.genre);
}

/// [Song] entity fields to define ObjectBox queries.
class Song_ {
  /// See [Song.id].
  static final id = obx.QueryIntegerProperty<Song>(_entities[3].properties[0]);

  /// See [Song.title].
  static final title =
      obx.QueryStringProperty<Song>(_entities[3].properties[1]);

  /// See [Song.path].
  static final path = obx.QueryStringProperty<Song>(_entities[3].properties[2]);

  /// See [Song.picture].
  static final picture =
      obx.QueryByteVectorProperty<Song>(_entities[3].properties[3]);

  /// See [Song.artist].
  static final artist =
      obx.QueryRelationToOne<Song, Artist>(_entities[3].properties[4]);

  /// See [Song.album].
  static final album =
      obx.QueryRelationToOne<Song, Album>(_entities[3].properties[5]);

  /// See [Song.genre].
  static final genre =
      obx.QueryRelationToOne<Song, Genre>(_entities[3].properties[6]);

  /// See [Song.duration].
  static final duration =
      obx.QueryIntegerProperty<Song>(_entities[3].properties[7]);

  /// See [Song.year].
  static final year =
      obx.QueryIntegerProperty<Song>(_entities[3].properties[8]);
}
