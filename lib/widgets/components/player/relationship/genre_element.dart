import 'package:flutter/material.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/player/relationship/relationship_item.dart';
import 'package:provider/provider.dart';

class GenreElement extends StatelessWidget {
  final Genre genre;

  const GenreElement(this.genre, {super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final style = settings.interface.genreRelationStyle;
    return RelationshipItem(
      style: style,
      text: genre.name,
      image: genre.picture,
    );
  }
}
