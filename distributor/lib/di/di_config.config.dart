// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i80;
import '../module_about/about_module.dart' as _i78;
import '../module_about/manager/about_manager.dart' as _i37;
import '../module_about/repository/about_repository.dart' as _i22;
import '../module_about/service/about_service/about_service.dart' as _i38;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i62;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i71;
import '../module_auth/authoriazation_module.dart' as _i63;
import '../module_auth/manager/auth_manager.dart' as _i23;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service.dart' as _i24;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i31;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i34;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i46;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i52;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i56;
import '../module_balance/balance_module.dart' as _i72;
import '../module_balance/manager/balance_manager.dart' as _i39;
import '../module_balance/repository/balance_repository.dart' as _i25;
import '../module_balance/service/balance_service.dart' as _i40;
import '../module_balance/state_manager/balance_state_manager.dart' as _i41;
import '../module_balance/ui/screen/balance_screen.dart' as _i64;
import '../module_chat/chat_module.dart' as _i73;
import '../module_chat/manager/chat/chat_manager.dart' as _i42;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i26;
import '../module_chat/service/chat/char_service.dart' as _i43;
import '../module_chat/state_manager/chat_state_manager.dart' as _i44;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i65;
import '../module_home/home_module.dart' as _i79;
import '../module_home/manager/home_manager.dart' as _i47;
import '../module_home/repository/home_repository.dart' as _i28;
import '../module_home/sceen/home_screen.dart' as _i74;
import '../module_home/service/home_service.dart' as _i48;
import '../module_home/state_manager/home_state_manager.dart' as _i66;
import '../module_init/init_account_module.dart' as _i75;
import '../module_init/manager/init_account/init_account.manager.dart' as _i49;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i30;
import '../module_init/service/init_account/init_account.service.dart' as _i50;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i51;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i67;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_my_code/my_code_module.dart' as _i19;
import '../module_my_code/ui/screen/my_code_screen.dart' as _i10;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i32;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i45;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_privacy/privacy_module.dart' as _i20;
import '../module_privacy/ui/policies_page/about_page.dart' as _i3;
import '../module_privacy/ui/policies_page/policy_page.dart' as _i12;
import '../module_privacy/ui/policies_page/terms_page.dart' as _i13;
import '../module_profile/manager/profile_manager.dart' as _i53;
import '../module_profile/profile_module.dart' as _i76;
import '../module_profile/repository/profile_repository.dart' as _i33;
import '../module_profile/service/profile_service.dart' as _i54;
import '../module_profile/state_manager/profile_state_manager.dart' as _i55;
import '../module_profile/ui/screen/profile_screen.dart' as _i68;
import '../module_settings/settings_module.dart' as _i69;
import '../module_settings/ui/settings_page/settings_page.dart' as _i57;
import '../module_splash/splash_module.dart' as _i58;
import '../module_splash/ui/screen/splash_screen.dart' as _i35;
import '../module_stores/manager/store_manager.dart' as _i59;
import '../module_stores/repository/store_repository.dart' as _i36;
import '../module_stores/service/store_service.dart' as _i60;
import '../module_stores/state_manager/store_state_manager.dart' as _i61;
import '../module_stores/store_module.dart' as _i77;
import '../module_stores/ui/screen/store_screen.dart' as _i70;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i29;
import '../utils/global/global_state_manager.dart' as _i81;
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
  gh.factory<_i25.BalanceRepository>(() =>
      _i25.BalanceRepository(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i26.ChatRepository>(() =>
      _i26.ChatRepository(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i27.ForgotPassStateManager>(
      () => _i27.ForgotPassStateManager(get<_i24.AuthService>()));
  gh.factory<_i28.HomeRepository>(() =>
      _i28.HomeRepository(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i29.ImageUploadService>(
      () => _i29.ImageUploadService(get<_i21.UploadManager>()));
  gh.factory<_i30.InitAccountRepository>(() => _i30.InitAccountRepository(
      get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i31.LoginStateManager>(
      () => _i31.LoginStateManager(get<_i24.AuthService>()));
  gh.factory<_i32.NotificationRepo>(() =>
      _i32.NotificationRepo(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i33.ProfileRepository>(() =>
      _i33.ProfileRepository(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i34.RegisterStateManager>(
      () => _i34.RegisterStateManager(get<_i24.AuthService>()));
  gh.factory<_i35.SplashScreen>(() => _i35.SplashScreen(
      get<_i24.AuthService>(), get<_i8.LocalizationService>()));
  gh.factory<_i36.StoreRepository>(() =>
      _i36.StoreRepository(get<_i16.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i37.AboutManager>(
      () => _i37.AboutManager(get<_i22.AboutRepository>()));
  gh.factory<_i38.AboutService>(
      () => _i38.AboutService(get<_i37.AboutManager>()));
  gh.factory<_i39.BalanceManager>(
      () => _i39.BalanceManager(get<_i25.BalanceRepository>()));
  gh.factory<_i40.BalanceService>(
      () => _i40.BalanceService(get<_i39.BalanceManager>()));
  gh.factory<_i41.BalanceStateManager>(() => _i41.BalanceStateManager(
      get<_i40.BalanceService>(),
      get<_i29.ImageUploadService>(),
      get<_i24.AuthService>()));
  gh.factory<_i42.ChatManager>(
      () => _i42.ChatManager(get<_i26.ChatRepository>()));
  gh.factory<_i43.ChatService>(() => _i43.ChatService(get<_i42.ChatManager>()));
  gh.factory<_i44.ChatStateManager>(
      () => _i44.ChatStateManager(get<_i43.ChatService>()));
  gh.factory<_i45.FireNotificationService>(() => _i45.FireNotificationService(
      get<_i11.NotificationsPrefsHelper>(), get<_i32.NotificationRepo>()));
  gh.factory<_i46.ForgotPassScreen>(
      () => _i46.ForgotPassScreen(get<_i27.ForgotPassStateManager>()));
  gh.factory<_i47.HomeManager>(
      () => _i47.HomeManager(get<_i28.HomeRepository>()));
  gh.factory<_i48.HomeService>(() => _i48.HomeService(get<_i47.HomeManager>()));
  gh.factory<_i49.InitAccountManager>(
      () => _i49.InitAccountManager(get<_i30.InitAccountRepository>()));
  gh.factory<_i50.InitAccountService>(
      () => _i50.InitAccountService(get<_i49.InitAccountManager>()));
  gh.factory<_i51.InitAccountStateManager>(() => _i51.InitAccountStateManager(
      get<_i50.InitAccountService>(),
      get<_i24.AuthService>(),
      get<_i29.ImageUploadService>()));
  gh.factory<_i52.LoginScreen>(
      () => _i52.LoginScreen(get<_i31.LoginStateManager>()));
  gh.factory<_i53.ProfileManager>(
      () => _i53.ProfileManager(get<_i33.ProfileRepository>()));
  gh.factory<_i54.ProfileService>(
      () => _i54.ProfileService(get<_i53.ProfileManager>()));
  gh.factory<_i55.ProfileStateManager>(() => _i55.ProfileStateManager(
      get<_i54.ProfileService>(),
      get<_i29.ImageUploadService>(),
      get<_i24.AuthService>()));
  gh.factory<_i56.RegisterScreen>(
      () => _i56.RegisterScreen(get<_i34.RegisterStateManager>()));
  gh.factory<_i57.SettingsScreen>(() => _i57.SettingsScreen(
      get<_i24.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i45.FireNotificationService>()));
  gh.factory<_i58.SplashModule>(
      () => _i58.SplashModule(get<_i35.SplashScreen>()));
  gh.factory<_i59.StoreManager>(
      () => _i59.StoreManager(get<_i36.StoreRepository>()));
  gh.factory<_i60.StoreService>(
      () => _i60.StoreService(get<_i59.StoreManager>()));
  gh.factory<_i61.StoreStateManager>(() => _i61.StoreStateManager(
      get<_i60.StoreService>(),
      get<_i29.ImageUploadService>(),
      get<_i24.AuthService>()));
  gh.factory<_i62.AboutScreenStateManager>(
      () => _i62.AboutScreenStateManager(get<_i38.AboutService>()));
  gh.factory<_i63.AuthorizationModule>(() => _i63.AuthorizationModule(
      get<_i52.LoginScreen>(),
      get<_i56.RegisterScreen>(),
      get<_i46.ForgotPassScreen>()));
  gh.factory<_i64.BalanceScreen>(
      () => _i64.BalanceScreen(get<_i41.BalanceStateManager>()));
  gh.factory<_i65.ChatPage>(() => _i65.ChatPage(
      get<_i44.ChatStateManager>(),
      get<_i29.ImageUploadService>(),
      get<_i24.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i66.HomeStateManager>(() => _i66.HomeStateManager(
      get<_i48.HomeService>(), get<_i54.ProfileService>()));
  gh.factory<_i67.InitAccountScreen>(
      () => _i67.InitAccountScreen(get<_i51.InitAccountStateManager>()));
  gh.factory<_i68.ProfileScreen>(
      () => _i68.ProfileScreen(get<_i55.ProfileStateManager>()));
  gh.factory<_i69.SettingsModule>(
      () => _i69.SettingsModule(get<_i57.SettingsScreen>()));
  gh.factory<_i70.StoreScreen>(
      () => _i70.StoreScreen(get<_i61.StoreStateManager>()));
  gh.factory<_i71.AboutScreen>(
      () => _i71.AboutScreen(get<_i62.AboutScreenStateManager>()));
  gh.factory<_i72.BalanceModule>(
      () => _i72.BalanceModule(get<_i64.BalanceScreen>()));
  gh.factory<_i73.ChatModule>(
      () => _i73.ChatModule(get<_i65.ChatPage>(), get<_i24.AuthService>()));
  gh.factory<_i74.HomeScreen>(
      () => _i74.HomeScreen(get<_i66.HomeStateManager>()));
  gh.factory<_i75.InitAccountModule>(
      () => _i75.InitAccountModule(get<_i67.InitAccountScreen>()));
  gh.factory<_i76.ProfileModule>(
      () => _i76.ProfileModule(get<_i68.ProfileScreen>()));
  gh.factory<_i77.StoreModule>(() => _i77.StoreModule(get<_i70.StoreScreen>()));
  gh.factory<_i78.AboutModule>(() => _i78.AboutModule(get<_i71.AboutScreen>()));
  gh.factory<_i79.HomeModule>(() => _i79.HomeModule(get<_i74.HomeScreen>()));
  gh.factory<_i80.MyApp>(() => _i80.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i45.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i58.SplashModule>(),
      get<_i63.AuthorizationModule>(),
      get<_i73.ChatModule>(),
      get<_i69.SettingsModule>(),
      get<_i75.InitAccountModule>(),
      get<_i79.HomeModule>(),
      get<_i78.AboutModule>(),
      get<_i76.ProfileModule>(),
      get<_i19.MyCodeModule>(),
      get<_i77.StoreModule>(),
      get<_i20.PrivacyModule>(),
      get<_i72.BalanceModule>()));
  gh.singleton<_i81.GlobalStateManager>(_i81.GlobalStateManager());
  return get;
}
