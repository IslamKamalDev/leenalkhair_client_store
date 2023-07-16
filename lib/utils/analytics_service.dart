import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);


  Future setUserProperties({String? userRole}) async {
    await _analytics.setUserProperty(name: 'user_role', value: userRole);
  }

  Future logLogin(String method) async {
    await _analytics.logLogin(loginMethod: 'Phone : $method');
  }

  Future logSignUp(String method) async {
    await _analytics.logSignUp(signUpMethod: 'Phone : $method');
  }

  Future logSelectedContent(
    String selectedContent,
  ) async {
    await _analytics.logSelectContent(
      contentType: selectedContent,
      itemId: '',
    );
  }
}
