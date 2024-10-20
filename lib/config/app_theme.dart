import 'package:flutter/material.dart';
import 'package:onPlay/constants/themes/purple.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/services/http/services/editor_color_service.dart';
import 'package:onPlay/store/player_store.dart';
import 'package:provider/provider.dart';

class AppTheme extends StatefulWidget {
  final Widget child;

  const AppTheme({super.key, required this.child});
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<AppTheme> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final editorColorService = EditorColorService(settings);
    final playerStore = Provider.of<PlayerStore>(context);
    final song = playerStore.playingSong;
    final colors = song?.currentColors(
        settings.interface.colorPalette, settings.interface.colorTheme);
    final primaryColor = (colors?.background ?? purpleTheme.background);
    final secondaryColors = colors?.text ?? purpleTheme.text;
    final tertiaryColor = colors?.other ?? purpleTheme.other;

    return MaterialApp(
      title: 'onPlay',
      theme: ThemeData(
        colorScheme: ColorScheme(
          onSecondary: tertiaryColor,
          error: Colors.red,
          onError: Colors.red,
          surface: const Color(0xFF212121),
          onSurface: Colors.white,
          secondary: secondaryColors,
          tertiary: tertiaryColor,
          onPrimary: secondaryColors,
          primary: primaryColor,
          brightness: Brightness.dark,
        ),

        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(primaryColor),
                textStyle: WidgetStateProperty.all(
                    TextStyle(color: secondaryColors)))),
        inputDecorationTheme: InputDecorationTheme(
            focusColor: primaryColor,
            labelStyle: TextStyle(color: secondaryColors)),
        // iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: secondaryColors),
            backgroundColor: primaryColor,
            titleTextStyle: TextStyle(color: secondaryColors, fontSize: 20),
            surfaceTintColor: secondaryColors),
      ),
      home: widget.child,
    );
  }
}
