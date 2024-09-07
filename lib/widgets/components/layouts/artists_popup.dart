import 'package:flutter/material.dart';
import 'package:myapp/store/song_store.dart';
import 'package:myapp/widgets/components/layouts/songs_popup.dart';
import 'package:provider/provider.dart';

class SongsPopup extends StatefulWidget {
  @override
  createState() => _SongsPopup();
}

class _SongsPopup extends State<SongsPopup> {
  @override
  Widget build(BuildContext context) {
    final sorts = [
      PopupOption(value: "name", text: "nome"),
      PopupOption(value: "songs", text: "músicas"),
    ];
    final orders = [
      PopupOption(text: "crescente", value: "asc"),
      PopupOption(text: "decrescente", value: "desc"),
    ];

    final store = Provider.of<SongStore>(context);

    return PopupMenuButton<String>(
        onSelected: (value) {
          if (["desc", "asc"].contains(value)) {
            store.artistOrder = value;
          } else {
            store.artistSort = value;
          }
        },
        itemBuilder: (context) => [
              ...sorts.map((sort) => PopupMenuItem(
                    value: sort.value,
                    child: PopupItem(
                      currentValue: store.artistSort,
                      text: sort.text,
                      value: sort.value,
                    ),
                  )),
              const PopupMenuDivider(),
              ...orders.map((order) => PopupMenuItem(
                    value: order.value,
                    child: PopupItem(
                      currentValue: store.artistOrder,
                      text: order.text,
                      value: order.value,
                    ),
                  ))
            ]);
  }
}
