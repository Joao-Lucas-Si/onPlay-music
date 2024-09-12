import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  var recentRange = 30;
  var _interface = InterfaceSettings();
  var _player = PlayerSettings();

  InterfaceSettings get interface => _interface;

  _getStoraged() async {
    final prefs = SharedPreferencesAsync();

    final jsonStr = await prefs.getString("settings") ?? "{}";

    final jsonMap = json.decode(jsonStr);

    final interface = InterfaceSettings.toObject(jsonMap["interface"]);
    _interface = interface;
  }
}

class _LayoutSettings {
  var showArtists = true;
  var showGenres = true;
  var showPlaylists = true;

  toJson() {
    return json.encode(
      this,
      toEncodable: (object) {
        final jsonMap = Map<String, dynamic>();
        jsonMap["showArtists"] = showArtists;
        jsonMap["showGenres"] = showGenres;
        jsonMap["showPlaylists "] = showPlaylists;
      },
    );
  }

  static toObject(Map<String, dynamic> map) {
    // final obj = InterfaceSettings();
    // obj.primaryColor = map["primaryColor"];
    // obj.colorSchemeType = map["colorSchemeType"];
    // return obj;
  }
}

class PlayerSettings {}

enum MusicCardStyle {
  normal("normal"),
  colorful("colorful"),
  listItem("listItem"),
  image("image"),
  gradientImage("gradientImage"),
  circular("circular");

  static fromString(String name) {
    return MusicCardStyle.values.firstWhere((value) => value.name == name);
  }

  final String _name;

  String get name => _name;

  const MusicCardStyle(this._name);
}

enum ColorSchemeType {
  selectedColor("selected"),
  totalMusicColor("totalMusic"),
  partialMusicColor("partialMusic"),
  appColor("app");

  static fromString(String name) {
    return ColorSchemeType.values.firstWhere((value) => value.name == name);
  }

  final String name;

  const ColorSchemeType(this.name);
}

class InterfaceSettings {
  int primaryColor = 0xFF673AB7;
  ColorSchemeType colorSchemeType = ColorSchemeType.totalMusicColor;
  bool darkTheme = true;

  MusicCardStyle style = MusicCardStyle.normal;

  toJson() {
    return json.encode(
      this,
      toEncodable: (object) {
        final jsonMap = Map<String, dynamic>();
        jsonMap["primaryColor"] = primaryColor;
        jsonMap["colorSchemeType"] = colorSchemeType.name;
      },
    );
  }

  static toObject(Map<String, dynamic> map) {
    final obj = InterfaceSettings();
    obj.primaryColor = map["primaryColor"];
    obj.colorSchemeType = ColorSchemeType.fromString(map["colorSchemeType"]);
    return obj;
  }
}
