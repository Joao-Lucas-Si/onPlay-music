// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'format_stream_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormatStreamDto _$FormatStreamDtoFromJson(Map<String, dynamic> json) =>
    FormatStreamDto(
      url: json['url'] as String?,
      itag: json['itag'] as String?,
      type: json['type'] as String?,
      quality: json['quality'] as String?,
      container: json['container'] as String?,
      encoding: json['encoding'] as String?,
      qualityLabel: json['qualityLabel'] as String?,
      resolution: json['resolution'] as String?,
      size: json['size'] as String?,
    );

Map<String, dynamic> _$FormatStreamDtoToJson(FormatStreamDto instance) =>
    <String, dynamic>{
      'url': instance.url,
      'itag': instance.itag,
      'type': instance.type,
      'quality': instance.quality,
      'container': instance.container,
      'encoding': instance.encoding,
      'qualityLabel': instance.qualityLabel,
      'resolution': instance.resolution,
      'size': instance.size,
    };
