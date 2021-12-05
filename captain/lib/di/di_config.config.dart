// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i83;
import '../module_about/about_module.dart' as _i81;
import '../module_about/manager/about_manager.dart' as _i33;
import '../module_about/repository/about_repository.dart' as _i18;
import '../module_about/service/about_service/about_service.dart' as _i34;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i56;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i71;
import '../module_auth/authoriazation_module.dart' as _i73;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i19;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i20;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i24;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i49;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i43;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i67;
import '../module_chat/chat_module.dart' as _i74;
import '../module_chat/manager/chat/chat_manager.dart' as _i36;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i21;
import '../module_chat/service/chat/char_service.dart' as _i37;
import '../module_chat/state_manager/chat_state_manager.dart' as _i38;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i60;
import '../module_init/init_account_module.dart' as _i76;
import '../module_init/manager/init_account/init_account.manager.dart' as _i40;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i23;
import '../module_init/service/init_account/init_account.service.dart' as _i41;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i42;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i62;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i9;
import '../module_notifications/repository/notification_repo.dart' as _i25;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i39;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i27;
import '../module_orders/orders_module.dart' as _i78;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i26;
import '../module_orders/service/orders/orders.service.dart' as _i28;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i58;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i45;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i65;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i54;
import '../module_orders/state_manager/update/update_state_manager.dart'
    as _i32;
import '../module_orders/ui/screens/captain_orders/captain_orders.dart' as _i59;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i64;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i77;
import '../module_orders/ui/screens/terms/terms.dart' as _i70;
import '../module_orders/ui/screens/update/update.dart' as _i55;
import '../module_plan/manager/captain_balance_manager.dart' as _i35;
import '../module_plan/plan_module.dart' as _i82;
import '../module_plan/repository/package_balance_repository.dart' as _i29;
import '../module_plan/service/plan_service.dart' as _i46;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i66;
import '../module_plan/ui/screen/plan_screen.dart' as _i79;
import '../module_profile/manager/profile/profile.manager.dart' as _i47;
import '../module_profile/module_profile.dart' as _i80;
import '../module_profile/repository/profile/profile.repository.dart' as _i30;
import '../module_profile/service/profile/profile.service.dart' as _i48;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i57;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i61;
import '../module_profile/state_manager/order/order_info_state_manager.dart'
    as _i44;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i72;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i75;
import '../module_profile/ui/screen/order_info/order_info_screen.dart' as _i63;
import '../module_report/manager/report_manager.dart' as _i50;
import '../module_report/presistance/report_prefs_helper.dart' as _i10;
import '../module_report/repository/report_repository.dart' as _i31;
import '../module_report/service/report_service.dart' as _i51;
import '../module_settings/settings_module.dart' as _i68;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i52;
import '../module_splash/splash_module.dart' as _i69;
import '../module_splash/ui/screen/splash_screen.dart' as _i53;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i22;
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
  gh.factory<_i10.ReportPrefsHelper>(() => _i10.ReportPrefsHelper());
  gh.factory<_i11.ThemePreferencesHelper>(() => _i11.ThemePreferencesHelper());
  gh.factory<_i12.UploadRepository>(() => _i12.UploadRepository());
  gh.factory<_i13.ApiClient>(() => _i13.ApiClient(get<_i8.Logger>()));
  gh.factory<_i14.AppThemeDataService>(
      () => _i14.AppThemeDataService(get<_i11.ThemePreferencesHelper>()));
  gh.factory<_i15.AuthRepository>(
      () => _i15.AuthRepository(get<_i13.ApiClient>(), get<_i8.Logger>()));
  gh.factory<_i16.ChooseLocalScreen>(
      () => _i16.ChooseLocalScreen(get<_i7.LocalizationService>()));
  gh.factory<_i17.UploadManager>(
      () => _i17.UploadManager(get<_i12.UploadRepository>()));
  gh.factory<_i18.AboutRepository>(
      () => _i18.AboutRepository(get<_i13.ApiClient>()));
  gh.factory<_i19.AuthManager>(
      () => _i19.AuthManager(get<_i15.AuthRepository>()));
  gh.factory<_i20.AuthService>(() =>
      _i20.AuthService(get<_i3.AuthPrefsHelper>(), get<_i19.AuthManager>()));
  gh.factory<_i21.ChatRepository>(() =>
      _i21.ChatRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i22.ImageUploadService>(
      () => _i22.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i23.InitAccountRepository>(() => _i23.InitAccountRepository(
      get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i24.LoginStateManager>(
      () => _i24.LoginStateManager(get<_i20.AuthService>()));
  gh.factory<_i25.NotificationRepo>(() =>
      _i25.NotificationRepo(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i26.OrderRepository>(() =>
      _i26.OrderRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i27.OrdersManager>(
      () => _i27.OrdersManager(get<_i26.OrderRepository>()));
  gh.factory<_i28.OrdersService>(
      () => _i28.OrdersService(get<_i27.OrdersManager>()));
  gh.factory<_i29.PackageBalanceRepository>(() => _i29.PackageBalanceRepository(
      get<_i20.AuthService>(), get<_i13.ApiClient>()));
  gh.factory<_i30.ProfileRepository>(() =>
      _i30.ProfileRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i31.ReportRepository>(() => _i31.ReportRepository(
      get<_i13.ApiClient>(),
      get<_i20.AuthService>(),
      get<_i10.ReportPrefsHelper>()));
  gh.factory<_i32.UpdateStateManager>(
      () => _i32.UpdateStateManager(get<_i28.OrdersService>()));
  gh.factory<_i33.AboutManager>(
      () => _i33.AboutManager(get<_i18.AboutRepository>()));
  gh.factory<_i34.AboutService>(
      () => _i34.AboutService(get<_i33.AboutManager>()));
  gh.factory<_i35.CaptainBalanceManager>(
      () => _i35.CaptainBalanceManager(get<_i29.PackageBalanceRepository>()));
  gh.factory<_i36.ChatManager>(
      () => _i36.ChatManager(get<_i21.ChatRepository>()));
  gh.factory<_i37.ChatService>(() => _i37.ChatService(get<_i36.ChatManager>()));
  gh.factory<_i38.ChatStateManager>(
      () => _i38.ChatStateManager(get<_i37.ChatService>()));
  gh.factory<_i39.FireNotificationService>(() => _i39.FireNotificationService(
      get<_i9.NotificationsPrefsHelper>(), get<_i25.NotificationRepo>()));
  gh.factory<_i40.InitAccountManager>(
      () => _i40.InitAccountManager(get<_i23.InitAccountRepository>()));
  gh.factory<_i41.InitAccountService>(
      () => _i41.InitAccountService(get<_i40.InitAccountManager>()));
  gh.factory<_i42.InitAccountStateManager>(() => _i42.InitAccountStateManager(
      get<_i41.InitAccountService>(),
      get<_i20.AuthService>(),
      get<_i22.ImageUploadService>()));
  gh.factory<_i43.LoginScreen>(
      () => _i43.LoginScreen(get<_i24.LoginStateManager>()));
  gh.factory<_i44.OrderInfoStateManager>(
      () => _i44.OrderInfoStateManager(get<_i28.OrdersService>()));
  gh.factory<_i45.OrderLogsStateManager>(
      () => _i45.OrderLogsStateManager(get<_i28.OrdersService>()));
  gh.factory<_i46.PlanService>(
      () => _i46.PlanService(get<_i35.CaptainBalanceManager>()));
  gh.factory<_i47.ProfileManager>(
      () => _i47.ProfileManager(get<_i30.ProfileRepository>()));
  gh.factory<_i48.ProfileService>(() => _i48.ProfileService(
      get<_i47.ProfileManager>(), get<_i28.OrdersService>()));
  gh.factory<_i49.RegisterStateManager>(() => _i49.RegisterStateManager(
      get<_i20.AuthService>(), get<_i34.AboutService>()));
  gh.factory<_i50.ReportManager>(
      () => _i50.ReportManager(get<_i31.ReportRepository>()));
  gh.factory<_i51.ReportService>(
      () => _i51.ReportService(get<_i50.ReportManager>()));
  gh.factory<_i52.SettingsScreen>(() => _i52.SettingsScreen(
      get<_i20.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i39.FireNotificationService>()));
  gh.factory<_i53.SplashScreen>(() =>
      _i53.SplashScreen(get<_i20.AuthService>(), get<_i34.AboutService>()));
  gh.factory<_i54.TermsStateManager>(
      () => _i54.TermsStateManager(get<_i48.ProfileService>()));
  gh.factory<_i55.UpdateScreen>(
      () => _i55.UpdateScreen(get<_i32.UpdateStateManager>()));
  gh.factory<_i56.AboutScreenStateManager>(
      () => _i56.AboutScreenStateManager(get<_i34.AboutService>()));
  gh.factory<_i57.ActivityStateManager>(() => _i57.ActivityStateManager(
      get<_i48.ProfileService>(), get<_i20.AuthService>()));
  gh.factory<_i58.CaptainOrdersListStateManager>(() =>
      _i58.CaptainOrdersListStateManager(
          get<_i28.OrdersService>(), get<_i48.ProfileService>()));
  gh.factory<_i59.CaptainOrdersScreen>(() =>
      _i59.CaptainOrdersScreen(get<_i58.CaptainOrdersListStateManager>()));
  gh.factory<_i60.ChatPage>(() => _i60.ChatPage(
      get<_i38.ChatStateManager>(),
      get<_i22.ImageUploadService>(),
      get<_i20.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i61.EditProfileStateManager>(() => _i61.EditProfileStateManager(
      get<_i22.ImageUploadService>(),
      get<_i48.ProfileService>(),
      get<_i20.AuthService>()));
  gh.factory<_i62.InitAccountScreen>(
      () => _i62.InitAccountScreen(get<_i42.InitAccountStateManager>()));
  gh.factory<_i63.OrderInfoScreen>(
      () => _i63.OrderInfoScreen(get<_i44.OrderInfoStateManager>()));
  gh.factory<_i64.OrderLogsScreen>(
      () => _i64.OrderLogsScreen(get<_i45.OrderLogsStateManager>()));
  gh.factory<_i65.OrderStatusStateManager>(() => _i65.OrderStatusStateManager(
      get<_i28.OrdersService>(),
      get<_i51.ReportService>(),
      get<_i22.ImageUploadService>()));
  gh.factory<_i66.PlanScreenStateManager>(
      () => _i66.PlanScreenStateManager(get<_i46.PlanService>()));
  gh.factory<_i67.RegisterScreen>(
      () => _i67.RegisterScreen(get<_i49.RegisterStateManager>()));
  gh.factory<_i68.SettingsModule>(() => _i68.SettingsModule(
      get<_i52.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i69.SplashModule>(
      () => _i69.SplashModule(get<_i53.SplashScreen>()));
  gh.factory<_i70.TermsScreen>(
      () => _i70.TermsScreen(get<_i54.TermsStateManager>()));
  gh.factory<_i71.AboutScreen>(
      () => _i71.AboutScreen(get<_i56.AboutScreenStateManager>()));
  gh.factory<_i72.ActivityScreen>(
      () => _i72.ActivityScreen(get<_i57.ActivityStateManager>()));
  gh.factory<_i73.AuthorizationModule>(() => _i73.AuthorizationModule(
      get<_i43.LoginScreen>(), get<_i67.RegisterScreen>()));
  gh.factory<_i74.ChatModule>(
      () => _i74.ChatModule(get<_i60.ChatPage>(), get<_i20.AuthService>()));
  gh.factory<_i75.EditProfileScreen>(
      () => _i75.EditProfileScreen(get<_i61.EditProfileStateManager>()));
  gh.factory<_i76.InitAccountModule>(
      () => _i76.InitAccountModule(get<_i62.InitAccountScreen>()));
  gh.factory<_i77.OrderStatusScreen>(
      () => _i77.OrderStatusScreen(get<_i65.OrderStatusStateManager>()));
  gh.factory<_i78.OrdersModule>(() => _i78.OrdersModule(
      get<_i77.OrderStatusScreen>(),
      get<_i59.CaptainOrdersScreen>(),
      get<_i55.UpdateScreen>(),
      get<_i70.TermsScreen>(),
      get<_i64.OrderLogsScreen>()));
  gh.factory<_i79.PlanScreen>(
      () => _i79.PlanScreen(get<_i66.PlanScreenStateManager>()));
  gh.factory<_i80.ProfileModule>(() => _i80.ProfileModule(
      get<_i72.ActivityScreen>(),
      get<_i75.EditProfileScreen>(),
      get<_i63.OrderInfoScreen>()));
  gh.factory<_i81.AboutModule>(() => _i81.AboutModule(get<_i71.AboutScreen>()));
  gh.factory<_i82.PlanModule>(() => _i82.PlanModule(get<_i79.PlanScreen>()));
  gh.factory<_i83.MyApp>(() => _i83.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i39.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i69.SplashModule>(),
      get<_i73.AuthorizationModule>(),
      get<_i74.ChatModule>(),
      get<_i68.SettingsModule>(),
      get<_i81.AboutModule>(),
      get<_i76.InitAccountModule>(),
      get<_i80.ProfileModule>(),
      get<_i78.OrdersModule>(),
      get<_i82.PlanModule>()));
  return get;
}
