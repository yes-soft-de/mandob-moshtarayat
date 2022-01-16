// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i62;
import '../module_about/about_module.dart' as _i60;
import '../module_about/manager/about_manager.dart' as _i29;
import '../module_about/repository/about_repository.dart' as _i16;
import '../module_about/service/about_service/about_service.dart' as _i30;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i48;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i55;
import '../module_auth/authoriazation_module.dart' as _i49;
import '../module_auth/manager/auth_manager.dart' as _i17;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth_repository.dart' as _i14;
import '../module_auth/service/auth_service.dart' as _i18;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i20;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i24;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i27;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i35;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i41;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i45;
import '../module_chat/chat_module.dart' as _i56;
import '../module_chat/manager/chat/chat_manager.dart' as _i31;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i19;
import '../module_chat/service/chat/char_service.dart' as _i32;
import '../module_chat/state_manager/chat_state_manager.dart' as _i33;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i50;
import '../module_home/home_module.dart' as _i61;
import '../module_home/manager/home_manager.dart' as _i36;
import '../module_home/repository/home_repository.dart' as _i21;
import '../module_home/sceen/home_screen.dart' as _i57;
import '../module_home/service/home_service.dart' as _i37;
import '../module_home/state_manager/home_state_manager.dart' as _i51;
import '../module_init/init_account_module.dart' as _i58;
import '../module_init/manager/init_account/init_account.manager.dart' as _i38;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i23;
import '../module_init/service/init_account/init_account.service.dart' as _i39;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i40;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i52;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_network/http_client/http_client.dart' as _i12;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i9;
import '../module_notifications/repository/notification_repo.dart' as _i25;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i34;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_profile/manager/profile_manager.dart' as _i42;
import '../module_profile/profile_module.dart' as _i59;
import '../module_profile/repository/profile_repository.dart' as _i26;
import '../module_profile/service/profile_service.dart' as _i43;
import '../module_profile/state_manager/profile_state_manager.dart' as _i44;
import '../module_profile/ui/screen/profile_screen.dart' as _i53;
import '../module_settings/settings_module.dart' as _i54;
import '../module_settings/ui/settings_page/settings_page.dart' as _i46;
import '../module_splash/splash_module.dart' as _i47;
import '../module_splash/ui/screen/splash_screen.dart' as _i28;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i10;
import '../module_theme/service/theme_service/theme_service.dart' as _i13;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i15;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i11;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i22;
import '../utils/global/global_state_manager.dart' as _i63;
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
  gh.factory<_i16.AboutRepository>(
      () => _i16.AboutRepository(get<_i12.ApiClient>()));
  gh.factory<_i17.AuthManager>(
      () => _i17.AuthManager(get<_i14.AuthRepository>()));
  gh.factory<_i18.AuthService>(() =>
      _i18.AuthService(get<_i3.AuthPrefsHelper>(), get<_i17.AuthManager>()));
  gh.factory<_i19.ChatRepository>(() =>
      _i19.ChatRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i20.ForgotPassStateManager>(
      () => _i20.ForgotPassStateManager(get<_i18.AuthService>()));
  gh.factory<_i21.HomeRepository>(() =>
      _i21.HomeRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i22.ImageUploadService>(
      () => _i22.ImageUploadService(get<_i15.UploadManager>()));
  gh.factory<_i23.InitAccountRepository>(() => _i23.InitAccountRepository(
      get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i24.LoginStateManager>(
      () => _i24.LoginStateManager(get<_i18.AuthService>()));
  gh.factory<_i25.NotificationRepo>(() =>
      _i25.NotificationRepo(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i26.ProfileRepository>(() =>
      _i26.ProfileRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i27.RegisterStateManager>(
      () => _i27.RegisterStateManager(get<_i18.AuthService>()));
  gh.factory<_i28.SplashScreen>(() => _i28.SplashScreen(
      get<_i18.AuthService>(), get<_i7.LocalizationService>()));
  gh.factory<_i29.AboutManager>(
      () => _i29.AboutManager(get<_i16.AboutRepository>()));
  gh.factory<_i30.AboutService>(
      () => _i30.AboutService(get<_i29.AboutManager>()));
  gh.factory<_i31.ChatManager>(
      () => _i31.ChatManager(get<_i19.ChatRepository>()));
  gh.factory<_i32.ChatService>(() => _i32.ChatService(get<_i31.ChatManager>()));
  gh.factory<_i33.ChatStateManager>(
      () => _i33.ChatStateManager(get<_i32.ChatService>()));
  gh.factory<_i34.FireNotificationService>(() => _i34.FireNotificationService(
      get<_i9.NotificationsPrefsHelper>(), get<_i25.NotificationRepo>()));
  gh.factory<_i35.ForgotPassScreen>(
      () => _i35.ForgotPassScreen(get<_i20.ForgotPassStateManager>()));
  gh.factory<_i36.HomeManager>(
      () => _i36.HomeManager(get<_i21.HomeRepository>()));
  gh.factory<_i37.HomeService>(() => _i37.HomeService(get<_i36.HomeManager>()));
  gh.factory<_i38.InitAccountManager>(
      () => _i38.InitAccountManager(get<_i23.InitAccountRepository>()));
  gh.factory<_i39.InitAccountService>(
      () => _i39.InitAccountService(get<_i38.InitAccountManager>()));
  gh.factory<_i40.InitAccountStateManager>(() => _i40.InitAccountStateManager(
      get<_i39.InitAccountService>(),
      get<_i18.AuthService>(),
      get<_i22.ImageUploadService>()));
  gh.factory<_i41.LoginScreen>(
      () => _i41.LoginScreen(get<_i24.LoginStateManager>()));
  gh.factory<_i42.ProfileManager>(
      () => _i42.ProfileManager(get<_i26.ProfileRepository>()));
  gh.factory<_i43.ProfileService>(
      () => _i43.ProfileService(get<_i42.ProfileManager>()));
  gh.factory<_i44.ProfileStateManager>(() => _i44.ProfileStateManager(
      get<_i43.ProfileService>(),
      get<_i22.ImageUploadService>(),
      get<_i18.AuthService>()));
  gh.factory<_i45.RegisterScreen>(
      () => _i45.RegisterScreen(get<_i27.RegisterStateManager>()));
  gh.factory<_i46.SettingsScreen>(() => _i46.SettingsScreen(
      get<_i18.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i13.AppThemeDataService>(),
      get<_i34.FireNotificationService>()));
  gh.factory<_i47.SplashModule>(
      () => _i47.SplashModule(get<_i28.SplashScreen>()));
  gh.factory<_i48.AboutScreenStateManager>(
      () => _i48.AboutScreenStateManager(get<_i30.AboutService>()));
  gh.factory<_i49.AuthorizationModule>(() => _i49.AuthorizationModule(
      get<_i41.LoginScreen>(),
      get<_i45.RegisterScreen>(),
      get<_i35.ForgotPassScreen>()));
  gh.factory<_i50.ChatPage>(() => _i50.ChatPage(
      get<_i33.ChatStateManager>(),
      get<_i22.ImageUploadService>(),
      get<_i18.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i51.HomeStateManager>(() => _i51.HomeStateManager(
      get<_i37.HomeService>(), get<_i43.ProfileService>()));
  gh.factory<_i52.InitAccountScreen>(
      () => _i52.InitAccountScreen(get<_i40.InitAccountStateManager>()));
  gh.factory<_i53.ProfileScreen>(
      () => _i53.ProfileScreen(get<_i44.ProfileStateManager>()));
  gh.factory<_i54.SettingsModule>(
      () => _i54.SettingsModule(get<_i46.SettingsScreen>()));
  gh.factory<_i55.AboutScreen>(
      () => _i55.AboutScreen(get<_i48.AboutScreenStateManager>()));
  gh.factory<_i56.ChatModule>(
      () => _i56.ChatModule(get<_i50.ChatPage>(), get<_i18.AuthService>()));
  gh.factory<_i57.HomeScreen>(
      () => _i57.HomeScreen(get<_i51.HomeStateManager>()));
  gh.factory<_i58.InitAccountModule>(
      () => _i58.InitAccountModule(get<_i52.InitAccountScreen>()));
  gh.factory<_i59.ProfileModule>(
      () => _i59.ProfileModule(get<_i53.ProfileScreen>()));
  gh.factory<_i60.AboutModule>(() => _i60.AboutModule(get<_i55.AboutScreen>()));
  gh.factory<_i61.HomeModule>(() => _i61.HomeModule(get<_i57.HomeScreen>()));
  gh.factory<_i62.MyApp>(() => _i62.MyApp(
      get<_i13.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i34.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i47.SplashModule>(),
      get<_i49.AuthorizationModule>(),
      get<_i56.ChatModule>(),
      get<_i54.SettingsModule>(),
      get<_i58.InitAccountModule>(),
      get<_i61.HomeModule>(),
      get<_i60.AboutModule>(),
      get<_i59.ProfileModule>()));
  gh.singleton<_i63.GlobalStateManager>(_i63.GlobalStateManager());
  return get;
}
