import 'package:flutter/material.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/services/notification_service.dart';
import 'package:onPlay/services/toast_service.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/store/volume_store.dart';
import 'package:provider/provider.dart';

class Providers extends StatefulWidget {
  final Widget app;

  const Providers({
    super.key,
    required this.app,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
                  width: 200,
                  height: 200,
                ))),
          )
        : MultiProvider(providers: [
            ChangeNotifierProvider(create: (context) => VolumeStore()),
            ChangeNotifierProvider(
              create: (context) => managers!,
            ),
            ChangeNotifierProxyProvider<BoxManager, SongStore>(
                create: (context) => SongStore(),
                update: (context, value, previous) =>
                    previous?.init(value) ?? SongStore().init(value)),
            ChangeNotifierProvider(
              create: (context) => PlayerStore(),
            ),
            ChangeNotifierProvider(create: (context) => Settings(context)),
            ChangeNotifierProxyProvider<PlayerStore, PlayerService>(
                create: (context) => PlayerService(context),
                update: (context, value, previous) =>
                    previous?.update(value) ??
                    PlayerService(context).update(value)),
            Provider(create: (context) => ToastService(context: context)),
            Provider(create: (context) => NotificationService()),
          ], child: widget.app);
  }
}
