import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/dialogs/playlist_dialog.dart';
import 'package:onPlay/widgets/pages/song_form.dart';
import 'package:provider/provider.dart';

class MusicPopup extends StatelessWidget {
  final Color? color;
  final Song song;

  const MusicPopup({this.color, super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final playerStore = Provider.of<PlayerStore>(context);

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
            case "currentPlaylist":
              playerStore.addSong(song);
              break;
            case "addAsNext":
              playerStore.addSongToNext(song);
              break;
            case "addToPlaylist":
              showDialog(
                  context: context,
                  builder: (context) => PlaylistDialog(song: song));
              break;
          }
        },
        itemBuilder: (context) => items
            .map((item) =>
                PopupMenuItem(value: item.value, child: Text(item.content)))
            .toList());
  }
}

class _Item {
  String content;
  String value;

  _Item({required this.content, required this.value});
}
