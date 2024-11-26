import 'package:json_annotation/json_annotation.dart';
import 'package:onPlay/services/http/serializable.dart';

part "storyboard_dto.g.dart";

@JsonSerializable()
class StoryboardDto extends Serializable {
  String? url;
  String? templateUrl;
  int? width;
  int? height;
  int? count;
  int? interval;
  int? storyboardWidth;
  int? storyboardHeight;
  int? storyboardCount;

  factory StoryboardDto.fromJson(Map<String, dynamic> json) =>
      _$StoryboardDtoFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StoryboardDtoToJson(this);

  StoryboardDto({
    this.url,
    this.templateUrl,
    this.width,
    this.height,
    this.count,
    this.interval,
    this.storyboardWidth,
    this.storyboardHeight,
    this.storyboardCount,
  });
}
