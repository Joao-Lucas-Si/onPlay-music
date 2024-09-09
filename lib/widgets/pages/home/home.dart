import 'package:flutter/material.dart';
import 'package:onPlay/widgets/components/layouts/user_header.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [UserHeader()],
    ));
  }
}
