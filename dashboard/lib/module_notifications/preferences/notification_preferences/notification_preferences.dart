import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class NotificationsPrefHelper {
  Future<void> setIsActive(bool active) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('captain_active', active);
  }

  Future<bool?> getIsActive() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool('captain_active');
  }
}
