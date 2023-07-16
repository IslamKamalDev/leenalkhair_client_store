/*
import 'Constants.dart';
import 'PreferenceManger.dart';

class SettingsSession {

  static Future<void> loadLanguage() async {
    await PreferenceManager.getInstance()!
        .getString(Constants.languageCode)
        .then((value) {
      if (value == null || value.isEmpty) {
        PreferenceManager.getInstance()!
            .saveString(Constants.languageCode, 'ar');
        _languageCode = 'ar';
      } else {
        _languageCode = value;
      }
    });
  }


}
*/
