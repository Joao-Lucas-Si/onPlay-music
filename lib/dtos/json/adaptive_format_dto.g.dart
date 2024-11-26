// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adaptive_format_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdaptiveFormatDto _$AdaptiveFormatDtoFromJson(Map<String, dynamic> json) =>
    AdaptiveFormatDto(
      index: json['index'] as String?,
      bitrate: json['bitrate'] as String?,
      init: json['init'] as String?,
      url: json['url'] as String?,
      itag: json['itag'] as String?,
      type: json['type'] as String?,
      clen: json['clen'] as String?,
      lmt: json['lmt'] as String?,
      container: json['container'] as String?,
      encoding: json['encoding'] as String?,
      qualityLabel: json['qualityLabel'] as String?,
      resolution: json['resolution'] as String?,
    );

Map<String, dynamic> _$AdaptiveFormatDtoToJson(AdaptiveFormatDto instance) =>
    <String, dynamic>{
      'index': instance.index,
      'bitrate': instance.bitrate,
      'init': instance.init,
      'url': instance.url,
      'itag': instance.itag,
      'type': instance.type,
      'clen': instance.clen,
      'lmt': instance.lmt,
      'container': instance.container,
      'encoding': instance.encoding,
      'qualityLabel': instance.qualityLabel,
      'resolution': instance.resolution,
    };
