import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/widgets/components/user_avatar.dart';
import 'package:provider/provider.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});
 
  @override
  Widget build(BuildContext context) {
    final managers = Provider.of<BoxManager>(context, listen: false);

    final userManager = managers.userManager;

    final user = userManager.getActiveProfile();

    final colorSchema = Theme.of(context).colorScheme;

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
                UserAvatar(user: user),
                Text(
                  user.name,
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
