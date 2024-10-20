import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/widgets/pages/settings/about.dart';
import 'package:onPlay/widgets/pages/settings/files.dart';
import 'package:onPlay/widgets/pages/settings/interface.dart';
import 'package:onPlay/widgets/pages/settings/layout.dart';
import 'package:onPlay/widgets/pages/settings/player.dart';
import 'package:onPlay/widgets/pages/settings/share.dart';

class Config extends StatefulWidget {
  static const path = "/settings";
  const Config({super.key});
  @override
  createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(children: [
        Text(
          "config",
          style: TextStyle(
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
        _ConfigCategory(
            icon: Icons.layers,
            title: "layout",
            path: LayoutSettingsScreen.path),
        _ConfigCategory(
            icon: Icons.visibility,
            title: "interface",
            path: InterfaceSettingsScreen.path),
        _ConfigCategory(
            icon: Icons.gamepad,
            title: "player",
            path: PlayerSettingsScreens.path),
        _ConfigCategory(
            icon: Icons.file_copy,
            title: "arquivos",
            path: FilesSettingsScreen.path),
        _ConfigCategory(icon: Icons.info, title: "sobre", path: About.path),
        _ConfigCategory(
            icon: Icons.share,
            title: "compartilhamento e conexão",
            path: ShareSettingsScreen.path),
      ]),
    );
  }
}

class _ConfigCategory extends StatelessWidget {
  final String title;
  final String path;
  final IconData icon;
  const _ConfigCategory(
      {super.key, required this.title, required this.path, required this.icon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(path);
      },
      child: Card(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                Icon(
                  icon,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                )
              ]))),
    );
  }
}
