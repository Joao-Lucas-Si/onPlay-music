import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:onPlay/config/app_theme.dart';
import 'package:onPlay/config/providers.dart';
import 'package:onPlay/config/router.dart';

void main() {
  MetadataGod.initialize();
  runApp(const Providers(app: App()));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) =>
          child != null ? AppTheme(child: child) : const Text("not found"),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
