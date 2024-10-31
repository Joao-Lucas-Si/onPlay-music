import 'package:flutter/material.dart';
import 'package:onPlay/models/music_color.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:provider/provider.dart';

class VelocityController extends StatelessWidget {
  final MusicColor musicColor;
  const VelocityController({super.key, required this.musicColor});
  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    return GestureDetector(
      onTap: () {
        playerStore.velocity = playerStore.velocity == playerStore.maxVelocity
            ? playerStore.velocityStep
            : playerStore.velocity + playerStore.velocityStep;
      },
      child: Text(
        "${playerStore.velocity}X",
        style: TextStyle(color: musicColor.text),
      ),
    );
  }
}
