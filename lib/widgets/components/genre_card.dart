import 'package:flutter/material.dart';
import 'package:myapp/dto/genre.dart';

class GenreCard extends StatelessWidget {
  Genre genre;

  GenreCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20,
          children: [
            genre.picture != null
                ? Image.memory(
                    genre.picture!,
                    width: 100,
                    height: 100,
                  )
                : const Icon(Icons.category),
            Text(genre.name),
            Text(genre.songs.length.toString())
          ],
        ));
  }
}
