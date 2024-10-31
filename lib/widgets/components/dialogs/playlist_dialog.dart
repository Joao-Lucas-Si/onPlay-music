import 'package:flutter/material.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/widgets/components/dialogs/playlist_form_dialog.dart';
import 'package:provider/provider.dart';

class PlaylistDialog extends StatelessWidget {
  final Song song;
  const PlaylistDialog({required this.song, super.key});
  @override
  Widget build(BuildContext context) {
    final managers = Provider.of<BoxManager>(context);
    final userManager = managers.userManager;
    final playlistManager = managers.playlistManager;
    final user = userManager.getActiveProfile();
    //final playlists = user.playlists.toList();
    //debugPrint(playlists.length.toString());
    final playlists = playlistManager
        .getAll()
        .where((playlist) => playlist.user.target?.name == user.name)
        .toList();
    return Dialog(
        child: SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.9,
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.57,
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
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => PlaylistFormDialog(
                    song: song,
                  ),
                );
              },
              child: const Text("adicionar")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("cancelar"))
        ],
      ),
    ));
  }
}
