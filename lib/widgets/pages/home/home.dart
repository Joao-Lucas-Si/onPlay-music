import 'package:flutter/material.dart';
import 'package:onPlay/widgets/components/layouts/user_header.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [UserHeader()],
    ));
  }
}
