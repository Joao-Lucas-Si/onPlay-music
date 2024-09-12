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
    if (user == null) {
      return const Text("carregando");
    } else {
      final user = this.user!;
      return Column(children: [
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
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push("/user");
          },
          child: Row(
            children: [
              user.image != null
                  ? Image.memory(
                      user.image!,
                      width: 100,
                      height: 100,
                    )
                  : const Icon(Icons.person, size: 100),
              Text(user.name ?? "user")
            ],
          ),
        )
      ]);
    }
  }
}
