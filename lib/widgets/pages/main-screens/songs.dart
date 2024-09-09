import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/dto/song.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/widgets/components/song_card.dart';
import 'package:provider/provider.dart';

class Songs extends StatefulWidget {
  @override
  createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  late SongStore store;

  List<Song> getSongsList() {
    final sort = store.sort;
    final order = store.order;
    List<Song> songs = List.from(store.songs);
    if (sort == "name") {
      songs.sort(
        (a, b) => a.title?.compareTo(b.title ?? "") ?? 0,
      );
    } else if (sort == "duration") {
      songs.sort(
        (a, b) => a.duration?.compareTo(b.duration ?? 0) ?? 0,
      );
    } else if (sort == "modification_date") {
      songs.sort((a, b) =>
          a.file
              ?.statSync()
              .modified
              .compareTo(b.file?.statSync().modified ?? DateTime(0)) ??
          0);
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
    final songs = getSongsList();

    return Scaffold(
      body: Center(
          child: store.loading != ""
              ? Align(
                  alignment: Alignment.center,
                  child: Text(store.loading,
                      style: const TextStyle(fontSize: 30, color: Colors.red)),
                )
              : Stack(
                  children: [
                    store.songs.isEmpty
                        ? const Text("nenhuma música encontrada")
                        : ListView.builder(
                            itemCount: store.songs.length,
                            itemBuilder: (context, index) => SongCard(
                              song: songs[index],
                              playlist: songs,
                            ),
                          )
                  ],
                )),
    );
  }
}
