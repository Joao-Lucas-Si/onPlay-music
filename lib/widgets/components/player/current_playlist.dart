import 'package:flutter/material.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:provider/provider.dart';

class CurrentPlaylist extends StatelessWidget {
  static const minSize = 0.06;
  final maxSize = 0.95;

  const CurrentPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PlayerStore>(context);
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
        child: DraggableScrollableSheet(
      maxChildSize: maxSize,
      initialChildSize: minSize,
      minChildSize: minSize,
      snap: true,
      builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * (maxSize - 0.1),
            child: Container(
                decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      transformAlignment: Alignment.center,
                      height: MediaQuery.sizeOf(context).height * minSize,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.secondary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 15,
                        width: 100,
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        child: ListView.builder(
                          itemCount: store.playlist.length,
                          itemBuilder: (context, i) {
                            final song = store.playlist[i];
                            return Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                    onTap: () {
                                      store.currentSong = i;
                                    },
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      runAlignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      spacing: 10,
                                      children: [
                                        song.picture != null
                                            ? Image.memory(
                                                song.picture!,
                                                width: 100,
                                              )
                                            : const Icon(
                                                Icons.music_off,
                                                size: 100,
                                              ),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width -
                                                  125,
                                          child: Text(
                                            song.title,
                                            style: TextStyle(
                                                color: i <
                                                        (store.currentSong ?? 0)
                                                    ? Colors.grey[700]
                                                    : (i ==
                                                            (store.currentSong ??
                                                                0))
                                                        ? colorScheme.secondary
                                                        : Colors.grey[300]),
                                          ),
                                        )
                                      ],
                                    )));
                          },
                        ))
                  ],
                )),
          )),
    ));
  }
}
