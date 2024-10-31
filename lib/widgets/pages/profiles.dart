import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/store/settings.dart';
import 'package:onPlay/widgets/components/user_avatar.dart';
import 'package:provider/provider.dart';

class ProfilesPage extends StatelessWidget {
  static const path = "/profiles";

  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final managers = Provider.of<BoxManager>(context);

    final userManager = managers.userManager;

    final users = userManager.getAll();

    final settings = Provider.of<Settings>(context);

    return Scaffold(
      body: PageView(
        controller: PageController(
            initialPage: users.indexWhere((user) => user.current),
            viewportFraction: .75),
        children: users
            .map(
              (user) => Stack(
                children: [
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      UserAvatar(
                        user: user,
                        size: 130,
                      ),
                      Text(
                        user.name,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ]),
                  )),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 50, left: 50, right: 50),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          if (!user.current) {
                                            final activeUser =
                                                userManager.getActiveProfile();
                                            activeUser.current = false;
                                            user.current = true;
                                            userManager
                                                .saveAll([activeUser, user]);
                                            settings.reload();

                                            GoRouter.of(context)
                                                .pop(UniqueKey());
                                            //GoRouter.of(context).refresh();
                                          } else {
                                            GoRouter.of(context).pop();
                                          }
                                        },
                                        child: Text(
                                          user.current
                                              ? "continuar usando"
                                              : "usar",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          GoRouter.of(context)
                                              .push("/user", extra: true);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "adicionar novo perfil",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            )
                                          ],
                                        ))
                                  ]))))
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
