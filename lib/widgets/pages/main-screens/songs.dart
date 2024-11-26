import 'package:flutter/material.dart';
import 'package:onPlay/enums/sorting/song_sorting.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_type.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/store/content/song_store.dart';
import 'package:onPlay/widgets/components/cards/song_card.dart';
import 'package:provider/provider.dart';

class Songs extends StatefulWidget {
  const Songs({super.key});
  @override
  createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  late SongStore store;
  late Settings settings;

  List<Song> getSongsList() {
    final sort = store.sort;
    final order = store.order;
    List<Song> songs = List.from(store.songs);
    if (sort == SongSorting.name) {
      songs.sort(
        (a, b) => a.title.compareTo(b.title),
      );
    } else if (sort == SongSorting.duration) {
      songs.sort(
        (a, b) => a.duration?.compareTo(b.duration ?? 0) ?? 0,
      );
    } else if (sort == SongSorting.modificationDate) {
      songs.sort(
          (a, b) => a.modified?.compareTo(b.modified ?? DateTime(0)) ?? 0);
    } else if (sort == SongSorting.color) {
      songs.sort((a, b) {
        final aColor = HSLColor.fromColor(a.currentColors(context).background);
        final bColor = HSLColor.fromColor(b.currentColors(context).background);
        // final hueCompare = aColor.hue.compareTo(bColor.hue);
        final aColorGroup = getColorGroup(aColor.toColor());
        final bColorGroup = getColorGroup(bColor.toColor());
        final groupCompare =
            aColorGroup.priority.compareTo(bColorGroup.priority);
        if (groupCompare == 0) {
          final saturationCompare =
              -aColor.saturation.compareTo(bColor.saturation);
          final lightnessCompare = aColor.lightness.compareTo(bColor.lightness);
          if (lightnessCompare == 0) {
            return saturationCompare;
          }
          return lightnessCompare;
        }
        return groupCompare;
      });
    } else {
      songs.sort(
        (a, b) => a.year?.compareTo(b.year ?? 0) ?? 0,
      );
    }

    songs = order == "desc" ? songs.reversed.toList() : songs;
    return songs;
  }

  @override
  Widget build(BuildContext context) {
    // final ToastService toast = ToastService(context: context)

    store = Provider.of<SongStore>(context);
    settings = Provider.of<Settings>(context);
    final songs = getSongsList();

    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          // ListView(
          //   children: songs
          // .sorted((a, b) =>
          //     getColorType(a.currentColors(context).background)
          //         .group
          //         .priority
          //         .compareTo(
          //             getColorType(b.currentColors(context).background)
          //                 .group
          //                 .priority))
          //       .map((song) => Column(children: [
          //             Text(
          //               "${getColorType(song.currentColors(context).background).group.name} - ${HSLColor.fromColor(song.currentColors(context).background).lightness.toStringAsFixed(2)}",
          //               style: TextStyle(
          //                   fontSize: 40,
          //                   backgroundColor:
          //                       song.currentColors(context).background,
          //                   color: song.currentColors(context).text),
          //             ),
          //             SongCard(song: song)
          //           ]))
          //       .toList(),
          // )
          store.songs.isEmpty
              ? const Text("nenhuma música encontrada")
              : (settings.layout.songGridItems == 1
                  ? ListView.builder(
                      itemCount: store.songs.length,
                      itemBuilder: (context, index) => SongCard(
                        key: ValueKey(songs[index].id),
                        song: songs[index],
                        playlist: songs,
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: settings.layout.songGridItems),
                      itemCount: songs.length,
                      itemBuilder: (context, index) => SongCard(
                        song: songs[index],
                        playlist: songs,
                        key: ValueKey(songs[index].id),
                      ),
                    )),
        ],
      )),
    );
  }
}
