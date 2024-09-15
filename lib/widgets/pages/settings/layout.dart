import 'package:flutter/material.dart';
import 'package:onPlay/enums/main_screens.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/enums/volume_type.dart';
import 'package:onPlay/localModels/settings/settings.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("configurações de layout"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("telas"),
              SizedBox(
                height: layout.mainScreens.length * 65,
                child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      layout.replaceMainScreens(oldIndex, newIndex);
                    },
                    children: layout.mainScreens
                        .map((element) => Card(
                            elevation: 2,
                            key: ValueKey(element.name),
                            child: Dismissible(
                                secondaryBackground: Container(
                                  alignment: Alignment.centerRight,
                                  color: Colors.red,
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text("ocultar"),
                                ),
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  color: Colors.red,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("ocultar"),
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
              Text("telas ocultadas"),
              layout.hiddenScreens.length == 0
                  ? Text("todos os elementos estão visiveis")
                  : SizedBox.shrink(),
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
                              padding: EdgeInsets.only(right: 10),
                              child: Text("desocultar"),
                            ),
                            background: Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                              padding: EdgeInsets.only(left: 10),
                              child: Text("desocultar"),
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
              Text("elementos do player"),
              SizedBox(
                height: layout.playerElements.length * 65,
                child: ReorderableListView(
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
                        .map((element) => Card(
                            elevation: 2,
                            key: ValueKey(element.name),
                            child: ListTile(
                                title: Text(
                              element.name,
                            ))))
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
                      layout.playerElements.remove(value);
                      layout.playerElements = layout.playerElements;
                    } else if (!layout.playerElements
                        .contains(PlayerElement.volume)) {
                      layout.playerElements.add(PlayerElement.volume);
                      layout.playerElements = layout.playerElements;
                    }
                    layout.volumeType = value;
                  }
                },
              ),
              SizedBox.square(
                dimension: 100,
              )
            ],
          ),
        ));
  }
}
