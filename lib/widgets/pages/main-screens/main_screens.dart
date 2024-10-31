import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/enums/main_screens.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/widgets/components/layouts/songs_popup.dart';
import 'package:onPlay/widgets/pages/main-screens/artists.dart';
import 'package:onPlay/widgets/pages/main-screens/genres.dart';
import 'package:onPlay/widgets/pages/home/home.dart';
import 'package:onPlay/widgets/pages/main-screens/playlists.dart';
import 'package:onPlay/widgets/pages/main-screens/albums.dart';
import 'package:onPlay/widgets/pages/player_screen.dart';
import 'package:onPlay/widgets/pages/main-screens/songs.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<StatefulWidget> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreen> {
  var initialPage = 0;

  var currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: initialPage);
  }

  List<BottomNavigationBarItem> getBottomNavigationItems(
      List<MainScreens> mainScreens) {
    return mainScreens.map((screen) {
      switch (screen) {
        case MainScreens.home:
          return const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home");
        case MainScreens.musics:
          return const BottomNavigationBarItem(
              icon: Icon(Icons.music_note), label: "musicas");
        case MainScreens.albums:
          return const BottomNavigationBarItem(
              icon: Icon(Icons.disc_full), label: "Albuns");
        case MainScreens.artists:
          return const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Artistas");
        case MainScreens.genres:
          return const BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Gêneros");
        case MainScreens.playlists:
          return const BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play), label: "Playlist");
      }
    }).toList();
  }

  List<Widget> getMainScreens(List<MainScreens> mainScreens) {
    return mainScreens.map((screen) {
      switch (screen) {
        case MainScreens.home:
          return const Home();
        case MainScreens.musics:
          return const Songs();
        case MainScreens.playlists:
          return const Playlist();
        case MainScreens.albums:
          return const Albums();
        case MainScreens.genres:
          return const Genres();
        case MainScreens.artists:
          return const Artists();
      }
    }).toList();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final store = Provider.of<SongStore>(context);
    final player = Provider.of<PlayerStore>(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        showUnselectedLabels: false,
        backgroundColor: colorScheme.primary,
        mouseCursor: MouseCursor.defer,
        unselectedItemColor: colorScheme.tertiary,
        selectedItemColor: colorScheme.secondary,
        items: getBottomNavigationItems(settings.layout.mainScreens),
        onTap: (value) => {
          pageController.animateToPage(value,
              duration: const Duration(microseconds: 400), curve: Curves.ease)
        },
      ),
      body: Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                title: Text(
                  "onPlay",
                  style: TextStyle(color: colorScheme.secondary),
                ),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      GoRouter.of(context).push("/search");
                    },
                    icon: Icon(
                      Icons.search,
                      color: colorScheme.secondary,
                    )),
                actions: [
                  IconButton(
                      onPressed: () {
                        store.refresh();
                      },
                      icon: Icon(Icons.refresh, color: colorScheme.secondary)),
                  IconButton(
                      onPressed: () {
                        GoRouter.of(context).push("/settings");
                      },
                      icon: Icon(Icons.settings, color: colorScheme.secondary)),
                  currentPage == 1 ? const SongsPopup() : null,
                ].nonNulls.toList(),
              ),
              body: PageView(
                controller: pageController,
                onPageChanged: (value) => {
                  setState(() {
                    currentPage = value;
                  })
                },
                children: getMainScreens(settings.layout.mainScreens),
                // children: [
                //   Home(),
                //   Songs(),
                //   const Artists(),
                //   Genres(),
                //   Albums(),
                //   Playlist(),
                // ],
              )),
          player.playingSong != null
              ? const PlayerScreen(
                  inMainScreen: true,
                )
              : const Stack()
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
