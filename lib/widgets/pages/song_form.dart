import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/models/song.dart';
import 'package:onPlay/services/files_service.dart';
import 'package:onPlay/services/toast_service.dart';
import 'package:onPlay/store/content/song_store.dart';
import 'package:provider/provider.dart';

class SongForm extends StatefulWidget {
  const SongForm({super.key, required this.song});

  final Song song;

  static const url = "/song-form";

  @override
  State<StatefulWidget> createState() {
    return _SongFormState();
  }
}

class _SongFormState extends State<SongForm> {
  final titleControl = TextEditingController();
  final artistControl = TextEditingController();
  final albumControl = TextEditingController();
  final genreControl = TextEditingController();
  final yearControl = TextEditingController();

  @override
  initState() {
    super.initState();
    titleControl.value = TextEditingValue(text: widget.song.title);
    final artist = widget.song.artist.target?.name;
    artistControl.value = TextEditingValue(
        text: artist != "desconhecido" && artist != null ? artist : "");
    final album = widget.song.album.target?.name;
    albumControl.value = TextEditingValue(
        text: album != "desconhecido" && album != null ? album : "");
    final genre = widget.song.genre.target?.name;
    genreControl.value = TextEditingValue(
        text: genre != "desconhecido" && genre != null ? genre : "");
    final year = widget.song.year;
    yearControl.value = TextEditingValue(text: year?.toString() ?? "0");
  }

  @override
  Widget build(BuildContext context) {
    final song = widget.song;
    final toastService = Provider.of<ToastService>(context);
    final songStore = Provider.of<SongStore>(context);

    showSuccessMessage() {
      toastService.showTextToast("alterações salvas com sucesso",
          context: context);
    }

    back() {
      GoRouter.of(context).pop();
    }

    showErrorMessage() {
      toastService.showTextToast("Não foi possivel salvar as alterações",
          context: context);
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            song.picture != null
                ? Image.memory(
                    song.picture!,
                    width: MediaQuery.of(context).size.width,
                  )
                : Icon(
                    Icons.music_off,
                    size: MediaQuery.of(context).size.width,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  TextField(
                    controller: titleControl,
                    decoration: const InputDecoration(labelText: "Título"),
                  ),
                  TextField(
                    controller: artistControl,
                    decoration: const InputDecoration(labelText: "Artista"),
                  ),
                  TextField(
                    controller: albumControl,
                    decoration: const InputDecoration(labelText: "Album"),
                  ),
                  TextField(
                    controller: genreControl,
                    decoration: const InputDecoration(labelText: "Gênero"),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: yearControl,
                    decoration: const InputDecoration(labelText: "Ano"),
                  ),
                  //YearPicker(firstDate: firstDate, lastDate: lastDate, selectedDate: selectedDate, onChanged: onChanged)
                  Container(
                    height: 20,
                  ),
                  Center(
                    child: TextButton.icon(
                        label: Text(
                          "Salvar",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.primary)),
                        icon: Icon(Icons.save,
                            color: Theme.of(context).colorScheme.secondary),
                        onPressed: () async {
                          final title = titleControl.value.text;
                          final artist = artistControl.value.text;
                          final album = albumControl.value.text;
                          final genre = genreControl.value.text;
                          final year = int.parse(yearControl.value.text);
                          debugPrint("titulo: $title");
                          debugPrint("artista: $artist");
                          debugPrint("album: $album");
                          debugPrint("genero: $genre");
                          debugPrint("ano: $year");

                          if (song.isOnline) {
                            songStore.updateOnlineSong(
                                song: song,
                                artist: artist,
                                name: title,
                                year: year,
                                album: album,
                                genre: genre);
                            showSuccessMessage();
                            back();
                          } else {
                            try {
                              await FilesService.editMetadata(
                                  song.path,
                                  Metadata(
                                      album: album,
                                      artist: artist,
                                      genre: genre,
                                      title: title,
                                      year: year));
                              songStore.updateSong(song.path);
                              showSuccessMessage();
                              back();
                            } catch (e) {
                              debugPrint(e.toString());
                              showErrorMessage();
                            }
                          }
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
