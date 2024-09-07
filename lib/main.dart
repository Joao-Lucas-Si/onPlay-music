import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:myapp/config/router.dart';
import 'package:myapp/services/NotificationsService.dart';
import 'package:myapp/services/player_service.dart';
import 'package:myapp/services/ToastService.dart';
import 'package:myapp/store/color_store.dart';
import 'package:myapp/store/player_store.dart';
import 'package:myapp/store/song_store.dart';
import 'package:provider/provider.dart';

void main() {
  MetadataGod.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SongStore()),
      ChangeNotifierProvider(
        create: (context) => PlayerStore(),
      ),
      ChangeNotifierProxyProvider<PlayerStore, PlayerService>(
          create: (context) => PlayerService(),
          update: (context, value, previous) =>
              previous?.update(value) ?? PlayerService().update(value)),
      Provider(create: (context) => ToastService(context: context)),
      Provider(create: (context) => NotificationService()),
      ChangeNotifierProxyProvider<PlayerStore, ColorStorage>(
          create: (context) => ColorStorage(),
          update: (context, value, previous) =>
              previous?.update(value.playingSong) ??
              ColorStorage().update(value.playingSong)),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'onPlay',
      builder: (context, child) => child ?? Text("not found"),
      theme: ThemeData(
          primaryColor: Colors.deepPurple,
          primarySwatch: Colors.deepPurple,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
          brightness: Brightness.dark),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
