import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/dto/artist.dart';

class ArtistCard extends StatelessWidget {
  Artist artist;

  ArtistCard({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/artist", extra: artist);
      },
      child: Column(
        children: [
          Text(artist.name),
          artist.picture != null
              ? Image.memory(artist.picture!)
              : const Icon(
                  Icons.no_accounts,
                  size: 200,
                ),
          Text(artist.songs.length.toString())
        ],
      ),
    );
  }
}
