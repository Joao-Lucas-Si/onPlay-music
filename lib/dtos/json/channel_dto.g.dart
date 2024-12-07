// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelDto _$ChannelDtoFromJson(Map<String, dynamic> json) => ChannelDto(
      author: json['author'] as String?,
      authorId: json['authorId'] as String?,
      authorUrl: json['authorUrl'] as String?,
      authorVerified: json['authorVerified'] as bool?,
      authorBanners: (json['authorBanners'] as List<dynamic>?)
          ?.map((e) => ThumbnailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      authorThumbnails: (json['authorThumbnails'] as List<dynamic>?)
          ?.map((e) => ThumbnailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCount: (json['subCount'] as num?)?.toInt(),
      totalViews: (json['totalViews'] as num?)?.toInt(),
      joined: (json['joined'] as num?)?.toInt(),
      autoGenerated: json['autoGenerated'] as bool?,
      isFamilyFriendly: json['isFamilyFriendly'] as bool?,
      description: json['description'] as String?,
      descriptionHtml: json['descriptionHtml'] as String?,
      allowedRegions: (json['allowedRegions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tabs: (json['tabs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChannelDtoToJson(ChannelDto instance) =>
    <String, dynamic>{
      'author': instance.author,
      'authorId': instance.authorId,
      'authorUrl': instance.authorUrl,
      'authorVerified': instance.authorVerified,
      'authorBanners': instance.authorBanners,
      'authorThumbnails': instance.authorThumbnails,
      'subCount': instance.subCount,
      'totalViews': instance.totalViews,
      'joined': instance.joined,
      'autoGenerated': instance.autoGenerated,
      'isFamilyFriendly': instance.isFamilyFriendly,
      'description': instance.description,
      'descriptionHtml': instance.descriptionHtml,
      'allowedRegions': instance.allowedRegions,
      'tabs': instance.tabs,
    };