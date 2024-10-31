import 'package:flutter/material.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';

class ListItemCard extends StatelessWidget {
  final ItemParams params;

  const ListItemCard({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final ItemParams(:colors, :isColored) = params;
    return Card(
      color: isColored ? colors.background : null,
      child: Row(children: [
        params.image != null
            ? Image.memory(
                params.image!,
                width: 90,
                height: 60,
                fit: BoxFit.cover,
              )
            : const Icon(
                Icons.music_note,
                size: 60,
              ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          children: [
            Text(
              params.title,
              style: TextStyle(color: isColored ? colors.text : Colors.white),
            ),
            params.extra ?? const SizedBox()
          ],
        )),
        params.option ?? const SizedBox()
      ]),
    );
  }
}
