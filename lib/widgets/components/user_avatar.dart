import 'package:flutter/material.dart';
import 'package:onPlay/models/user_profile.dart';

class UserAvatar extends StatelessWidget {
  final UserProfile user;
  final double size;
  const UserAvatar({super.key, required this.user, this.size = 40});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundImage: user.photo != null ? MemoryImage(user.photo!) : null,
        radius: size,
        child: user.photo != null ? null : Icon(Icons.person, size: size * 2));
  }
}
