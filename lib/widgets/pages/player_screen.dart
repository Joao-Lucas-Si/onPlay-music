import 'package:flutter/material.dart';
import 'package:onPlay/widgets/components/mini_player.dart';
import 'package:onPlay/widgets/components/player.dart';

class PlayerScreen extends StatefulWidget {
  final bool inMainScreen;

  PlayerScreen({required this.inMainScreen, super.key});

  @override
  State<StatefulWidget> createState() => _PlayerScreen();
}

class _PlayerScreen extends State<PlayerScreen> {
  final minSize = 0.12;
  final maxSize = 1.0;

  Widget playerType = MiniPlayer();

  changePlayer() {
    if (draggableController.size <= (minSize + 0.1) &&
        playerType is! MiniPlayer) {
      setState(() {
        playerType = MiniPlayer();
      });
    } else if (playerType is! Player &&
        draggableController.size > (minSize + 0.1)) {
      setState(() {
        playerType = Player();
      });
    }
  }

  final draggableController = DraggableScrollableController();
  @override
  Widget build(BuildContext context) {
    draggableController.addListener(
      () {
        changePlayer();
      },
    );
    return DraggableScrollableSheet(
        initialChildSize: minSize,
        controller: draggableController,
        minChildSize: minSize,
        maxChildSize: maxSize,
        snap: true,
        builder: (context, scrollController) {
          return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                  alignment: AlignmentDirectional.topCenter,
                  color: const Color(0XFF000000),
                  height: MediaQuery.of(context).size.height -
                      (widget.inMainScreen ? 55 : 0),
                  child: playerType));
        });
  }
}
