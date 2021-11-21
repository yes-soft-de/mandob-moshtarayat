import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ReportPrefsHelper {
  Future<void> setUUId(String? uuId,String orderId) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.setString('uuIdReport$orderId', uuId!);
    return;
  }

  Future<String?> getUUId(String orderId) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('uuIdReport$orderId');
  }
}
