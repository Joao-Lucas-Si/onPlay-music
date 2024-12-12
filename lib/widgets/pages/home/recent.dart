import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/content/song_store.dart';
import 'package:onPlay/widgets/components/cards/song_card.dart';
import 'package:onPlay/widgets/pages/home/home.dart';
import 'package:provider/provider.dart';

class Recents extends StatelessWidget {
  Recents({super.key});
  late final SongStore songStore;
  late final Settings settings;
  static const route = "recents";

  static const path = "${Home.path}/$route";

  List<Song> get recentsSongs => songStore.songs
      .where((song) => (song.modified ?? DateTime(1)).isAfter(
          (DateTime.now().subtract(Duration(days: settings.recentRange)))))
      .toList()
      .sorted(
          (i1, i2) => i2.modified?.compareTo(i1.modified ?? DateTime(0)) ?? 0);

  @override
  Widget build(BuildContext context) {
    settings = Provider.of<Settings>(context);
    songStore = Provider.of<SongStore>(context);
    debugPrint(songStore.songs.map((song) => song.modified).toString());
    return Scaffold(
        appBar: AppBar(
          title: const Text("musicas recentes"),
        ),
        body: recentsSongs.isEmpty
            ? const Text("nenhum musica encontrada")
            : ListView.builder(
                itemCount: recentsSongs.length,
                itemBuilder: (context, index) {
                  final song = recentsSongs[index];

                  return SongCard(
                    key: ValueKey(song.id),
                    song: song,
                    playlist: recentsSongs,
                  );
                },
              ));
  }
}
