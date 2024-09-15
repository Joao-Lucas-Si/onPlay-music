class PlayerSettings {
  var velocityStep = 0.25;
  var maxVelocity = 2;
  var volumeStep = 0.25;

  @override
  bool operator ==(Object other) {
    if (other is PlayerSettings) {
      return other.maxVelocity == maxVelocity &&
          other.velocityStep == velocityStep &&
          other.volumeStep == volumeStep;
    }
    return false;
  }
}
