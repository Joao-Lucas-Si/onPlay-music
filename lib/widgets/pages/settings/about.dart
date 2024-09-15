import 'package:flutter/material.dart';
import 'package:onPlay/widgets/pages/settings/Config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class About extends StatelessWidget {
  static const path = "${Config.path}/$route";
  static const route = "about";

  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sobre"),
        ),
        body: FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "OnPlay",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40, color: Theme.of(context).primaryColor),
                    ),
                    const Text("Desenvolvido por: João Lucas Silva Lopes",
                        textAlign: TextAlign.center),
                    Text(snapshot.data?.version ?? "1.0.0",
                        textAlign: TextAlign.center)
                  ],
                )));
  }
}
