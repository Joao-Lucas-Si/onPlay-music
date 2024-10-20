import 'package:flutter/material.dart';
import 'package:onPlay/localModels/settings/settings.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';
import 'package:provider/provider.dart';

class ShareSettingsScreen extends StatefulWidget {
  static const path = "${Config.path}/$route";
  static const route = "share";
  const ShareSettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShareSettingsScreen();
  }
}

class _ShareSettingsScreen extends State<ShareSettingsScreen> {
//6900-idx-icons-v-1729204082859.cluster-qhrn7lb3szcfcud6uanedbkjnm.cloudworkstations.dev
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Link da extensão"),
          TextFormField(
            initialValue: settings.share.editorUrl,
            onChanged: (valor) {
              debugPrint(valor);
              settings.share.editorUrl = valor;
            },
          )
        ],
      ),
    );
  }
}
