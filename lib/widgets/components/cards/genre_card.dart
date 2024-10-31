import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/enums/card_type.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/item/circular_card.dart';
import 'package:onPlay/widgets/components/cards/item/image_card.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';
import 'package:onPlay/widgets/components/cards/item/list_item_card.dart';
import 'package:onPlay/widgets/components/cards/item/normal_card.dart';
import 'package:provider/provider.dart';

class GenreCard extends StatelessWidget {
  final Genre genre;

  const GenreCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final params = ItemParams(
        title: genre.name,
        isInGrid: settings.layout.genreGridItems > 1,
        extra: Text(genre.songs.length.toString()),
        image: genre.picture,
        isColored: settings.interface.coloredGenreCard,
        colors: genre.getColors(settings));
    final style = settings.interface.genreCardStyle;
    return GestureDetector(
        onTap: () {
          GoRouter.of(context).push("/genre", extra: genre);
        },
        child: style == CardStyle.image
            ? ImageItemCard(params: params)
            : style == CardStyle.normal
                ? NormalCard(params: params)
                : style == CardStyle.listItem
                    ? ListItemCard(params: params)
                    : CircularCard(params: params));
  }
}
