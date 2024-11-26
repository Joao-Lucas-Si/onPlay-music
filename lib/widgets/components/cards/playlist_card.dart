import 'package:flutter/material.dart';
import 'package:onPlay/enums/card_style.dart';
import 'package:onPlay/models/playlist.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/item/circular_card.dart';
import 'package:onPlay/widgets/components/cards/item/image_card.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';
import 'package:onPlay/widgets/components/cards/item/list_item_card.dart';
import 'package:onPlay/widgets/components/cards/item/normal_card.dart';
import 'package:onPlay/widgets/pages/playlist.dart';
import 'package:provider/provider.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({required this.playlist, super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final params = ItemParams(
        title: playlist.name,
        image: playlist.image,
        isInGrid: settings.layout.playlistGridItems > 1,
        extra: Text(playlist.songs.length.toString()),
        isColored: settings.interface.coloredPlaylistCard,
        colors: playlist.getColors(context));
    final style = settings.interface.playlistCardStyle;

    return GestureDetector(
        onTap: () {
          PlaylistPage.navigate(context, playlist);
        },
        child: style == CardStyle.image
            ? ImageItemCard(params: params)
            : style == CardStyle.listItem
                ? ListItemCard(params: params)
                : style == CardStyle.normal
                    ? NormalCard(params: params)
                    : CircularCard(params: params));
  }
}
