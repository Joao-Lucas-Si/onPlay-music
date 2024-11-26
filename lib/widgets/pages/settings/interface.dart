import 'package:flutter/material.dart';
import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/enums/colors/color_palette.dart';
import 'package:onPlay/enums/colors/color_theme.dart';
import 'package:onPlay/enums/card_style.dart';
import 'package:onPlay/enums/player/controls_type.dart';
import 'package:onPlay/enums/player/picture_type.dart';
import 'package:onPlay/enums/player/progress_type.dart';
import 'package:onPlay/enums/player/title_type.dart';
import 'package:onPlay/enums/player_element.dart';
import 'package:onPlay/enums/themes.dart';
import 'package:onPlay/models/album.dart';
import 'package:onPlay/models/artist.dart';
import 'package:onPlay/models/genre.dart';
import 'package:onPlay/models/playlist.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/store/settings/layout.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/cards/album_card.dart';
import 'package:onPlay/widgets/components/cards/artist_card.dart';
import 'package:onPlay/widgets/components/cards/genre_card.dart';
import 'package:onPlay/widgets/components/cards/playlist_card.dart';
import 'package:onPlay/widgets/components/cards/song_card.dart';
import 'package:onPlay/widgets/components/forms/check.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';
import 'package:provider/provider.dart';

class InterfaceSettingsScreen extends StatelessWidget {
  const InterfaceSettingsScreen({super.key});
  static const path = "${Config.path}/$route";
  static const route = "interface";

  onTitleChange(Settings settings, TitleType value) {
    final layout = settings.layout;
    if (value == TitleType.option &&
        settings.layout.playerElements.contains(PlayerElement.title)) {
      final elements = settings.layout.playerElements;
      elements.remove(PlayerElement.title);
      layout.lateralElements
          .removeWhere((element) => element.element == PlayerElement.title);
      layout.lateralElements = layout.lateralElements;
      layout.playerElements = elements;
    } else if (!settings.layout.playerElements.contains(PlayerElement.title)) {
      final elements = settings.layout.playerElements;
      elements.add(PlayerElement.title);
      layout.lateralElements.add(LateralPlayerElement(
          element: PlayerElement.title,
          position: LateralPosition.values.firstWhere((position) => !layout
              .lateralElements
              .map((element) => element.position)
              .contains(position))));
      layout.lateralElements = layout.lateralElements;
      layout.playerElements = elements;
    }
    settings.interface.titleType = value;
  }

  onProgressChange(Settings settings, ProgressType value) {
    final interface = settings.interface;
    interface.progressType = value;
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final layout = settings.layout;
    final interface = settings.interface;
    final songExample = Song(
        path: "",
        title: "musica",
        duration: 0,
        modified: DateTime.now(),
        year: 0);
    songExample.colors.add(purpleTheme);

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
                  const Text("Card de Música"),
                  SongCard(song: songExample),
                  const Text("card colorido"),
                  UniqueCheck(
                      value: settings.interface.coloredSongCard,
                      text: "colorido",
                      onChanged: (value) {
                        settings.interface.coloredSongCard = value;
                      }),
                  const Text("estilo de card"),
                  DropdownButton(
                      value: settings.interface.songCardStyle,
                      items: CardStyle.values
                          .map((style) => DropdownMenuItem(
                                value: style,
                                child: Text(style.name),
                              ))
                          .toList(),
                      onChanged: (style) {
                        if (style != null) {
                          settings.interface.songCardStyle = style;
                        }
                      }),
                  const Text("Card de Artist"),
                  ArtistCard(
                    artist: Artist(name: "Artist"),
                  ),
                  const Text("card colorido"),
                  UniqueCheck(
                      value: settings.interface.coloredArtistCard,
                      text: "colorido",
                      onChanged: (value) {
                        settings.interface.coloredArtistCard = value;
                      }),
                  const Text("estilo de card"),
                  DropdownButton(
                      value: settings.interface.artistCardStyle,
                      items: CardStyle.values
                          .map((style) => DropdownMenuItem(
                                value: style,
                                child: Text(style.name),
                              ))
                          .toList(),
                      onChanged: (style) {
                        if (style != null) {
                          settings.interface.artistCardStyle = style;
                        }
                      }),
                  const Text("Card de Album"),
                  AlbumCard(
                    album: Album(name: "Exemplo"),
                  ),
                  const Text("card colorido"),
                  UniqueCheck(
                      value: settings.interface.coloredAlbumCard,
                      text: "colorido",
                      onChanged: (value) {
                        settings.interface.coloredAlbumCard = value;
                      }),
                  const Text("estilo de card"),
                  DropdownButton(
                      value: settings.interface.albumCardStyle,
                      items: CardStyle.values
                          .map((style) => DropdownMenuItem(
                                value: style,
                                child: Text(style.name),
                              ))
                          .toList(),
                      onChanged: (style) {
                        if (style != null) {
                          settings.interface.albumCardStyle = style;
                        }
                      }),
                  const Text("Card de Playlist"),
                  PlaylistCard(
                    playlist: Playlist(name: ""),
                  ),
                  const Text("card colorido"),
                  UniqueCheck(
                      value: settings.interface.coloredPlaylistCard,
                      text: "colorido",
                      onChanged: (value) {
                        settings.interface.coloredPlaylistCard = value;
                      }),
                  const Text("estilo de card"),
                  DropdownButton(
                      value: settings.interface.playlistCardStyle,
                      items: CardStyle.values
                          .map((style) => DropdownMenuItem(
                                value: style,
                                child: Text(style.name),
                              ))
                          .toList(),
                      onChanged: (style) {
                        if (style != null) {
                          settings.interface.playlistCardStyle = style;
                        }
                      }),
                  const Text("Card de gênero"),
                  GenreCard(
                    genre: Genre(name: "Exemplo"),
                  ),
                  const Text("card colorido"),
                  UniqueCheck(
                      value: settings.interface.coloredGenreCard,
                      text: "colorido",
                      onChanged: (value) {
                        settings.interface.coloredGenreCard = value;
                      }),
                  const Text("estilo de card"),
                  DropdownButton(
                      value: settings.interface.genreCardStyle,
                      items: CardStyle.values
                          .map((style) => DropdownMenuItem(
                                value: style,
                                child: Text(style.name),
                              ))
                          .toList(),
                      onChanged: (style) {
                        if (style != null) {
                          settings.interface.genreCardStyle = style;
                        }
                      }),
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
                        if (value != null) {
                          settings.interface.controlsType = value;
                        }
                      }),
                  const Text("tema de cores básico"),
                  DropdownButton(
                      value: settings.interface.baseTheme,
                      items: Themes.values
                          .map((theme) => DropdownMenuItem(
                                value: theme,
                                child: Text(theme.name),
                              ))
                          .toList(),
                      onChanged: (theme) {
                        if (theme != null) settings.interface.baseTheme = theme;
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
                        if (value != null) {
                          settings.interface.pictureType = value;
                        }
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
                      interface.showChangePalette =
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
                  const Text("Tipo de barra de progresso"),
                  Check(
                    value: ProgressType.linear,
                    currentValue: interface.progressType,
                    text: "linha",
                    onChanged: (value) => onProgressChange(settings, value),
                  ),
                  Check(
                    value: ProgressType.skip,
                    currentValue: interface.progressType,
                    text: "skip",
                    onChanged: (value) => onProgressChange(settings, value),
                  ),
                  const SizedBox.square(
                    dimension: 100,
                  )
                ],
              )),
        ));
  }
}

class UniqueCheck extends StatelessWidget {
  final bool value;
  final String text;
  final Function(bool value) onChanged;

  const UniqueCheck(
      {super.key,
      required this.value,
      required this.text,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (_) {
            if (_ != null) {
              onChanged(_);
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
