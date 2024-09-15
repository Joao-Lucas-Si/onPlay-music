import 'package:flutter/material.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';

class PlayerSettingsScreens extends StatelessWidget {
  static const path = "${Config.path}/$route";
  static const route = "player";
  const PlayerSettingsScreens({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
