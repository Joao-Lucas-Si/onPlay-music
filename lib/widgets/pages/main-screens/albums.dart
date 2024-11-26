import 'package:flutter/material.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/store/content/album_store.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/album_card.dart';
import 'package:provider/provider.dart';

class Albums extends StatefulWidget {
  const Albums({super.key});

  @override
  createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  late AlbumStore store;

  List<Album> get albums {
    List<Album> albums = List.from(store.albums);

    // return store.artistOrder == "desc" ? albums.reversed.toList() : albums;
    return albums;
  }

  @override
  Widget build(BuildContext context) {
    store = Provider.of<AlbumStore>(context);
    final settings = Provider.of<Settings>(context);
    final gridItems = settings.layout.albumGridItems;
    return Scaffold(
      body: 
      // store.loading != ""
      //     ? Text(store.loading)
      //     : 
          albums.isEmpty
              ? const Text("nenhuma album encontrado")
              : (gridItems == 1
                  ? ListView.builder(
                      itemCount: albums.length,
                      itemBuilder: (context, index) {
                        final album = albums[index];
                        return AlbumCard(
                          album: album,
                          key: ValueKey(album.id),
                        );
                      })
                  : GridView.builder(
                      itemCount: albums.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridItems),
                      itemBuilder: (context, index) => AlbumCard(
                        album: albums[index],
                        key: ValueKey(albums[index].id),
                      ),
                    )),
    );
  }
}
