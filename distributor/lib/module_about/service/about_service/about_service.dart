import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mandob_moshtarayat/module_about/manager/about_manager.dart';

@injectable
class AboutService {
  final AboutManager _manager;
  AboutService(this._manager);

  var box = Hive.box('Init');

  bool isInitialized()  {
    return box.get('Initialized')??false;
  }

  void setInitialized() {
    box.put('Initialized', true);
  }

}