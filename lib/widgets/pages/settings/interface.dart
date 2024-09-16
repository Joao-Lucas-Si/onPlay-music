import 'package:flutter/material.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/enums/player/controls_type.dart';
import 'package:onPlay/enums/player/picture_type.dart';
import 'package:onPlay/enums/player/title_type.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';
import 'package:provider/provider.dart';

class InterfaceSettingsScreen extends StatelessWidget {
  const InterfaceSettingsScreen({super.key});
  static const path = "${Config.path}/$route";
  static const route = "interface";

  onTitleChange(Settings settings, TitleType value) {
    if (value == TitleType.option &&
        settings.layout.playerElements.contains(PlayerElement.title)) {
      final elements = settings.layout.playerElements;
      elements.remove(PlayerElement.title);
      settings.layout.playerElements = elements;
    } else if (!settings.layout.playerElements.contains(PlayerElement.title)) {
      final elements = settings.layout.playerElements;
      elements.add(PlayerElement.title);
      settings.layout.playerElements = elements;
    }
    settings.interface.titleType = value;
  }

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
                        if (value == PictureType.disk &&
                            layout.playerElements
                                .contains(PlayerElement.controls)) {
                          var temp = [...layout.playerElements];
                          temp.removeWhere(
                              (element) => element == PlayerElement.controls);
                          layout.playerElements = temp;
                        } else if (!layout.playerElements
                                .contains(PlayerElement.controls) &&
                            !layout.playerElements
                                .contains(PlayerElement.controls)) {
                          var temp = [...layout.playerElements];
                          temp.insert(temp.length, PlayerElement.controls);
                          layout.playerElements = temp;
                        }
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
                  const Text("opções"),
                  Check(
                    value: true,
                    currentValue: interface.showChangeTheme,
                    text: "mostrar opção de mudar tema no player",
                    onChanged: (value) {
                      interface.showChangeTheme = !interface.showChangeTheme;
                    },
                  ),
                  Check(
                    value: true,
                    currentValue: interface.showChangePalette,
                    text: "mostrar opção de mudar paleta no player",
                    onChanged: (value) {
                      interface.showChangePallete =
                          !interface.showChangePalette;
                    },
                  ),
                  const Text("Tipo de titulo"),
                  Check(
                    value: TitleType.loop,
                    currentValue: interface.titleType,
                    text: "em loop",
                    onChanged: (value) => onTitleChange(settings, value),
                  ),
                  Check(
                    value: TitleType.option,
                    currentValue: interface.titleType,
                    text: "como opção",
                    onChanged: (value) => onTitleChange(settings, value),
                  ),
                  const SizedBox.square(
                    dimension: 100,
                  )
                ],
              )),
        ));
  }
}

class Check<T> extends StatelessWidget {
  final T value;
  final T currentValue;
  final String text;
  final Function(T value) onChanged;

  const Check(
      {super.key,
      required this.value,
      required this.currentValue,
      required this.text,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: currentValue == value,
          onChanged: (_) {
            if (_ != null) {
              onChanged(value);
            }
          },
        ),
        Text(text)
      ],
    );
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
