// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i74;
import '../module_about/about_module.dart' as _i72;
import '../module_about/manager/about_manager.dart' as _i36;
import '../module_about/repository/about_repository.dart' as _i22;
import '../module_about/service/about_service/about_service.dart' as _i37;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i58;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i66;
import '../module_auth/authoriazation_module.dart' as _i59;
import '../module_auth/manager/auth_manager.dart' as _i23;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service.dart' as _i24;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i30;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i33;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i42;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i48;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i52;
import '../module_chat/chat_module.dart' as _i67;
import '../module_chat/manager/chat/chat_manager.dart' as _i38;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i25;
import '../module_chat/service/chat/char_service.dart' as _i39;
import '../module_chat/state_manager/chat_state_manager.dart' as _i40;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i60;
import '../module_home/home_module.dart' as _i73;
import '../module_home/manager/home_manager.dart' as _i43;
import '../module_home/repository/home_repository.dart' as _i27;
import '../module_home/sceen/home_screen.dart' as _i68;
import '../module_home/service/home_service.dart' as _i44;
import '../module_home/state_manager/home_state_manager.dart' as _i61;
import '../module_init/init_account_module.dart' as _i69;
import '../module_init/manager/init_account/init_account.manager.dart' as _i45;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i29;
import '../module_init/service/init_account/init_account.service.dart' as _i46;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i47;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i62;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_my_code/my_code_module.dart' as _i19;
import '../module_my_code/ui/screen/my_code_screen.dart' as _i10;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i31;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i41;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_privacy/privacy_module.dart' as _i20;
import '../module_privacy/ui/policies_page/about_page.dart' as _i3;
import '../module_privacy/ui/policies_page/policy_page.dart' as _i12;
import '../module_privacy/ui/policies_page/terms_page.dart' as _i13;
import '../module_profile/manager/profile_manager.dart' as _i49;
import '../module_profile/profile_module.dart' as _i70;
import '../module_profile/repository/profile_repository.dart' as _i32;
import '../module_profile/service/profile_service.dart' as _i50;
import '../module_profile/state_manager/profile_state_manager.dart' as _i51;
import '../module_profile/ui/screen/profile_screen.dart' as _i63;
import '../module_settings/settings_module.dart' as _i64;
import '../module_settings/ui/settings_page/settings_page.dart' as _i53;
import '../module_splash/splash_module.dart' as _i54;
import '../module_splash/ui/screen/splash_screen.dart' as _i34;
import '../module_stores/manager/store_manager.dart' as _i55;
import '../module_stores/repository/store_repository.dart' as _i35;
import '../module_stores/service/store_service.dart' as _i56;
import '../module_stores/state_manager/store_state_manager.dart' as _i57;
import '../module_stores/store_module.dart' as _i71;
import '../module_stores/ui/screen/store_screen.dart' as _i65;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i28;
import '../utils/global/global_state_manager.dart' as _i75;
import '../utils/logger/logger.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutUsPage>(() => _i3.AboutUsPage());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.ChatHiveHelper>(() => _i5.ChatHiveHelper());
  gh.factory<_i6.LocalNotificationService>(
      () => _i6.LocalNotificationService());
  gh.factory<_i7.LocalizationPreferencesHelper>(
      () => _i7.LocalizationPreferencesHelper());
  gh.factory<_i8.LocalizationService>(
      () => _i8.LocalizationService(get<_i7.LocalizationPreferencesHelper>()));
  gh.factory<_i9.Logger>(() => _i9.Logger());
  gh.factory<_i10.MyCodeScreen>(() => _i10.MyCodeScreen());
  gh.factory<_i11.NotificationsPrefsHelper>(
      () => _i11.NotificationsPrefsHelper());
  gh.factory<_i12.PolicyPage>(() => _i12.PolicyPage());
  gh.factory<_i13.TermOfServicePage>(() => _i13.TermOfServicePage());
  gh.factory<_i14.ThemePreferencesHelper>(() => _i14.ThemePreferencesHelper());
  gh.factory<_i15.UploadRepository>(() => _i15.UploadRepository());
  gh.factory<_i16.ApiClient>(() => _i16.ApiClient(get<_i9.Logger>()));
  gh.factory<_i17.AppThemeDataService>(
      () => _i17.AppThemeDataService(get<_i14.ThemePreferencesHelper>()));
  gh.factory<_i18.AuthRepository>(
      () => _i18.AuthRepository(get<_i16.ApiClient>(), get<_i9.Logger>()));
  gh.factory<_i19.MyCodeModule>(
      () => _i19.MyCodeModule(get<_i10.MyCodeScreen>()));
  gh.factory<_i20.PrivacyModule>(() => _i20.PrivacyModule(
      get<_i13.TermOfServicePage>(),
      get<_i12.PolicyPage>(),
      get<_i3.AboutUsPage>()));
  gh.factory<_i21.UploadManager>(
      () => _i21.UploadManager(get<_i15.UploadRepository>()));
  gh.factory<_i22.AboutRepository>(
      () => _i22.AboutRepository(get<_i16.ApiClient>()));
  gh.factory<_i23.AuthManager>(
      () => _i23.AuthManager(get<_i18.AuthRepository>()));
  gh.factory<_i24.AuthService>(() =>
      _i24.AuthService(get<_i4.AuthPrefsHelper>(), get<_i23.AuthManager>()));
  gh.factory<_i25.ChatRepository>(() =>
      _i25.ChatRepository(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i26.ForgotPassStateManager>(
      () => _i26.ForgotPassStateManager(get<_i24.AuthService>()));
  gh.factory<_i27.HomeRepository>(() =>
      _i27.HomeRepository(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i28.ImageUploadService>(
      () => _i28.ImageUploadService(get<_i21.UploadManager>()));
  gh.factory<_i29.InitAccountRepository>(() => _i29.InitAccountRepository(
      get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i30.LoginStateManager>(
      () => _i30.LoginStateManager(get<_i24.AuthService>()));
  gh.factory<_i31.NotificationRepo>(() =>
      _i31.NotificationRepo(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i32.ProfileRepository>(() =>
      _i32.ProfileRepository(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i33.RegisterStateManager>(
      () => _i33.RegisterStateManager(get<_i24.AuthService>()));
  gh.factory<_i34.SplashScreen>(() => _i34.SplashScreen(
      get<_i24.AuthService>(), get<_i8.LocalizationService>()));
  gh.factory<_i35.StoreRepository>(() =>
      _i35.StoreRepository(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i36.AboutManager>(
      () => _i36.AboutManager(get<_i22.AboutRepository>()));
  gh.factory<_i37.AboutService>(
      () => _i37.AboutService(get<_i36.AboutManager>()));
  gh.factory<_i38.ChatManager>(
      () => _i38.ChatManager(get<_i25.ChatRepository>()));
  gh.factory<_i39.ChatService>(() => _i39.ChatService(get<_i38.ChatManager>()));
  gh.factory<_i40.ChatStateManager>(
      () => _i40.ChatStateManager(get<_i39.ChatService>()));
  gh.factory<_i41.FireNotificationService>(() => _i41.FireNotificationService(
      get<_i11.NotificationsPrefsHelper>(), get<_i31.NotificationRepo>()));
  gh.factory<_i42.ForgotPassScreen>(
      () => _i42.ForgotPassScreen(get<_i26.ForgotPassStateManager>()));
  gh.factory<_i43.HomeManager>(
      () => _i43.HomeManager(get<_i27.HomeRepository>()));
  gh.factory<_i44.HomeService>(() => _i44.HomeService(get<_i43.HomeManager>()));
  gh.factory<_i45.InitAccountManager>(
      () => _i45.InitAccountManager(get<_i29.InitAccountRepository>()));
  gh.factory<_i46.InitAccountService>(
      () => _i46.InitAccountService(get<_i45.InitAccountManager>()));
  gh.factory<_i47.InitAccountStateManager>(() => _i47.InitAccountStateManager(
      get<_i46.InitAccountService>(),
      get<_i24.AuthService>(),
      get<_i28.ImageUploadService>()));
  gh.factory<_i48.LoginScreen>(
      () => _i48.LoginScreen(get<_i30.LoginStateManager>()));
  gh.factory<_i49.ProfileManager>(
      () => _i49.ProfileManager(get<_i32.ProfileRepository>()));
  gh.factory<_i50.ProfileService>(
      () => _i50.ProfileService(get<_i49.ProfileManager>()));
  gh.factory<_i51.ProfileStateManager>(() => _i51.ProfileStateManager(
      get<_i50.ProfileService>(),
      get<_i28.ImageUploadService>(),
      get<_i24.AuthService>()));
  gh.factory<_i52.RegisterScreen>(
      () => _i52.RegisterScreen(get<_i33.RegisterStateManager>()));
  gh.factory<_i53.SettingsScreen>(() => _i53.SettingsScreen(
      get<_i24.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i41.FireNotificationService>()));
  gh.factory<_i54.SplashModule>(
      () => _i54.SplashModule(get<_i34.SplashScreen>()));
  gh.factory<_i55.StoreManager>(
      () => _i55.StoreManager(get<_i35.StoreRepository>()));
  gh.factory<_i56.StoreService>(
      () => _i56.StoreService(get<_i55.StoreManager>()));
  gh.factory<_i57.StoreStateManager>(() => _i57.StoreStateManager(
      get<_i56.StoreService>(),
      get<_i28.ImageUploadService>(),
      get<_i24.AuthService>()));
  gh.factory<_i58.AboutScreenStateManager>(
      () => _i58.AboutScreenStateManager(get<_i37.AboutService>()));
  gh.factory<_i59.AuthorizationModule>(() => _i59.AuthorizationModule(
      get<_i48.LoginScreen>(),
      get<_i52.RegisterScreen>(),
      get<_i42.ForgotPassScreen>()));
  gh.factory<_i60.ChatPage>(() => _i60.ChatPage(
      get<_i40.ChatStateManager>(),
      get<_i28.ImageUploadService>(),
      get<_i24.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i61.HomeStateManager>(() => _i61.HomeStateManager(
      get<_i44.HomeService>(), get<_i50.ProfileService>()));
  gh.factory<_i62.InitAccountScreen>(
      () => _i62.InitAccountScreen(get<_i47.InitAccountStateManager>()));
  gh.factory<_i63.ProfileScreen>(
      () => _i63.ProfileScreen(get<_i51.ProfileStateManager>()));
  gh.factory<_i64.SettingsModule>(
      () => _i64.SettingsModule(get<_i53.SettingsScreen>()));
  gh.factory<_i65.StoreScreen>(
      () => _i65.StoreScreen(get<_i57.StoreStateManager>()));
  gh.factory<_i66.AboutScreen>(
      () => _i66.AboutScreen(get<_i58.AboutScreenStateManager>()));
  gh.factory<_i67.ChatModule>(
      () => _i67.ChatModule(get<_i60.ChatPage>(), get<_i24.AuthService>()));
  gh.factory<_i68.HomeScreen>(
      () => _i68.HomeScreen(get<_i61.HomeStateManager>()));
  gh.factory<_i69.InitAccountModule>(
      () => _i69.InitAccountModule(get<_i62.InitAccountScreen>()));
  gh.factory<_i70.ProfileModule>(
      () => _i70.ProfileModule(get<_i63.ProfileScreen>()));
  gh.factory<_i71.StoreModule>(() => _i71.StoreModule(get<_i65.StoreScreen>()));
  gh.factory<_i72.AboutModule>(() => _i72.AboutModule(get<_i66.AboutScreen>()));
  gh.factory<_i73.HomeModule>(() => _i73.HomeModule(get<_i68.HomeScreen>()));
  gh.factory<_i74.MyApp>(() => _i74.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i41.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i54.SplashModule>(),
      get<_i59.AuthorizationModule>(),
      get<_i67.ChatModule>(),
      get<_i64.SettingsModule>(),
      get<_i69.InitAccountModule>(),
      get<_i73.HomeModule>(),
      get<_i72.AboutModule>(),
      get<_i70.ProfileModule>(),
      get<_i19.MyCodeModule>(),
      get<_i71.StoreModule>(),
      get<_i20.PrivacyModule>()));
  gh.singleton<_i75.GlobalStateManager>(_i75.GlobalStateManager());
  return get;
}
