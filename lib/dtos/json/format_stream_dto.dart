import 'package:json_annotation/json_annotation.dart';
import 'package:onPlay/services/http/serializable.dart';

part "format_stream_dto.g.dart";

@JsonSerializable()
class FormatStreamDto extends Serializable {
  String? url;
  String? itag;
  String? type;
  String? quality;
  String? container;
  String? encoding;
  String? qualityLabel;
  String? resolution;
  String? size;

  factory FormatStreamDto.fromJson(Map<String, dynamic> json) =>
      _$FormatStreamDtoFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FormatStreamDtoToJson(this);

  FormatStreamDto({
    this.url,
    this.itag,
    this.type,
    this.quality,
    this.container,
    this.encoding,
    this.qualityLabel,
    this.resolution,
    this.size,
  });
}
