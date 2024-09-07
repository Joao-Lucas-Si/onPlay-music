import 'package:flutter/material.dart';

class Config extends StatefulWidget {
  @override
  createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [Text("config")]),
    );
  }
}
