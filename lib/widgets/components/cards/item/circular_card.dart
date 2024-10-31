
import 'package:flutter/material.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';

class CircularCard extends StatelessWidget {
  final ItemParams params;

  const CircularCard({super.key, required this.params});
  @override
  Widget build(BuildContext context) {

    final ItemParams(:colors, :extra, :isInGrid, :image, :title, :option, :isColored) =
        params;
    //final store = Provider.of<PlayerStore>(context);
    // final newPlaylist = playlist != null
    //     ? [...playlist!.where((music) => music.path != song.path)]
    //     : [];
    // newPlaylist.shuffle();
    return Card(
        color: isColored ? colors.background : null,
        child: Column(
          children: [
            CircleAvatar(
              radius: isInGrid ? 50 : 120,
              backgroundColor: isColored ? colors.other : null,
              backgroundImage: image != null ? MemoryImage(image) : null,
              child:
                  image != null ? null : const Icon(Icons.music_off, size: 100),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                  child: Text(
                title,
                style: TextStyle(color: isColored ? colors.text : null),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )),
              option ?? const SizedBox(),
            ]),
            extra ?? const SizedBox()
            // song.artist.target != null && showArtist
            //     ? MiniArtistCard(artist: song.artist.target!)
            //     : Container(
            //         width: 0,
            //       )
          ],
        ));
  }
}
