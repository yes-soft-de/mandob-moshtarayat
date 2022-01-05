import 'dart:io' as plat;
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
    getIt<AuthService>().updateCategoryFavorite(true);
  }

  String getLanguage() {
    String? lang = _preferencesHelper.getLanguage();
    if (kIsWeb) {
      lang ??= 'en';
    } else {
      lang ??= plat.Platform.localeName.substring(0, 2);
    }
    return lang;
  }

  bool choosed() {
    String? lang = _preferencesHelper.getLanguage();
    return lang != null;
  }

  void dispose() {
    _localizationSubject.close();
  }
}
