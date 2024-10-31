import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/enums/card_type.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/item/circular_card.dart';
import 'package:onPlay/widgets/components/cards/item/image_card.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';
import 'package:onPlay/widgets/components/cards/item/list_item_card.dart';
import 'package:onPlay/widgets/components/cards/item/normal_card.dart';
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
        extra: Text(album.songs.length.toString()),
        image: album.picture,
        isColored: settings.interface.coloredAlbumCard,
        colors: album.getColors(settings));
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
