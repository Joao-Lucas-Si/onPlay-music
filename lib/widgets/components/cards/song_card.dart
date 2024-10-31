import 'package:flutter/material.dart';
import 'package:onPlay/enums/card_type.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';
import 'package:onPlay/widgets/components/cards/item/circular_card.dart';
import 'package:onPlay/widgets/components/cards/item/normal_card.dart';
import 'package:onPlay/widgets/components/cards/item/image_card.dart';
import 'package:onPlay/widgets/components/cards/item/list_item_card.dart';
import 'package:onPlay/widgets/components/cards/mini_artist_card.dart';
import 'package:onPlay/widgets/components/popup/music_popup.dart';
import 'package:provider/provider.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final bool showArtist;
  final bool isPreview;

  final List<Song>? playlist;

  const SongCard(
      {super.key,
      this.showArtist = true,
      this.isPreview = false,
      required this.song,
      this.playlist});
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PlayerStore>(context);
    final settings = Provider.of<Settings>(context);
    final newPlaylist = playlist != null
        ? [...playlist!.where((music) => music.path != song.path)]
        : [];
    newPlaylist.shuffle();
    final colors = song.currentColors(
        settings.interface.colorPalette, settings.interface.colorTheme);

    final style = settings.interface.songCardStyle;
    final params = ItemParams(
        title: song.title,
        isInGrid: settings.layout.songGridItems > 1,
        isColored: settings.interface.coloredSongCard,
        option: MusicPopup(song: song),
        colors: colors,
        extra: song.artist.target != null
            ? MiniArtistCard(artist: song.artist.target!)
            : null,
        image: song.picture);
    return GestureDetector(
      onTap: () {
        if (!isPreview) store.playlist = [song, ...newPlaylist];
      },
      child: style == CardStyle.normal
          ? NormalCard(
              params: params,
            )
          : style == CardStyle.listItem
              ? ListItemCard(
                  params: params,
                )
              : style == CardStyle.image
                  ? ImageItemCard(
                      params: params,
                    )
                  : CircularCard(
                      params: params,
                    ),
    );
  }
}
