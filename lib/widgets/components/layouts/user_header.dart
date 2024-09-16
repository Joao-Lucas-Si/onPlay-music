import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/localModels/User.dart';

class UserHeader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserHeaderState();
  }
}

class _UserHeaderState extends State<UserHeader> {
  UserModel? user;
  @override
  void initState() {
    super.initState();
    UserModel.colect().then(
      (value) {
        setState(() {
          user = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    if (user == null) {
      return const Text("carregando");
    } else {
      final user = this.user!;
      return Stack(children: [
        user.banner != null
            ? Image.memory(
                user.banner!,
                width: double.maxFinite,
                fit: BoxFit.cover,
                height: 150,
              )
            : Image.asset(
                "assets/placeholder-banner.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
                height: 150,
              ),
        Positioned(
            left: 5,
            bottom: 5,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push("/user");
              },
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        user.image != null ? MemoryImage(user.image!) : null,
                    radius: 40,
                    child: user.image != null
                        ? null
                        : const Icon(Icons.person, size: 80),
                  ),
                  Text(
                    user.name?.trim() == "" ? "user" : user.name ?? "user",
                    style: TextStyle(
                      backgroundColor: colorSchema.primary,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            )),
      ]);
    }
  }
}
