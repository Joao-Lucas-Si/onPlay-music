import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/dto/artist.dart';

class MiniArtistCard extends StatelessWidget {
  final Artist artist;

  const MiniArtistCard({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/artist", extra: artist);
      },
      child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
          child: Row(
            children: [
              artist.picture != null
                  ? Image.memory(
                      artist.picture!,
                      width: 80,
                      height: 80,
                    )
                  : const Icon(
                      Icons.no_accounts,
                      size: 80,
                    ),
              Container(
                width: 10,
              ),
              Text(artist.name),
              // Text(artist.songs.length.toString())
            ],
          )),
    );
  }
}
