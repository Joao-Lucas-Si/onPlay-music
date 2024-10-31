import 'package:flutter/material.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';
import 'package:provider/provider.dart';

class NormalCard extends StatelessWidget {
  final ItemParams params;

  const NormalCard({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    final ItemParams(:colors, :image, :option, :extra, :title, :isColored, :isInGrid) =
        params;

    final size = MediaQuery.sizeOf(context);
    final settings = Provider.of<Settings>(context);

    return Card(
        elevation: 10,
        color: isColored ? colors.background : null,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(40.0),
        // ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: LayoutBuilder(
                builder: (context, constraints) => image != null
                    ? Image.memory(
                        image,
                        fit: BoxFit.cover,
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxWidth * 0.5,
                      )
                    : Icon(
                        Icons.music_note,
                        size: constraints.maxWidth * 0.4,
                      ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  title,
                  style: TextStyle(
                      overflow: settings.layout.songGridItems != 1
                          ? TextOverflow.ellipsis
                          : null,
                      color: isColored ? colors.text : null),
                  textAlign: TextAlign.center,
                )),
                option ?? const SizedBox.shrink(),
              ],
            ),
            extra ?? const SizedBox.shrink()
          ],
        ));
  }
}
