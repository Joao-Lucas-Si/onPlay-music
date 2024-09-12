import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onPlay/models/song.dart';

class NotificationService {
  final plugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initNotifications();
  }

  _initNotifications() async {
    const androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    await plugin.initialize(
        const InitializationSettings(android: androidSettings),
        onDidReceiveNotificationResponse: (details) {});
  }

  setPlayerNotification(Song song) {
    const details = AndroidNotificationDetails("player", "music player",
        ongoing: true, priority: Priority.max, importance: Importance.max);
    // plugin.show(1, "music", song.title ?? "music",
    //     const NotificationDetails(android: details));
  }

  close() {
    // plugin.cancel(1);
  }
}
