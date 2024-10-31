import 'package:flutter/material.dart';
import 'package:onPlay/enums/sorting/song_sorting.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/store/song_store.dart';
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
      songs.sort((a, b) => a
          .currentColors(
              settings.interface.colorPalette, settings.interface.colorTheme)
          .background
          .value
          .compareTo(b
              .currentColors(settings.interface.colorPalette,
                  settings.interface.colorTheme)
              .background
              .value));
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
                    ))
        ],
      )),
    );
  }
}
