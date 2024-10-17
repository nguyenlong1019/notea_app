// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:note_app/models/note.dart';

// class NoteService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   Future<void> scheduleNotification(Note note) async {
//     var scheduledTime = note.schedule;
//     if (scheduledTime != null) {
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         0, // Notification ID
//         note.title, // Notification title
//         note.description, // Notification content
//         scheduledTime, // Scheduled time
//         const NotificationDetails(
//             android: AndroidNotificationDetails('your_channel_id', 'your_channel_name', 'your_channel_description')),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       );
//     }
//   }
// }