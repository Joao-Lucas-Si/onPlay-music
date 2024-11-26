// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storyboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryboardDto _$StoryboardDtoFromJson(Map<String, dynamic> json) =>
    StoryboardDto(
      url: json['url'] as String?,
      templateUrl: json['templateUrl'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      interval: (json['interval'] as num?)?.toInt(),
      storyboardWidth: (json['storyboardWidth'] as num?)?.toInt(),
      storyboardHeight: (json['storyboardHeight'] as num?)?.toInt(),
      storyboardCount: (json['storyboardCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StoryboardDtoToJson(StoryboardDto instance) =>
    <String, dynamic>{
      'url': instance.url,
      'templateUrl': instance.templateUrl,
      'width': instance.width,
      'height': instance.height,
      'count': instance.count,
      'interval': instance.interval,
      'storyboardWidth': instance.storyboardWidth,
      'storyboardHeight': instance.storyboardHeight,
      'storyboardCount': instance.storyboardCount,
    };
