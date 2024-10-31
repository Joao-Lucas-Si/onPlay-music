import 'package:objectbox/objectbox.dart';

@Entity()
class DatabasePlayerSettings {
  @Id()
  int id = 0;
  var velocityStep = 0.25;
  var maxVelocity = 2;
  var volumeStep = 0.25;

  DatabasePlayerSettings(
      {this.maxVelocity = 2, this.velocityStep = 0.25, this.volumeStep = 0.25});
}
