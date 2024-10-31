import 'package:flutter/material.dart';
import 'package:onPlay/database/objectbox.g.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/models/managers/base_manager.dart';

class AlbumManager extends BaseManager<Album> {
  AlbumManager(super.box);

  void deleteEmpty() {
    debugPrint("removendo vazios");
    box.query(Album_.songs.relationCount(0)).build().remove();
    debugPrint(
        box.query(Album_.songs.relationCount(0)).build().find().toString());
  }
}
