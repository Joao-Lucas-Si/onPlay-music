import 'package:flutter/material.dart';
import 'package:onPlay/widgets/components/cards/item/item_params.dart';

class ImageItemCard extends StatelessWidget {
  final ItemParams params;

  const ImageItemCard({required this.params, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final ItemParams(:colors, :extra, :isColored, :isInGrid, :image, :title, :option) =
        params;

    final background = isColored ? colors.background : Colors.black;
    return Card(
        child: Container(
      height: size.height * 0.35,
      decoration: BoxDecoration(
        image: image != null
            ? DecorationImage(image: MemoryImage(image), fit: BoxFit.cover)
            : null,
      ),
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.decal,
                  colors: [
                Colors.transparent,
                background.withOpacity(0.3),
                background.withOpacity(0.7),
                background
              ])),
          child: Stack(
            children: [
              Positioned.fill(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 10,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      overflow: isInGrid
                                          ? TextOverflow.ellipsis
                                          : null,
                                      color: isColored
                                          ? colors.text
                                          : Colors.white),
                                  textAlign: TextAlign.center,
                                )),
                            option ?? const SizedBox(),
                          ],
                        ),
                        extra ?? const SizedBox()
                      ],
                    )),
              )),
            ],
          )),
    ));
  }
}
