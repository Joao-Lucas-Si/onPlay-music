import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

class VolumeStore extends ChangeNotifier {
  var _volume = 0.25;
  final _controller = VolumeController();

  double get volume => _volume;

  set volume(double volume) {
    _controller.setVolume(volume);
  }

  toMax() {
    _volume = 1;
    notifyListeners();
  }

  mute() {
    _volume = 0;
    notifyListeners();
  }

  VolumeStore() {
    _controller.listener((volume) {
      _volume = volume;
      notifyListeners();
    });
  }
}
