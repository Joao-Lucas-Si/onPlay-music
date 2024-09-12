import 'package:flutter/material.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:provider/provider.dart';

class SongsPopup extends StatefulWidget {
  @override
  createState() => _SongsPopup();
}

class _SongsPopup extends State<SongsPopup> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final sorts = [
      PopupOption(value: "name", text: "nome"),
      PopupOption(value: "year", text: "ano"),
      PopupOption(value: "duration", text: "duração"),
      PopupOption(value: "modification_date", text: "data de modificação")
    ];
    final orders = [
      PopupOption(text: "crescente", value: "asc"),
      PopupOption(text: "decrescente", value: "desc"),
    ];

    final store = Provider.of<SongStore>(context);

    return PopupMenuButton<String>(
        color: colorScheme.primary,
        iconColor: colorScheme.secondary,
        onSelected: (value) {
          if (["desc", "asc"].contains(value)) {
            store.order = value;
          } else {
            store.sort = value;
          }
        },
        itemBuilder: (context) => [
              ...sorts.map((sort) => PopupMenuItem(
                    value: sort.value,
                    child: PopupItem(
                      currentValue: store.sort,
                      text: sort.text,
                      value: sort.value,
                    ),
                  )),
              const PopupMenuDivider(),
              ...orders.map((order) => PopupMenuItem(
                    value: order.value,
                    child: PopupItem(
                      currentValue: store.order,
                      text: order.text,
                      value: order.value,
                    ),
                  ))
            ]);
  }
}

class PopupItem extends StatelessWidget {
  final String value;
  final String currentValue;
  final String text;

  const PopupItem(
      {super.key,
      required this.currentValue,
      required this.value,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final selected = currentValue == value;
    final colorScheme = Theme.of(context).colorScheme;
    return PopupMenuItem(
        value: value,
        child: Row(
          children: [
            Checkbox(
              value: selected,
              onChanged: (e) {},
              activeColor: colorScheme.secondary,
            ),
            Text(
              text,
              style: TextStyle(color: colorScheme.secondary),
            ),
          ],
        ));
  }
}

class PopupOption {
  String value;
  String text;

  PopupOption({required this.value, required this.text});
}
