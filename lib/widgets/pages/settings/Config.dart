import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Config extends StatefulWidget {
  @override
  createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Text("config"),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push("/settings/about");
          },
          child: Text("Sobre"),
        )
      ]),
    );
  }
}
