import 'package:flutter/material.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';

class FilesSettingsScreen extends StatelessWidget {
  static const route = "files";
  static const path = "${Config.path}/$route";

  const FilesSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(),
    );
  }
}
