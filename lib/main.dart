import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/config/router.dart';
import 'package:onPlay/localModels/Settings.dart';
import 'package:onPlay/models/managers/box_manager.dart';
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

    final primaryColor =
        settings.interface.colorSchemeType == ColorSchemeType.totalMusicColor
            ? colorStore.dominantColor ?? Colors.grey[900]
            : Colors.grey[900];
    final secondaryColors =
        settings.interface.colorSchemeType == ColorSchemeType.totalMusicColor
            ? colorStore.lightColor ?? Colors.deepPurpleAccent
            : Colors.deepPurpleAccent;

    final tertiaryColor =
        settings.interface.colorSchemeType == ColorSchemeType.totalMusicColor
            ? colorStore.darkColor ?? Colors.grey[500]
            : Colors.grey[500];
    return MaterialApp(
      title: 'onPlay',
      theme: ThemeData(
        colorScheme: theme.colorScheme.copyWith(
          secondary: secondaryColors,
          tertiary: tertiaryColor,
          primary: primaryColor,
        ),

        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(primaryColor),
                textStyle: WidgetStateProperty.all(
                    TextStyle(color: secondaryColors)))),
        inputDecorationTheme: InputDecorationTheme(
            focusColor: primaryColor,
            labelStyle: TextStyle(color: secondaryColors)),
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(),
        // iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
        ),
      ),
      home: widget,
    );
  }
}
