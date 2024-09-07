import 'dart:convert';
import 'dart:typed_data';
import 'package:myapp/constants/preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  static const _key = PreferencesKeys.user;

  String? name;

  Uint8List? image;

  Uint8List? banner;

  UserModel._contructor({required this.name, this.image, this.banner});

  static Future<UserModel> colect() async {
    final prefs = SharedPreferencesAsync();

    final jsonStr = await prefs.getString(_key);

    if (jsonStr != null) {
      final obj = json.decode(jsonStr);

      final name = obj["name"];

      final image = obj["image"] != null ? List<int>.from(obj["image"]) : null;

      final banner =
          obj["banner"] != null ? List<int>.from(obj["banner"]) : null;

      return UserModel._contructor(
          name: name,
          banner: banner != null ? Uint8List.fromList(banner) : null,
          image: image != null ? Uint8List.fromList(image) : null);
    }
    return UserModel._contructor(name: "");
  }

  save() async {
    final prefs = SharedPreferencesAsync();

    await prefs.setString(
        _key, json.encode({"name": name, "image": image, "banner": banner}));
  }
}
