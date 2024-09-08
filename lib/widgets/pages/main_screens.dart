import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/store/player_store.dart';
import 'package:myapp/store/song_store.dart';
import 'package:myapp/widgets/components/layouts/songs_popup.dart';
import 'package:myapp/widgets/components/mini_player.dart';
import 'package:myapp/widgets/pages/Artists.dart';
import 'package:myapp/widgets/pages/genres.dart';
import 'package:myapp/widgets/pages/home.dart';
import 'package:myapp/widgets/pages/Playlists.dart';
import 'package:myapp/widgets/pages/albums.dart';
import 'package:myapp/widgets/pages/player_screen.dart';
import 'package:myapp/widgets/pages/songs.dart';
import 'package:provider/provider.dart';

class MainScreens extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  var initialPage = 0;

  var currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: initialPage);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SongStore>(context);
    final player = Provider.of<PlayerStore>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.music_note), label: "musicas"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Artistas"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Gêneros"),
          BottomNavigationBarItem(icon: Icon(Icons.disc_full), label: "albuns"),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play), label: "Playlist"),
        ],
        onTap: (value) => {
          pageController.animateToPage(value,
              duration: const Duration(microseconds: 400), curve: Curves.ease)
        },
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (value) => {
              setState(() {
                currentPage = value;
              })
            },
            children: [
              Home(),
              Songs(),
              Artists(),
              Genres(),
              Albums(),
              Playlist(),
            ],
          ),
          player.playingSong != null ? PlayerScreen() : const Stack()
        ],
      ),
      appBar: AppBar(
        title: const Text("onPlay"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).push("/search");
            },
            icon: const Icon(Icons.search)),
        actions: [
          IconButton(
              onPressed: () {
                store.refresh();
              },
              icon: const Icon(Icons.refresh)),
          currentPage == 1
              ? SongsPopup()
              : IconButton(
                  onPressed: () {
                    GoRouter.of(context).push("/settings");
                  },
                  icon: const Icon(Icons.settings)),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
