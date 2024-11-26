import 'package:flutter/material.dart';
import 'package:onPlay/store/content/album_store.dart';
import 'package:onPlay/store/content/artist_store.dart';
import 'package:onPlay/store/content/genre_store.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/services/notification_service.dart';
import 'package:onPlay/services/toast_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/content/song_store.dart';
import 'package:onPlay/store/user_store.dart';
import 'package:onPlay/store/device/volume_store.dart';
import 'package:provider/provider.dart';

class Providers extends StatefulWidget {
  final Widget app;

  const Providers({
    super.key,
    required this.app,
  });

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<Providers> {
  BoxManager? managers;

  @override
  void initState() {
    super.initState();
    BoxManager(notify: false).getBoxs(notify: false).then((managers) {
      setState(() {
        this.managers = managers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return managers == null
        ? MaterialApp(
            home: Scaffold(
                backgroundColor: const Color(0xFF212121),
                body: Center(
                    child: Image.asset(
                  "assets/ic_launcher.png",
                  width: 500,
                  height: 500,
                ))),
          )
        : MultiProvider(providers: [
            ChangeNotifierProvider(create: (context) => VolumeStore()),
            ChangeNotifierProvider(
              create: (context) => managers!,
            ),
            ChangeNotifierProxyProvider<BoxManager, ArtistStore>(
                create: ArtistStore.new,
                update: (context, value, previous) =>
                    previous?.init(value) ?? ArtistStore(context).init(value)),
            ChangeNotifierProxyProvider<BoxManager, GenreStore>(
                create: GenreStore.new,
                update: (context, value, previous) =>
                    previous?.init(value) ?? GenreStore(context).init(value)),
            ChangeNotifierProxyProvider<BoxManager, AlbumStore>(
                create: AlbumStore.new,
                update: (context, value, previous) =>
                    previous?.init(value) ?? AlbumStore(context).init(value)),
            ChangeNotifierProxyProvider<BoxManager, SongStore>(
                create: SongStore.new,
                update: (context, value, previous) =>
                    previous?.init(value) ?? SongStore(context).init(value)),
            ChangeNotifierProvider(create: (context) => Settings(context)),
            ChangeNotifierProvider(
              create: (context) => PlayerStore(context),
            ),
            // ChangeNotifierProxyProvider<PlayerStore, PlayerService>(
            //     create: (context) => PlayerService(context),
            //     update: (context, value, previous) =>
            //         previous?.update(value) ??
            //         PlayerService(context).update(value)),
            ChangeNotifierProvider(
              create: (context) => UserStore(context),
            ),
            Provider(create: (context) => ToastService(context: context)),
            Provider(create: (context) => NotificationService()),
          ], child: widget.app);
  }
}
