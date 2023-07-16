
import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getDeviceToken() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  print("device token : ${await _firebaseMessaging.getToken()}");
  return await _firebaseMessaging.getToken();
}
