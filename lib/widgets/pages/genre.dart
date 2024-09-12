import 'package:flutter/material.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/widgets/components/song_card.dart';

class GenreScreen extends StatelessWidget {
  final Genre genre;

  const GenreScreen({required this.genre, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          genre.picture != null
              ? Image.memory(
                  genre.picture!,
                  width: MediaQuery.of(context).size.width,
                )
              : Icon(
                  Icons.category,
                  size: MediaQuery.of(context).size.width,
                ),
          Text(
            genre.name,
            style: const TextStyle(fontSize: 30),
          ),
          ...genre.songs.map((song) => SongCard(song: song)).toList()
        ],
      )),
    );
  }
}
