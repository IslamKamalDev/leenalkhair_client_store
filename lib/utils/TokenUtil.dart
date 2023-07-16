import 'Constants.dart';
import 'PreferenceManger.dart';

class TokenUtil {
  static String? _token = '';

  static Future<void> loadTokenToMemory() async {
    _token = await PreferenceManager.getInstance()!.getString(Constants.token);
  }

  static String? getTokenFromMemory() {
    return _token;
  }

  static Future<void> saveToken(String token) async {
    await PreferenceManager.getInstance()!.saveString(Constants.token, token);
    await loadTokenToMemory();
  }

  static void clearToken() {
    PreferenceManager.getInstance()!.remove(Constants.token);
    _token = '';
  }
}
