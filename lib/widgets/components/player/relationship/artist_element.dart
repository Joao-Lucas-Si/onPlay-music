import 'package:flutter/material.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/player/relationship/relationship_item.dart';
import 'package:provider/provider.dart';

class ArtistElement extends StatelessWidget {
  final Artist artist;

  const ArtistElement(this.artist, {super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final style = settings.interface.artistRelationStyle;
    return RelationshipItem(
      style: style,
      text: artist.name,
      image: artist.picture,
    );
  }
}
