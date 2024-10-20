import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:onPlay/localModels/settings/interface.dart';
import 'package:onPlay/localModels/settings/layout.dart';
import 'package:onPlay/localModels/settings/player.dart';
import 'package:onPlay/localModels/settings/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  var _change = false;

  bool get change => _change;

  var recentRange = 30;
  late InterfaceSettings _interface;
  late LayoutSettings _layout;
  late ShareSettings _share;
  var _player = PlayerSettings();

  Settings() {
    notify() {
      _change = true;
      notifyListeners();
    }

    _interface = InterfaceSettings(notify);
    _layout = LayoutSettings(notify);
    _share = ShareSettings(notify);
  }

  PlayerSettings get player => _player;

  ShareSettings get share => _share;

  LayoutSettings get layout => _layout;

  InterfaceSettings get interface => _interface;

  _getStoraged() async {
    final prefs = SharedPreferencesAsync();

    final jsonStr = await prefs.getString("settings") ?? "{}";

    final jsonMap = json.decode(jsonStr);

    final interface = InterfaceSettings.toObject(
      jsonMap["interface"],
      () {
        _change = true;
        notifyListeners();
      },
    );
    _interface = interface;
  }

  desableChange() {
    _change = false;
  }

  @override
  bool operator ==(Object other) {
    if (other is Settings) {
      return other.interface == interface &&
          other.layout == layout &&
          other.player == player &&
          other.recentRange == recentRange;
    }
    return false;
  }
}
