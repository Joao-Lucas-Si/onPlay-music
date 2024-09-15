import 'package:flutter/material.dart';
import 'package:onPlay/enums/color_palette.dart';
import 'package:onPlay/enums/color_theme.dart';
import 'package:onPlay/enums/controls_type.dart';
import 'package:onPlay/enums/picture_type.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';
import 'package:provider/provider.dart';

class InterfaceSettingsScreen extends StatelessWidget {
  const InterfaceSettingsScreen({super.key});
  static const path = "${Config.path}/$route";
  static const route = "interface";

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final layout = settings.layout;
    final interface = settings.interface;
    return Scaffold(
        appBar: AppBar(
          title: const Text("configurações de interface"),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("estilo dos botões"),
                  DropdownButton(
                      value: interface.controlsType,
                      items: ControlsType.values
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null)
                          settings.interface.controlsType = value;
                      }),
                  const Text("estilo da imagem"),
                  DropdownButton(
                      value: settings.interface.pictureType,
                      items: PictureType.values
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value == PictureType.background) {
                          var temp = [...layout.playerElements];
                          temp.removeWhere(
                              (element) => element == PlayerElement.picture);
                          layout.playerElements = temp;
                        } else if (!layout.playerElements
                            .contains(PlayerElement.picture)) {
                          var temp = [...layout.playerElements];
                          temp.insert(0, PlayerElement.picture);
                          layout.playerElements = temp;
                        }
                        if (value != null)
                          settings.interface.pictureType = value;
                      }),
                  const Text("tema de cores"),
                  const ThemeCheck(value: ColorTheme.light, text: "claro"),
                  const ThemeCheck(value: ColorTheme.dark, text: "escuro"),
                  const ThemeCheck(
                      value: ColorTheme.totalDark, text: "totalmente escuro"),
                  const Text("estilo de paleta de cores"),
                  const PaletteCheck(
                      value: ColorPalette.normal, text: "normal"),
                  const PaletteCheck(
                      value: ColorPalette.monocromatic, text: "monocromatico"),
                  const PaletteCheck(
                      value: ColorPalette.polychromatic, text: "policromatico"),
                ],
              )),
        ));
  }
}

class ThemeCheck extends StatelessWidget {
  final ColorTheme value;
  final String text;

  const ThemeCheck({super.key, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final interface = settings.interface;
    return Row(
      children: [
        Checkbox(
          value: interface.colorTheme == value,
          onChanged: (_) {
            interface.colorTheme = value;
          },
        ),
        Text(text)
      ],
    );
  }
}

class PaletteCheck extends StatelessWidget {
  final ColorPalette value;
  final String text;

  const PaletteCheck({super.key, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final interface = settings.interface;
    return Row(
      children: [
        Checkbox(
          value: interface.colorPalette == value,
          onChanged: (_) {
            interface.colorPalette = value;
          },
        ),
        Text(text)
      ],
    );
  }
}
