import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/enums/card_style.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/item/circular_card.dart';
import 'package:onPlay/widgets/components/cards/item/image_card.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';
import 'package:onPlay/widgets/components/cards/item/list_item_card.dart';
import 'package:onPlay/widgets/components/cards/item/normal_card.dart';
import 'package:onPlay/widgets/components/cards/mini_artist_card.dart';
import 'package:provider/provider.dart';

class AlbumCard extends StatelessWidget {
  final Album album;

  const AlbumCard({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final params = ItemParams(
        title: album.name,
        isInGrid: settings.layout.albumGridItems > 1,
        extra: Row(children: [
          album.artist.target != null
              ? MiniArtistCard(
                  artist: album.artist.target!,
                  isInGrid: settings.layout.albumGridItems > 1,
                )
              : const SizedBox.expand(),
          Text(" - ${album.songs.length}")
        ]),
        image: album.picture,
        isColored: settings.interface.coloredAlbumCard,
        colors: album.getColors(context));
    final style = settings.interface.albumCardStyle;
    return GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/album", extra: album);
        },
        child: style == CardStyle.listItem
            ? ListItemCard(params: params)
            : style == CardStyle.image
                ? ImageItemCard(params: params)
                : style == CardStyle.normal
                    ? NormalCard(params: params)
                    : CircularCard(params: params));
  }
}
