import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:onPlay/enums/main_screens.dart';
import 'package:onPlay/enums/player/container_style.dart';
import 'package:onPlay/enums/player/picture_type.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/enums/player/volume_type.dart';
import 'package:onPlay/store/settings/layout.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/forms/check.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';
import 'package:provider/provider.dart';

class LayoutSettingsScreen extends StatelessWidget {
  const LayoutSettingsScreen({super.key});
  static const path = "${Config.path}/$route";
  static const route = "layout";

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final layout = settings.layout;
    final interface = settings.interface;
    return Scaffold(
        appBar: AppBar(
          title: const Text("configurações de layout"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Tela de musicas"),
              Check(
                value: 2,
                currentValue: settings.layout.songGridItems,
                text: "mostrar em grid",
                onChanged: (value) {
                  settings.layout.songGridItems =
                      settings.layout.songGridItems == 2 ? 1 : 2;
                },
              ),
              const Text("Tela de gêneros"),
              Check(
                value: 2,
                currentValue: settings.layout.genreGridItems,
                text: "mostrar em grid",
                onChanged: (value) {
                  settings.layout.genreGridItems =
                      settings.layout.genreGridItems == 2 ? 1 : 2;
                },
              ),
              const Text("Tela de artistas"),
              Check(
                value: 2,
                currentValue: settings.layout.artistGridItems,
                text: "mostrar em grid",
                onChanged: (value) {
                  settings.layout.artistGridItems =
                      settings.layout.artistGridItems == 2 ? 1 : 2;
                },
              ),
              const Text("Tela de albuns"),
              Check(
                value: 2,
                currentValue: settings.layout.albumGridItems,
                text: "mostrar em grid",
                onChanged: (value) {
                  settings.layout.albumGridItems =
                      settings.layout.albumGridItems == 2 ? 1 : 2;
                },
              ),
              const Text("Tela de playlist"),
              Check(
                value: 2,
                currentValue: settings.layout.playlistGridItems,
                text: "mostrar em grid",
                onChanged: (value) {
                  settings.layout.playlistGridItems =
                      settings.layout.playlistGridItems == 2 ? 1 : 2;
                },
              ),
              const Text("telas"),
              SizedBox(
                height: MainScreens.values
                        .where((screen) =>
                            !settings.layout.hiddenScreens.contains(screen))
                        .length *
                    65,
                child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      //layout.replaceMainScreens(oldIndex, newIndex);
                    },
                    children: MainScreens.values
                        .where((screen) =>
                            !settings.layout.hiddenScreens.contains(screen))
                        .map((element) => Card(
                            elevation: 2,
                            key: ValueKey(element.name),
                            child: Dismissible(
                                secondaryBackground: Container(
                                  alignment: Alignment.centerRight,
                                  color: Colors.red,
                                  padding: const EdgeInsets.only(right: 10),
                                  child: const Text("ocultar"),
                                ),
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  color: Colors.red,
                                  padding: const EdgeInsets.only(left: 10),
                                  child: const Text("ocultar"),
                                ),
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  layout.hiddenScreen(element);
                                },
                                direction: [MainScreens.home].contains(element)
                                    ? DismissDirection.none
                                    : DismissDirection.horizontal,
                                child: ListTile(
                                    title: Text(
                                  element.name,
                                )))))
                        .toList()),
              ),
              const Text("telas ocultadas"),
              layout.hiddenScreens.isEmpty
                  ? const Text("todos os elementos estão visiveis")
                  : const SizedBox.shrink(),
              SizedBox(
                height: layout.hiddenScreens.length * 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: layout.hiddenScreens
                      .map((screen) => Card(
                          elevation: 2,
                          child: Dismissible(
                            secondaryBackground: Container(
                              alignment: Alignment.centerRight,
                              color: Colors.red,
                              padding: const EdgeInsets.only(right: 10),
                              child: const Text("desocultar"),
                            ),
                            background: Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text("desocultar"),
                            ),
                            direction: DismissDirection.horizontal,
                            onDismissed: (direction) {
                              layout.showScreen(screen);
                            },
                            key: UniqueKey(),
                            child: ListTile(title: Text(screen.name)),
                          )))
                      .toList(),
                ),
              ),
              const Text("elementos do player"),
              SizedBox(
                height: (interface.pictureType == PictureType.background &&
                        layout.containerStyle == ContainerStyle.lateral)
                    ? layout.lateralElements.length * 75
                    : layout.playerElements.length * 70,
                child: (interface.pictureType == PictureType.background &&
                        layout.containerStyle == ContainerStyle.lateral)
                    ? Column(
                        children: layout.lateralElements
                            .map((element) => Card(
                                  elevation: 2,
                                  child: ListTile(
                                    title: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      spacing: 20,
                                      children: [
                                        Text(element.element.name),
                                        DropdownButton(
                                          onChanged: (value) {
                                            if (value != null) {
                                              final usedPosition = layout
                                                  .lateralElements
                                                  .firstWhereOrNull((lateral) =>
                                                      lateral.position ==
                                                      value);
                                              if (usedPosition != null) {
                                                usedPosition.position =
                                                    element.position;
                                                element.position = value;
                                                layout.lateralElements =
                                                    layout.lateralElements;
                                              } else {
                                                element.position = value;
                                                layout.lateralElements =
                                                    layout.lateralElements;
                                              }
                                            }
                                          },
                                          value: element.position,
                                          items: LateralPosition.values
                                              .map((position) =>
                                                  DropdownMenuItem(
                                                      value: position,
                                                      child: Text(
                                                          position.toString())))
                                              .toList(),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                            .toList())
                    : ReorderableListView(
                        onReorder: (oldIndex, newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final element = layout.playerElements[oldIndex];
                          layout.playerElements.removeAt(oldIndex);
                          layout.playerElements.insert(newIndex, element);
                          layout.playerElements = layout.playerElements;
                        },
                        children: layout.playerElements
                            .map((element) => Dismissible(
                                onDismissed: (direction) {
                                  layout.removePlayerElement(element);
                                },
                                key: ValueKey(element.name),
                                child: Card(
                                    elevation: 2,
                                    key: ValueKey(element.name),
                                    child: ListTile(
                                        title: Text(
                                      element.name,
                                    )))))
                            .toList()),
              ),
              const Text("Tipo de controle de volume"),
              DropdownButton(
                value: layout.volumeType,
                items: [
                  ...VolumeType.values.map((type) => DropdownMenuItem(
                      key: ValueKey(type.name),
                      value: type,
                      child: Text(
                        type.name,
                        style: const TextStyle(color: Colors.white),
                      )))
                ],
                onChanged: (value) {
                  if (value != null) {
                    if (layout.playerElements.contains(PlayerElement.volume) &&
                        value == VolumeType.option) {
                      layout.playerElements.remove(PlayerElement.volume);
                      layout.lateralElements.removeWhere(
                          (element) => element.element == PlayerElement.volume);
                      layout.playerElements = layout.playerElements;
                    } else if (!layout.playerElements
                        .contains(PlayerElement.volume)) {
                      layout.playerElements.add(PlayerElement.volume);
                      layout.lateralElements.add(LateralPlayerElement(
                          element: PlayerElement.volume,
                          position: LateralPosition.values.firstWhere(
                              (position) => !layout.lateralElements
                                  .map((element) => element.position)
                                  .contains(position))));
                      layout.lateralElements = layout.lateralElements;
                      layout.playerElements = layout.playerElements;
                    }
                    layout.volumeType = value;
                  }
                },
              ),
              const Text("elementos ocultados"),
              ...PlayerElement.values
                  .where((element) => !layout.playerElements.contains(element))
                  .map((element) => Dismissible(
                      onDismissed: (direction) {
                        layout.addPlayerElement(element);
                      },
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        padding: const EdgeInsets.only(right: 10),
                        child: const Text("desocultar"),
                      ),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.red,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text("desocultar"),
                      ),
                      key: ValueKey(element.name),
                      child: ListTile(
                        title: Text(element.name),
                      ))),
              const Text("estilos de player com imagem de fundo"),
              DropdownButton(
                value: layout.containerStyle,
                items: ContainerStyle.values
                    .map((value) => DropdownMenuItem(
                        enabled: value == ContainerStyle.normal ||
                            (value != ContainerStyle.normal &&
                                interface.pictureType ==
                                    PictureType.background),
                        value: value,
                        child: Text(value.toString())))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    layout.containerStyle = value;
                  }
                },
              ),
              const SizedBox.square(
                dimension: 100,
              )
            ],
          ),
        ));
  }
}
