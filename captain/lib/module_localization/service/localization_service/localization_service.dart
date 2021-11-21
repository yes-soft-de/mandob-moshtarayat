import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_captain/module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart';

@injectable
@singleton
class LocalizationService {
  static final PublishSubject<String> _localizationSubject =
      PublishSubject<String>();
  Stream<String> get localizationStream => _localizationSubject.stream;
  final LocalizationPreferencesHelper _preferencesHelper;
  LocalizationService(this._preferencesHelper);

  void setLanguage(String lang) {
    _preferencesHelper.setLanguage(lang);
    _localizationSubject.add(lang);
  }

  String getLanguage() {
    String? lang = _preferencesHelper.getLanguage();
    lang ??= Platform.localeName.substring(0, 2);
    return lang;
  }

  void dispose() {
    _localizationSubject.close();
  }
}
