// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_video_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YoutubeVideoDto _$YoutubeVideoDtoFromJson(Map<String, dynamic> json) =>
    YoutubeVideoDto(
      type: json['type'] as String?,
      title: json['title'] as String?,
      videoId: json['videoId'] as String?,
      videoThumbnails: (json['videoThumbnails'] as List<dynamic>?)
          ?.map((e) => ThumbnailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      storyboards: (json['storyboards'] as List<dynamic>?)
          ?.map((e) => StoryboardDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      descriptionHtml: json['descriptionHtml'] as String?,
      published: (json['published'] as num?)?.toInt(),
      publishedText: json['publishedText'] as String?,
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      viewCount: (json['viewCount'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      paid: json['paid'] as bool?,
      premium: json['premium'] as bool?,
      isFamilyFriendly: json['isFamilyFriendly'] as bool?,
      allowedRegions: (json['allowedRegions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      genre: json['genre'] as String?,
      genreUrl: json['genreUrl'] as String?,
      author: json['author'] as String?,
      authorId: json['authorId'] as String?,
      authorUrl: json['authorUrl'] as String?,
      authorThumbnails: (json['authorThumbnails'] as List<dynamic>?)
          ?.map((e) => ThumbnailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      subCountText: json['subCountText'] as String?,
      lengthSeconds: (json['lengthSeconds'] as num?)?.toInt(),
      allowRatings: json['allowRatings'] as bool?,
      isListed: json['isListed'] as bool?,
      liveNow: json['liveNow'] as bool?,
      isPostLiveDvr: json['isPostLiveDvr'] as bool?,
      isUpcoming: json['isUpcoming'] as bool?,
      dashUrl: json['dashUrl'] as String?,
      hlsUrl: json['hlsUrl'] as String?,
      adaptiveFormats: (json['adaptiveFormats'] as List<dynamic>?)
          ?.map((e) => AdaptiveFormatDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      formatStreams: (json['formatStreams'] as List<dynamic>?)
          ?.map((e) => FormatStreamDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YoutubeVideoDtoToJson(YoutubeVideoDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'videoId': instance.videoId,
      'videoThumbnails': instance.videoThumbnails,
      'storyboards': instance.storyboards,
      'description': instance.description,
      'descriptionHtml': instance.descriptionHtml,
      'published': instance.published,
      'publishedText': instance.publishedText,
      'keywords': instance.keywords,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'paid': instance.paid,
      'premium': instance.premium,
      'isFamilyFriendly': instance.isFamilyFriendly,
      'allowedRegions': instance.allowedRegions,
      'genre': instance.genre,
      'genreUrl': instance.genreUrl,
      'author': instance.author,
      'authorId': instance.authorId,
      'authorUrl': instance.authorUrl,
      'authorThumbnails': instance.authorThumbnails,
      'subCountText': instance.subCountText,
      'lengthSeconds': instance.lengthSeconds,
      'allowRatings': instance.allowRatings,
      'isListed': instance.isListed,
      'liveNow': instance.liveNow,
      'isPostLiveDvr': instance.isPostLiveDvr,
      'isUpcoming': instance.isUpcoming,
      'dashUrl': instance.dashUrl,
      'hlsUrl': instance.hlsUrl,
      'adaptiveFormats': instance.adaptiveFormats,
      'formatStreams': instance.formatStreams,
    };
