// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i36;
import '../module_auth/authoriazation_module.dart' as _i32;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i16;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i14;
import '../module_auth/service/auth_service/auth_service.dart' as _i17;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i20;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i22;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i28;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i29;
import '../module_chat/chat_module.dart' as _i35;
import '../module_chat/manager/chat/chat_manager.dart' as _i24;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i18;
import '../module_chat/service/chat/char_service.dart' as _i25;
import '../module_chat/state_manager/chat_state_manager.dart' as _i26;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i33;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_network/http_client/http_client.dart' as _i12;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i9;
import '../module_notifications/repository/notification_repo.dart' as _i21;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i27;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_settings/settings_module.dart' as _i34;
import '../module_settings/ui/settings_page/settings_page.dart' as _i30;
import '../module_splash/splash_module.dart' as _i31;
import '../module_splash/ui/screen/splash_screen.dart' as _i23;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i10;
import '../module_theme/service/theme_service/theme_service.dart' as _i13;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i15;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i11;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i19;
import '../utils/global/global_state_manager.dart' as _i37;
import '../utils/logger/logger.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.ChatHiveHelper>(() => _i4.ChatHiveHelper());
  gh.factory<_i5.LocalNotificationService>(
      () => _i5.LocalNotificationService());
  gh.factory<_i6.LocalizationPreferencesHelper>(
      () => _i6.LocalizationPreferencesHelper());
  gh.factory<_i7.LocalizationService>(
      () => _i7.LocalizationService(get<_i6.LocalizationPreferencesHelper>()));
  gh.factory<_i8.Logger>(() => _i8.Logger());
  gh.factory<_i9.NotificationsPrefsHelper>(
      () => _i9.NotificationsPrefsHelper());
  gh.factory<_i10.ThemePreferencesHelper>(() => _i10.ThemePreferencesHelper());
  gh.factory<_i11.UploadRepository>(() => _i11.UploadRepository());
  gh.factory<_i12.ApiClient>(() => _i12.ApiClient(get<_i8.Logger>()));
  gh.factory<_i13.AppThemeDataService>(
      () => _i13.AppThemeDataService(get<_i10.ThemePreferencesHelper>()));
  gh.factory<_i14.AuthRepository>(
      () => _i14.AuthRepository(get<_i12.ApiClient>(), get<_i8.Logger>()));
  gh.factory<_i15.UploadManager>(
      () => _i15.UploadManager(get<_i11.UploadRepository>()));
  gh.factory<_i16.AuthManager>(
      () => _i16.AuthManager(get<_i14.AuthRepository>()));
  gh.factory<_i17.AuthService>(() =>
      _i17.AuthService(get<_i3.AuthPrefsHelper>(), get<_i16.AuthManager>()));
  gh.factory<_i18.ChatRepository>(() =>
      _i18.ChatRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i19.ImageUploadService>(
      () => _i19.ImageUploadService(get<_i15.UploadManager>()));
  gh.factory<_i20.LoginStateManager>(
      () => _i20.LoginStateManager(get<_i17.AuthService>()));
  gh.factory<_i21.NotificationRepo>(() =>
      _i21.NotificationRepo(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i22.RegisterStateManager>(
      () => _i22.RegisterStateManager(get<_i17.AuthService>()));
  gh.factory<_i23.SplashScreen>(
      () => _i23.SplashScreen(get<_i17.AuthService>()));
  gh.factory<_i24.ChatManager>(
      () => _i24.ChatManager(get<_i18.ChatRepository>()));
  gh.factory<_i25.ChatService>(() => _i25.ChatService(get<_i24.ChatManager>()));
  gh.factory<_i26.ChatStateManager>(
      () => _i26.ChatStateManager(get<_i25.ChatService>()));
  gh.factory<_i27.FireNotificationService>(() => _i27.FireNotificationService(
      get<_i9.NotificationsPrefsHelper>(), get<_i21.NotificationRepo>()));
  gh.factory<_i28.LoginScreen>(
      () => _i28.LoginScreen(get<_i20.LoginStateManager>()));
  gh.factory<_i29.RegisterScreen>(
      () => _i29.RegisterScreen(get<_i22.RegisterStateManager>()));
  gh.factory<_i30.SettingsScreen>(() => _i30.SettingsScreen(
      get<_i17.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i13.AppThemeDataService>(),
      get<_i27.FireNotificationService>()));
  gh.factory<_i31.SplashModule>(
      () => _i31.SplashModule(get<_i23.SplashScreen>()));
  gh.factory<_i32.AuthorizationModule>(() => _i32.AuthorizationModule(
      get<_i28.LoginScreen>(), get<_i29.RegisterScreen>()));
  gh.factory<_i33.ChatPage>(() => _i33.ChatPage(
      get<_i26.ChatStateManager>(),
      get<_i19.ImageUploadService>(),
      get<_i17.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i34.SettingsModule>(
      () => _i34.SettingsModule(get<_i30.SettingsScreen>()));
  gh.factory<_i35.ChatModule>(
      () => _i35.ChatModule(get<_i33.ChatPage>(), get<_i17.AuthService>()));
  gh.factory<_i36.MyApp>(() => _i36.MyApp(
      get<_i13.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i27.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i31.SplashModule>(),
      get<_i32.AuthorizationModule>(),
      get<_i35.ChatModule>(),
      get<_i34.SettingsModule>()));
  gh.singleton<_i37.GlobalStateManager>(_i37.GlobalStateManager());
  return get;
}
