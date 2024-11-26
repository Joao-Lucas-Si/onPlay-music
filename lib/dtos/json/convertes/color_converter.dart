
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter extends JsonConverter<Color, String> {
  const ColorConverter();
  static String toHex(Color color) {
    return "#${(color.value).toRadixString(16).padLeft(6, '0').toUpperCase().substring(2)}";
  }

  toColor(String hex) {
    var hexColor = hex.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  @override
  Color fromJson(String json) {
    return toColor(json);
  }

  @override
  String toJson(Color object) {
    return toHex(object);
  }
}