import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onPlay/dtos/json/convertes/color_converter.dart';
import 'package:onPlay/dtos/json/convertes/uint8list_converter.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/services/http/serializable.dart';

part "editor_colors_dto.g.dart";

@JsonSerializable()
@ColorConverter()
@Uint8listConverter()
class EditorColorsDto extends Serializable {
  Color background, text, other, icon, inactive;
  String name;
  String? imageMimeType;
  Uint8List? image;

  factory EditorColorsDto.fromMusicColor(
          {required MusicColor colors,
          required String name,
          Uint8List? image,
          String? imageMimeType}) =>
      EditorColorsDto(
          background: colors.background,
          icon: colors.background,
          other: colors.other,
          text: colors.text,
          imageMimeType: imageMimeType,
          inactive: colors.inactive,
          name: name,
          image: image);

  EditorColorsDto(
      {required this.background,
      required this.icon,
      required this.other,
      required this.text,
      required this.inactive,
      this.imageMimeType,
      this.image,
      required this.name});

  factory EditorColorsDto.fromJson(Map<String, dynamic> json) => _$EditorColorsDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EditorColorsDtoToJson(this);
}
