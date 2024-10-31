import 'package:flutter/material.dart';
import 'package:onPlay/store/settings.dart';
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
  final urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text("Link da extensão"),
          SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: TextFormField(
                      controller: urlController,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      debugPrint(urlController.text);
                      settings.share.addEditorUrl(urlController.text);
                      urlController.text = "";
                    },
                    child: const Icon(Icons.add),
                  )
                ],
              )),
          SizedBox(
            height: 200,
            child: ListView(
              children:
                  settings.share.editorUrls.map((url) => Text(url)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
