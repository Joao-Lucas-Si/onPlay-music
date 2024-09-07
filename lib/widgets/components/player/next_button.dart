import 'package:flutter/material.dart';
import 'package:myapp/store/color_store.dart';
import 'package:myapp/store/player_store.dart';
import 'package:provider/provider.dart';

class NextButton extends StatelessWidget {
  final bool isSmall;

  const NextButton({this.isSmall = false, super.key});

  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    final colorStore = Provider.of<ColorStorage>(context);
    return playerStore.hasNext
        ? IconButton(
            onPressed: () {
              playerStore.runNext();
            },
            icon: Icon(
              Icons.skip_next,
              size: isSmall ? 20 : 40,
              color: colorStore.darkColor,
            ))
        : const SizedBox(
            width: 40,
            height: 40,
          );
  }
}
