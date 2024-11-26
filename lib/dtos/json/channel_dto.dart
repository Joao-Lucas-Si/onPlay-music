import 'package:json_annotation/json_annotation.dart';
import 'package:onPlay/dtos/json/thumbnail_dto.dart';
import 'package:onPlay/services/http/serializable.dart';

part "channel_dto.g.dart";

@JsonSerializable()
class ChannelDto extends Serializable {
  String? author;
  String? authorId;
  String? authorUrl;
  bool? authorVerified;
  List<ThumbnailDto>? authorBanners;
  List<ThumbnailDto>? authorThumbnails;
  int? subCount;
  int? totalViews;
  int? joined;
  bool? autoGenerated;
  bool? isFamilyFriendly;
  String? description;
  String? descriptionHtml;
  List<String>? allowedRegions;
  List<String>? tabs;
  // List<VideoDto>? latestVideos;
  // List<ChannelObjectDto>? relatedChannels;

  factory ChannelDto.fromJson(Map<String, dynamic> json) =>
      _$ChannelDtoFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ChannelDtoToJson(this);

  ChannelDto({
    this.author,
    this.authorId,
    this.authorUrl,
    this.authorVerified,
    this.authorBanners,
    this.authorThumbnails,
    this.subCount,
    this.totalViews,
    this.joined,
    this.autoGenerated,
    this.isFamilyFriendly,
    this.description,
    this.descriptionHtml,
    this.allowedRegions,
    this.tabs,
    // this.latestVideos,
    // this.relatedChannels,
  });
}
