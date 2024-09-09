import 'package:flutter/material.dart';
import 'package:onPlay/dto/album.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/widgets/components/album_card.dart';
import 'package:provider/provider.dart';

class Albums extends StatefulWidget {
  @override
  createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  late SongStore store;

  List<Album> get albums {
    List<Album> albums = List.from(store.albums);

    return store.artistOrder == "desc" ? albums.reversed.toList() : albums;
  }

  @override
  Widget build(BuildContext context) {
    store = Provider.of<SongStore>(context);
    return Scaffold(
      body: store.loading != ""
          ? Text(store.loading)
          : albums.isEmpty
              ? const Text("nenhuma album encontrado")
              : ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    final album = albums[index];
                    return AlbumCard(album: album);
                  }),
    );
  }
}
