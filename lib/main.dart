import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/config/router.dart';
import 'package:onPlay/models/Settings.dart';
import 'package:onPlay/services/NotificationsService.dart';
import 'package:onPlay/services/player_service.dart';
import 'package:onPlay/services/ToastService.dart';
import 'package:onPlay/store/color_store.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:onPlay/store/song_store.dart';
import 'package:provider/provider.dart';

void main() {
  MetadataGod.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SongStore()),
    ChangeNotifierProvider(
      create: (context) => PlayerStore(),
    ),
    ChangeNotifierProvider(create: (context) => Settings()),
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
  ], child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) =>
          child != null ? AppTheme(widget: child) : Text("not found"),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

class AppTheme extends StatelessWidget {
  final Widget widget;

  const AppTheme({required this.widget, super.key});
  @override
  Widget build(BuildContext context) {
    final colorStore = Provider.of<ColorStorage>(context);
    final settings = Provider.of<Settings>(context);
    final ThemeData theme = ThemeData.dark();
    final primaryColor = settings.interface.useMusicColors
        ? colorStore.dominantColor
        : Colors.deepPurple;
    final secondaryColors = settings.interface.useMusicColors
        ? colorStore.lightColor
        : Colors.deepPurpleAccent;

    final tertiaryColor =
        settings.interface.useMusicColors ? colorStore.darkColor : Colors.grey;
    return MaterialApp(
      title: 'onPlay',
      theme: ThemeData(
        colorScheme: theme.colorScheme.copyWith(
          secondary: secondaryColors,
          brightness: Brightness.dark,
          tertiary: tertiaryColor,
          primary: primaryColor,
        ),
        primarySwatch: Colors.deepPurple,
        // iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(backgroundColor: primaryColor),
      ),
      home: widget,
    );
  }
}
