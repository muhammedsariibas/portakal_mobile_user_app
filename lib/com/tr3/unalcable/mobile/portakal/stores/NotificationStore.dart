import 'package:portakal_mobile_user_app/com/tr3/unalcable/mobile/portakal/models/NotificationModel.dart';

class Store {
  List<NotificationModel> notifications = List.empty(growable: true);
  List<Function> observers = List.empty(growable: true);

  Store() {
    print("Store initiaated");
  }

  void add(NotificationModel notification) {
    try {
      notifications.add(notification);

      for (var observer in observers) {
        observer(notification);
      }
    } catch (err) {}
  }

  void subscribe(Function function) {
    observers.add(function);
  }

  // oberserver pattern
}

var notificationStore = new Store();
