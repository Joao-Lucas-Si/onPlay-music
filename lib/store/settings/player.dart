import 'package:onPlay/models/settings/player.dart';

class PlayerSettings {
  late Function() _notify;
  var velocityStep = 0.25;
  var maxVelocity = 2;
  var volumeStep = 0.25;

  PlayerSettings(
      {required Function() notify, DatabasePlayerSettings? database}) {
    _notify = notify;
    if (database != null) {
      velocityStep = database.velocityStep;
      volumeStep = database.volumeStep;
      maxVelocity = database.maxVelocity;
    }
  }
}
