import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/widgets/pages/song_form.dart';

class MusicPopup extends StatelessWidget {
  final Color? color;
  final Song song;

  const MusicPopup({this.color, super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final items = [
      _Item(content: "Editar", value: "edit"),
      _Item(content: "adicionar na lista atual", value: "currentPlaylist"),
      _Item(content: "adicionar na lista como próximo", value: "addAsNext"),
      _Item(content: "adicionar a playlist", value: "addToPlaylist")
    ];
    return PopupMenuButton(
        // iconSize: 5,
        iconColor: color,
        onSelected: (value) {
          switch (value) {
            case "edit":
              GoRouter.of(context).push(SongForm.url, extra: song);
              break;
          }
        },
        itemBuilder: (context) => items
            .map((item) =>
                PopupMenuItem(child: Text(item.content), value: item.value))
            .toList());
  }
}

class _Item {
  String content;
  String value;

  _Item({required this.content, required this.value});
}
