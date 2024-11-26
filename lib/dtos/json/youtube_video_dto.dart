import 'package:json_annotation/json_annotation.dart';
import 'package:onPlay/dtos/json/adaptive_format_dto.dart';
import 'package:onPlay/dtos/json/format_stream_dto.dart';
import 'package:onPlay/dtos/json/storyboard_dto.dart';
import 'package:onPlay/dtos/json/thumbnail_dto.dart';
import 'package:onPlay/services/http/serializable.dart';

part 'youtube_video_dto.g.dart';

@JsonSerializable()
class YoutubeVideoDto extends Serializable {
  String? type;
  String? title;
  String? videoId;
  List<ThumbnailDto>? videoThumbnails;
  List<StoryboardDto>? storyboards;
  String? description;
  String? descriptionHtml;
  int? published;
  String? publishedText;
  List<String>? keywords;
  int? viewCount;
  int? likeCount;

  // int? dislikeCount;
  bool? paid;
  bool? premium;
  bool? isFamilyFriendly;
  List<String>? allowedRegions;
  String? genre;
  String? genreUrl;
  String? author;
  String? authorId;
  String? authorUrl;
  List<ThumbnailDto>? authorThumbnails;
  String? subCountText;
  int? lengthSeconds;
  bool? allowRatings;
  // double? rating;
  bool? isListed;
  bool? liveNow;
  bool? isPostLiveDvr;
  bool? isUpcoming;
  String? dashUrl;
  // int? premiereTimestamp;
  String? hlsUrl;
  List<AdaptiveFormatDto>? adaptiveFormats;
  List<FormatStreamDto>? formatStreams;

  factory YoutubeVideoDto.fromJson(Map<String, dynamic> json) =>
      _$YoutubeVideoDtoFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$YoutubeVideoDtoToJson(this);
  // List<Caption>? captions;
  // List<RecommendedVideo>? recommendedVideos;

  YoutubeVideoDto({
    this.type,
    this.title,
    this.videoId,
    this.videoThumbnails,
    this.storyboards,
    this.description,
    this.descriptionHtml,
    this.published,
    this.publishedText,
    this.keywords,
    this.viewCount,
    this.likeCount,
    // this.dislikeCount,
    this.paid,
    this.premium,
    this.isFamilyFriendly,
    this.allowedRegions,
    this.genre,
    this.genreUrl,
    this.author,
    this.authorId,
    this.authorUrl,
    this.authorThumbnails,
    this.subCountText,
    this.lengthSeconds,
    this.allowRatings,
    // this.rating,
    this.isListed,
    this.liveNow,
    this.isPostLiveDvr,
    this.isUpcoming,
    this.dashUrl,
    // this.premiereTimestamp,
    this.hlsUrl,
    this.adaptiveFormats,
    this.formatStreams,
    // this.captions,
    // this.recommendedVideos,
  });
}
