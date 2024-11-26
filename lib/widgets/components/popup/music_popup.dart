import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/enums/song_action.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/files_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/content/song_store.dart';
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
    final songStore = Provider.of<SongStore>(context);

    final items = <_Item>[];
    if (song.id != 0) {
      items.addAll([
        _Item(content: "Editar", value: SongAction.edit),
        _Item(
            content: "adicionar na lista atual",
            value: SongAction.addToCurrentPlaylist),
        _Item(
            content: "adicionar na lista como próximo",
            value: SongAction.addAsNext),
        _Item(content: "adicionar a playlist", value: SongAction.addToPlaylist)
      ]);

      if (song.preferredColors.target?.id !=
          song.getCurrentThemeColors(context).id) {
        items.add(_Item(
            content: "definir tema como padrão",
            value: SongAction.defineAsPreferredColors));
      }
      if (song.preferredColors.target != null) {
        items.add(_Item(
            content: "retirar tema padrão",
            value: SongAction.removePreferredColors));
      }
    }

    if (song.isOnline && song.id == 0) {
      items.add(_Item(content: "Salvar", value: SongAction.save));
      items.add(_Item(content: "Baixar", value: SongAction.download));
    }

    return PopupMenuButton(
        // iconSize: 5,
        iconColor: color,
        onSelected: (value) {
          switch (value) {
            case SongAction.save:
              songStore.saveOnlineSong(song);
              break;
            case SongAction.edit:
              GoRouter.of(context).push(SongForm.url, extra: song);
              break;
            case SongAction.addToCurrentPlaylist:
              playerStore.addSong(song);
              break;
            case SongAction.addAsNext:
              playerStore.addSongToNext(song);
              break;
            case SongAction.download:
              FilesService.writeAudioFile(song, context);
              break;
            case SongAction.addToPlaylist:
              showDialog(
                  context: context,
                  builder: (context) => PlaylistDialog(song: song));
              break;
            case SongAction.defineAsPreferredColors:
              song.preferredColors.target = song.getCurrentThemeColors(context);
              songStore.save(song);
              break;
            case SongAction.removePreferredColors:
              song.preferredColors.target = null;
              songStore.save(song);
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
  SongAction value;

  _Item({required this.content, required this.value});
}
