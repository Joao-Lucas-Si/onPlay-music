import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/dto/album.dart';

class AlbumCard extends StatelessWidget {
  final Album album;

  AlbumCard({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/album", extra: album);
        },
        child: Column(
          children: [
            Text(album.name),
            album.picture != null
                ? Image.memory(album.picture!)
                : const Icon(Icons.disc_full),
            Text(album.songs.length.toString())
          ],
        ));
  }
}
