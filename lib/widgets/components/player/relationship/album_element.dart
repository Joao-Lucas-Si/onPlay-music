import 'package:flutter/material.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/player/relationship/relationship_item.dart';
import 'package:provider/provider.dart';

class AlbumElement extends StatelessWidget {
  final Album album;

  const AlbumElement(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final style = settings.interface.albumRelationStyle;
    return RelationshipItem(
      style: style,
      text: album.name,
      image: album.picture,
    );
  }
}
