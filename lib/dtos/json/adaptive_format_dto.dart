import 'package:json_annotation/json_annotation.dart';
import 'package:onPlay/services/http/serializable.dart';

part "adaptive_format_dto.g.dart";

@JsonSerializable()
class AdaptiveFormatDto extends Serializable {
  String? index;
  String? bitrate;
  String? init;
  String? url;
  String? itag;
  String? type;
  String? clen;
  String? lmt;
  // int? projectionType;
  String? container;
  String? encoding;
  String? qualityLabel;
  String? resolution;

  factory AdaptiveFormatDto.fromJson(Map<String, dynamic> json) =>
      _$AdaptiveFormatDtoFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AdaptiveFormatDtoToJson(this);

  AdaptiveFormatDto({
    this.index,
    this.bitrate,
    this.init,
    this.url,
    this.itag,
    this.type,
    this.clen,
    this.lmt,
    // this.projectionType,
    this.container,
    this.encoding,
    this.qualityLabel,
    this.resolution,
  });
}
