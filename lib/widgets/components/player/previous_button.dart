import 'package:flutter/material.dart';
import 'package:myapp/store/color_store.dart';
import 'package:myapp/store/player_store.dart';
import 'package:provider/provider.dart';

class PreviousButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);
    final colorStore = Provider.of<ColorStorage>(context);
    return playerStore.hasPrevious
        ? IconButton(
            onPressed: () {
              playerStore.runPrevious();
            },
            icon: Icon(
              Icons.skip_previous,
              size: 40,
              color: colorStore.darkColor,
            ))
        : const SizedBox(
            width: 40,
            height: 40,
          );
  }
}
