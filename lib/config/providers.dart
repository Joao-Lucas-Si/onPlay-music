import 'package:flutter/material.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/services/notification_service.dart';
import 'package:onPlay/services/toast_service.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/store/color_store.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:onPlay/store/volume_store.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  final Widget app;

  const Providers({
    super.key,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => VolumeStore()),
      ChangeNotifierProvider(
        create: (context) => BoxManager(),
      ),
      ChangeNotifierProxyProvider<BoxManager, SongStore>(
          create: (context) => SongStore(),
          update: (context, value, previous) =>
              previous?.init(value) ?? SongStore().init(value)),
      ChangeNotifierProvider(
        create: (context) => PlayerStore(),
      ),
      ChangeNotifierProvider(create: (context) => Settings()),
      ChangeNotifierProxyProvider<PlayerStore, PlayerService>(
          create: (context) => PlayerService(context),
          update: (context, value, previous) =>
              previous?.update(value) ?? PlayerService(context).update(value)),
      Provider(create: (context) => ToastService(context: context)),
      Provider(create: (context) => NotificationService()),
      ChangeNotifierProxyProvider<PlayerStore, ColorStorage>(
          create: (context) => ColorStorage(context: context),
          update: (context, value, previous) =>
              previous?.update(value.playingSong, value.playlist, context) ??
              ColorStorage(context: context)
                  .update(value.playingSong, value.playlist, context)),
    ], child: app);
  }
}
