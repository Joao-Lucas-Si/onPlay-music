import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/enums/card_style.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/item/circular_card.dart';
import 'package:onPlay/widgets/components/cards/item/image_card.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';
import 'package:onPlay/widgets/components/cards/item/list_item_card.dart';
import 'package:onPlay/widgets/components/cards/item/normal_card.dart';
import 'package:provider/provider.dart';

class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final params = ItemParams(
        title: artist.name,
        isInGrid: settings.layout.artistGridItems > 1,
        extra: Text(artist.songs.length.toString()),
        image: artist.picture,
        isColored: settings.interface.coloredArtistCard,
        colors: artist.getColors(context));
    final style = settings.interface.artistCardStyle;
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push("/artist", extra: artist);
      },
      child: style == CardStyle.normal
          ? NormalCard(params: params)
          : style == CardStyle.image
              ? ImageItemCard(params: params)
              : style == CardStyle.listItem
                  ? ListItemCard(params: params)
                  : CircularCard(params: params),
    );
  }
}
