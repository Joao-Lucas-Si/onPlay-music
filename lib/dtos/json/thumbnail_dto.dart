import 'package:json_annotation/json_annotation.dart';
import 'package:onPlay/services/http/serializable.dart';

part "thumbnail_dto.g.dart";

@JsonSerializable()
class ThumbnailDto extends Serializable {
  String? quality;
  String? url;
  int? width;
  int? height;

  factory ThumbnailDto.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailDtoFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ThumbnailDtoToJson(this);

  ThumbnailDto({this.quality, this.url, this.width, this.height});
}
