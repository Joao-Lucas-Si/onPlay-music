import 'package:flutter/material.dart';

class MusicPopup extends StatelessWidget {
  Color? color;

  MusicPopup({this.color, super.key});

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
