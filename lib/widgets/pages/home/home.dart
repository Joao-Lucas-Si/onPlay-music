import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/widgets/components/layouts/user_header.dart';
import 'package:onPlay/widgets/pages/home/recent.dart';

class Home extends StatelessWidget {
  static const path = "/home";
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        body: Column(
      children: [
        UserHeader(),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 200,
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Wrap(
                spacing: 20,
                children: [
                  GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(Recents.path);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          width: (size.width * 0.5) - 20 - 20,
                          child: Text(
                            "recentes",
                            style: TextStyle(color: colorScheme.secondary),
                          ))),
                  GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(Recents.path);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          width: (size.width * 0.5) - 20 - 20,
                          child: Text(
                            "histórico",
                            style: TextStyle(color: colorScheme.secondary),
                          ))),
                ],
              )),
        )
      ],
    ));
  }
}
