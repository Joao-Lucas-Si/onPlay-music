import 'package:onPlay/database/objectbox.g.dart';
import 'package:onPlay/models/managers/base_manager.dart';
import 'package:onPlay/models/settings/settings.dart';
import 'package:onPlay/models/user_profile.dart';

class UserManager extends BaseManager<UserProfile> {
  UserManager(super.box);

  UserProfile getActiveProfile() {
    var activeUser =
        box.query(UserProfile_.current.equals(true)).build().findFirst();
    if (activeUser == null) {
      final user = UserProfile(name: "user", current: true);
      final settings = DatabaseSettings(recentRange: 30);
      user.settings.target = settings;

      save(user);
      activeUser = user;
    }
    return activeUser;
  }
}
