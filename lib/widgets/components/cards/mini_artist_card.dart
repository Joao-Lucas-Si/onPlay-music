import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/store/settings.dart';
import 'package:provider/provider.dart';

class MiniArtistCard extends StatelessWidget {
  final Artist artist;

  const MiniArtistCard({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final isInGrid = settings.layout.songGridItems != 1;
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/artist", extra: artist);
      },
      child: Padding(
          padding: EdgeInsets.only(
              left: isInGrid ? 0 : 10, right: isInGrid ? 0 : 10, top: 0),
          child: Row(
            children: [
              CircleAvatar(
                radius: isInGrid ? 15 : 20,
                backgroundImage: artist.picture != null
                    ? MemoryImage(
                        artist.picture!,
                      )
                    : null,
                child: artist.picture == null
                    ? Icon(
                        Icons.no_accounts,
                        size: isInGrid ? 30 : 40,
                      )
                    : null,
              ),

              Container(
                width: 10,
              ),
              Text(
                artist.name,
                style: TextStyle(
                    overflow: isInGrid ? TextOverflow.ellipsis : null,
                    fontSize: isInGrid ? 10 : null),
              ),
              // Text(artist.songs.length.toString())
            ],
          )),
    );
  }
}
