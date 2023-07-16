import 'package:rxdart/rxdart.dart';

class LocalNotification {
  final String type;
  final String msg;

  LocalNotification(this.type, this.msg);
}

class OrderNotification {
  bool orderStatus;
  OrderNotification(this.orderStatus);
}

class NotificationsBloc {
  NotificationsBloc._internal();

  static final NotificationsBloc instance = NotificationsBloc._internal();

  final BehaviorSubject<LocalNotification> _notificationsStreamController =
      BehaviorSubject<LocalNotification>();

  final BehaviorSubject<OrderNotification> _orderNotificationsStreamController =
      BehaviorSubject<OrderNotification>();

  Stream<LocalNotification> get notificationsStream {
    return _notificationsStreamController;
  }

  Stream<OrderNotification> get orderNotificationsStream {
    return _orderNotificationsStreamController;
  }

  void newNotification(LocalNotification notification) {
    _notificationsStreamController.sink.add(notification);
  }

  void newOrderNotification(OrderNotification notification) {
    _orderNotificationsStreamController.sink.add(notification);
  }

  void dispose() {
    _notificationsStreamController.close();
    _orderNotificationsStreamController.close();
  }
}
