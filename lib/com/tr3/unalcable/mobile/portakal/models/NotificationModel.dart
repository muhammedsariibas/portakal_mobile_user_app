import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/models/NotificationType.dart';

class NotificationModel {
  late String message;
  late String title;
  late int date;
  late String? notificationType;

  NotificationModel(this.message, this.title, this.date, this.notificationType);

  get getMessage => message;

  set setMessage(message) => this.message = message;

  get getTitle => title;

  set setTitle(title) => this.title = title;

  get getDate => date;

  set setDate(date) => this.date = date;

  get getNotificationType => notificationType;

  set setNotificationType(notificationType) =>
      this.notificationType = notificationType;
}
