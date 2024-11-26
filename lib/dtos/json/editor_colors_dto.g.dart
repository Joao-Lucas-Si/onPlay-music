// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_colors_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditorColorsDto _$EditorColorsDtoFromJson(Map<String, dynamic> json) =>
    EditorColorsDto(
      background: const ColorConverter().fromJson(json['background'] as String),
      icon: const ColorConverter().fromJson(json['icon'] as String),
      other: const ColorConverter().fromJson(json['other'] as String),
      text: const ColorConverter().fromJson(json['text'] as String),
      inactive: const ColorConverter().fromJson(json['inactive'] as String),
      imageMimeType: json['imageMimeType'] as String?,
      image: _$JsonConverterFromJson<List<int>, Uint8List>(
          json['image'], const Uint8listConverter().fromJson),
      name: json['name'] as String,
    );

Map<String, dynamic> _$EditorColorsDtoToJson(EditorColorsDto instance) =>
    <String, dynamic>{
      'background': const ColorConverter().toJson(instance.background),
      'text': const ColorConverter().toJson(instance.text),
      'other': const ColorConverter().toJson(instance.other),
      'icon': const ColorConverter().toJson(instance.icon),
      'inactive': const ColorConverter().toJson(instance.inactive),
      'name': instance.name,
      'imageMimeType': instance.imageMimeType,
      'image': _$JsonConverterToJson<List<int>, Uint8List>(
          instance.image, const Uint8listConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
