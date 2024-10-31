import 'package:flutter/material.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/playlist.dart';
import 'package:onPlay/models/song.dart';
import 'package:provider/provider.dart';

class PlaylistFormDialog extends StatelessWidget {
  final Song? song;
  PlaylistFormDialog({super.key, this.song});
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final managers = Provider.of<BoxManager>(context);

    final playlistManager = managers.playlistManager;

    final userManager = managers.userManager;

    final user = userManager.getActiveProfile();

    return Dialog(
      child: Column(
        children: [
          const Text("Nome"),
          TextFormField(
            controller: nameController,
          ),
          TextButton(
              onPressed: () {
                final playlist = Playlist(name: nameController.text);
                playlist.user.target = user;
                debugPrint(playlist.user.target?.name);
                if (song != null) playlist.songs.add(song!);
                user.playlists.add(playlist);
                playlistManager.save(playlist);
                userManager.save(user);
                debugPrint(user.playlists.first.name);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("salvar"))
        ],
      ),
    );
  }
}