enum MainScreens {
  home("home"),
  musics("musics"),
  artists("artists"),
  albums("albums"),
  genres("genres"),
  // youtube("youtube"),
  playlists("playlists");

  final String name;

  const MainScreens(this.name);

  static MainScreens fromString(String name) {
    return MainScreens.values.firstWhere((value) => value.name == name);
  }
}
