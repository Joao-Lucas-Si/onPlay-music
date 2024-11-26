// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbnailDto _$ThumbnailDtoFromJson(Map<String, dynamic> json) => ThumbnailDto(
      quality: json['quality'] as String?,
      url: json['url'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ThumbnailDtoToJson(ThumbnailDto instance) =>
    <String, dynamic>{
      'quality': instance.quality,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
