import 'dart:convert';

import 'package:myapp/constants/preferences_keys.dart';
import 'package:myapp/dto/song.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SongModel {
  final String _key = PreferencesKeys.songs;

  colect() {
    final prefs = SharedPreferencesAsync();

    prefs.getString(_key);
  }

  define() {
    final prefs = SharedPreferencesAsync();

    prefs.setString(_key, json.encode({"name": "", "image": 1, "banner": 1}));
  }
}
