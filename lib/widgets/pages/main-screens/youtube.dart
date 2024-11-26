import 'package:flutter/material.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/colors/color_service.dart';
import 'package:onPlay/services/http/services/youtube_service.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/song_card.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;

class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<YoutubeScreen> {
  List<Song> songs = [];
  final searchControll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final colorService = ColorService();
    final colors = Theme.of(context).colorScheme;
    final gridItems = settings.layout.songGridItems;
    final isGrid = gridItems != 1;
    final youtubeService = YoutubeService(context);

    buildSongCard(BuildContext context, int index) => SongCard(
        song: songs[index], playlist: songs, key: ValueKey(songs[index].path));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: searchControll,
            )),
            TextButton(
                onPressed: () async {
                  debugPrint("coletando");
                  final result =
                      await youtubeService.search(searchControll.value.text);
                  debugPrint("obtido");
                  if (result != null) {
                    debugPrint("diferente");
                    final newSongs = <Song>[];
                    for (final videoDto in result) {
                      debugPrint(videoDto.videoId);
                      final thumbRequest = videoDto
                                  .videoThumbnails?.first.url !=
                              null
                          ? (await http.get(
                              Uri.parse(videoDto.videoThumbnails!.first.url!)))
                          : null;
                      debugPrint(thumbRequest?.headers["Content-Type"]);
                      final newSong = Song(
                          path: videoDto.videoId ?? "",
                          title: videoDto.title ?? "sem nome",
                          picture: thumbRequest?.bodyBytes,
                          pictureMimeType:
                              thumbRequest?.headers["Content-Type"],
                          isOnline: true,
                          duration: videoDto.lengthSeconds,
                          modified: DateTime(0),
                          year: videoDto.published);
                      newSong.colors.addAll(
                          await colorService.getAllColorFromSong(newSong));
                      newSongs.add(newSong);
                    }
                    setState(() {
                      songs = newSongs;
                    });
                  }
                },
                child: Text(
                  "pesquisar",
                  style: TextStyle(color: colors.secondary),
                ))
          ],
        ),
        Expanded(
            child: isGrid
                ? ListView.builder(
                    itemCount: songs.length, itemBuilder: buildSongCard)
                : GridView.builder(
                    itemCount: songs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridItems),
                    itemBuilder: buildSongCard,
                  ))
      ],
    );
  }
}
