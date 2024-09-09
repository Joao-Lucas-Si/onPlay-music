import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/User.dart';

class UserHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserModel.colect(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("carregando");
        } else {
          final user = snapshot.data!;
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
      },
    );
  }
}
