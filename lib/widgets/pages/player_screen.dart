import 'package:flutter/material.dart';
import 'package:myapp/widgets/components/mini_player.dart';
import 'package:myapp/widgets/components/player.dart';

class PlayerScreen extends StatelessWidget {
  final minSize = 0.1;
  final maxSize = 1.0;

  final draggableController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        controller: draggableController,
        minChildSize: minSize,
        maxChildSize: maxSize,
        snapSizes: [minSize, maxSize],
        builder: (context, scrollController) =>
            draggableController.size == minSize ? MiniPlayer() : Player());
  }
}
