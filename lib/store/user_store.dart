import 'package:flutter/material.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/managers/user_manager.dart';
import 'package:onPlay/models/user_profile.dart';
import 'package:provider/provider.dart';

class UserStore extends ChangeNotifier {
  late final UserManager _manager;
  UserProfile _user = UserProfile(name: "User");
  List<UserProfile> _profiles = [];

  List<UserProfile> get profiles => _profiles;

  UserProfile get user => _user;

  UserStore(BuildContext context) {
    final managers = context.read<BoxManager>();
    _manager = managers.userManager;
    init();
  }

  init() async {
    _user = _manager.getActiveProfile();
    _profiles = _manager.getAll();
    notifyListeners();
  }

  void saveUser(UserProfile user) {
    _manager.save(user);

    _profiles = _manager.getAll();
    _user = _manager.getActiveProfile();
    notifyListeners();
  }

  void changeProfile(UserProfile user) async {
    _user.current = false;
    user.current = true;
    _manager.saveAll([_user, user]);
    _user = user;
    notifyListeners();
  }
}
