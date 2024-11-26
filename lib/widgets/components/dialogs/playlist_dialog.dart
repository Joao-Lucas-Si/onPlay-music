import 'package:flutter/material.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/user_store.dart';
import 'package:onPlay/widgets/components/dialogs/playlist_form_dialog.dart';
import 'package:provider/provider.dart';

class PlaylistDialog extends StatelessWidget {
  final Song song;
  const PlaylistDialog({required this.song, super.key});
  @override
  Widget build(BuildContext context) {
    final managers = Provider.of<BoxManager>(context);
    // final userManager = managers.userManager;
    final playlistManager = managers.playlistManager;
    final userStore = Provider.of<UserStore>(context);
    final user = userStore.user;

    //debugPrint(playlists.length.toString());
    final colors = Theme.of(context).colorScheme;
    final playlists = user.playlists;
    // final playlists = playlistManager
    //     .getAll()
    //     .where((playlist) => playlist.user.target?.name == user.name)
    //     .toList();
    return Dialog(
        child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.9,
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    "Playlists",
                    style: TextStyle(fontSize: 20),
                  ),
                  playlists.isEmpty
                      ? const Text(
                          "Esse perfil não tem nenhuma playlist criada")
                      : const SizedBox.expand(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        final playlist = playlists[index];

                        return ListTile(
                          onTap: () {
                            playlist.songs.add(song);
                            playlistManager.save(playlist);
                            Navigator.of(context).pop();
                          },
                          title: Text(
                            playlist.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  Wrap(
                    spacing: 5,
                    children: [
                      TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => PlaylistFormDialog(
                                song: song,
                              ),
                            );
                          },
                          child: Text(
                            "adicionar",
                            style: TextStyle(color: colors.secondary),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "cancelar",
                            style: TextStyle(color: colors.secondary),
                          ))
                    ],
                  )
                ],
              ),
            )));
  }
}
