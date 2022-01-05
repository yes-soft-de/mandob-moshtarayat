// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i85;
import '../module_about/about_module.dart' as _i83;
import '../module_about/manager/about_manager.dart' as _i34;
import '../module_about/repository/about_repository.dart' as _i18;
import '../module_about/service/about_service/about_service.dart' as _i35;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i58;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i73;
import '../module_auth/authoriazation_module.dart' as _i75;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i19;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i20;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i22;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i25;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i51;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i41;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i45;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i69;
import '../module_chat/chat_module.dart' as _i76;
import '../module_chat/manager/chat/chat_manager.dart' as _i37;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i21;
import '../module_chat/service/chat/char_service.dart' as _i38;
import '../module_chat/state_manager/chat_state_manager.dart' as _i39;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i62;
import '../module_init/init_account_module.dart' as _i78;
import '../module_init/manager/init_account/init_account.manager.dart' as _i42;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i24;
import '../module_init/service/init_account/init_account.service.dart' as _i43;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i44;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i64;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i9;
import '../module_notifications/repository/notification_repo.dart' as _i26;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i40;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i28;
import '../module_orders/orders_module.dart' as _i80;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i27;
import '../module_orders/service/orders/orders.service.dart' as _i29;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i60;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i47;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i67;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i56;
import '../module_orders/state_manager/update/update_state_manager.dart'
    as _i33;
import '../module_orders/ui/screens/captain_orders/captain_orders.dart' as _i61;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i66;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i79;
import '../module_orders/ui/screens/terms/terms.dart' as _i72;
import '../module_orders/ui/screens/update/update.dart' as _i57;
import '../module_plan/manager/captain_balance_manager.dart' as _i36;
import '../module_plan/plan_module.dart' as _i84;
import '../module_plan/repository/package_balance_repository.dart' as _i30;
import '../module_plan/service/plan_service.dart' as _i48;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i68;
import '../module_plan/ui/screen/plan_screen.dart' as _i81;
import '../module_profile/manager/profile/profile.manager.dart' as _i49;
import '../module_profile/module_profile.dart' as _i82;
import '../module_profile/repository/profile/profile.repository.dart' as _i31;
import '../module_profile/service/profile/profile.service.dart' as _i50;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i59;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i63;
import '../module_profile/state_manager/order/order_info_state_manager.dart'
    as _i46;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i74;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i77;
import '../module_profile/ui/screen/order_info/order_info_screen.dart' as _i65;
import '../module_report/manager/report_manager.dart' as _i52;
import '../module_report/presistance/report_prefs_helper.dart' as _i10;
import '../module_report/repository/report_repository.dart' as _i32;
import '../module_report/service/report_service.dart' as _i53;
import '../module_settings/settings_module.dart' as _i70;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i54;
import '../module_splash/splash_module.dart' as _i71;
import '../module_splash/ui/screen/splash_screen.dart' as _i55;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i23;
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
  gh.factory<_i22.ForgotPassStateManager>(
      () => _i22.ForgotPassStateManager(get<_i20.AuthService>()));
  gh.factory<_i23.ImageUploadService>(
      () => _i23.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i24.InitAccountRepository>(() => _i24.InitAccountRepository(
      get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i25.LoginStateManager>(
      () => _i25.LoginStateManager(get<_i20.AuthService>()));
  gh.factory<_i26.NotificationRepo>(() =>
      _i26.NotificationRepo(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i27.OrderRepository>(() =>
      _i27.OrderRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i28.OrdersManager>(
      () => _i28.OrdersManager(get<_i27.OrderRepository>()));
  gh.factory<_i29.OrdersService>(
      () => _i29.OrdersService(get<_i28.OrdersManager>()));
  gh.factory<_i30.PackageBalanceRepository>(() => _i30.PackageBalanceRepository(
      get<_i20.AuthService>(), get<_i13.ApiClient>()));
  gh.factory<_i31.ProfileRepository>(() =>
      _i31.ProfileRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i32.ReportRepository>(() => _i32.ReportRepository(
      get<_i13.ApiClient>(),
      get<_i20.AuthService>(),
      get<_i10.ReportPrefsHelper>()));
  gh.factory<_i33.UpdateStateManager>(
      () => _i33.UpdateStateManager(get<_i29.OrdersService>()));
  gh.factory<_i34.AboutManager>(
      () => _i34.AboutManager(get<_i18.AboutRepository>()));
  gh.factory<_i35.AboutService>(
      () => _i35.AboutService(get<_i34.AboutManager>()));
  gh.factory<_i36.CaptainBalanceManager>(
      () => _i36.CaptainBalanceManager(get<_i30.PackageBalanceRepository>()));
  gh.factory<_i37.ChatManager>(
      () => _i37.ChatManager(get<_i21.ChatRepository>()));
  gh.factory<_i38.ChatService>(() => _i38.ChatService(get<_i37.ChatManager>()));
  gh.factory<_i39.ChatStateManager>(
      () => _i39.ChatStateManager(get<_i38.ChatService>()));
  gh.factory<_i40.FireNotificationService>(() => _i40.FireNotificationService(
      get<_i9.NotificationsPrefsHelper>(), get<_i26.NotificationRepo>()));
  gh.factory<_i41.ForgotPassScreen>(
      () => _i41.ForgotPassScreen(get<_i22.ForgotPassStateManager>()));
  gh.factory<_i42.InitAccountManager>(
      () => _i42.InitAccountManager(get<_i24.InitAccountRepository>()));
  gh.factory<_i43.InitAccountService>(
      () => _i43.InitAccountService(get<_i42.InitAccountManager>()));
  gh.factory<_i44.InitAccountStateManager>(() => _i44.InitAccountStateManager(
      get<_i43.InitAccountService>(),
      get<_i20.AuthService>(),
      get<_i23.ImageUploadService>()));
  gh.factory<_i45.LoginScreen>(
      () => _i45.LoginScreen(get<_i25.LoginStateManager>()));
  gh.factory<_i46.OrderInfoStateManager>(
      () => _i46.OrderInfoStateManager(get<_i29.OrdersService>()));
  gh.factory<_i47.OrderLogsStateManager>(
      () => _i47.OrderLogsStateManager(get<_i29.OrdersService>()));
  gh.factory<_i48.PlanService>(
      () => _i48.PlanService(get<_i36.CaptainBalanceManager>()));
  gh.factory<_i49.ProfileManager>(
      () => _i49.ProfileManager(get<_i31.ProfileRepository>()));
  gh.factory<_i50.ProfileService>(() => _i50.ProfileService(
      get<_i49.ProfileManager>(), get<_i29.OrdersService>()));
  gh.factory<_i51.RegisterStateManager>(() => _i51.RegisterStateManager(
      get<_i20.AuthService>(), get<_i35.AboutService>()));
  gh.factory<_i52.ReportManager>(
      () => _i52.ReportManager(get<_i32.ReportRepository>()));
  gh.factory<_i53.ReportService>(
      () => _i53.ReportService(get<_i52.ReportManager>()));
  gh.factory<_i54.SettingsScreen>(() => _i54.SettingsScreen(
      get<_i20.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i40.FireNotificationService>()));
  gh.factory<_i55.SplashScreen>(() =>
      _i55.SplashScreen(get<_i20.AuthService>(), get<_i35.AboutService>()));
  gh.factory<_i56.TermsStateManager>(
      () => _i56.TermsStateManager(get<_i50.ProfileService>()));
  gh.factory<_i57.UpdateScreen>(
      () => _i57.UpdateScreen(get<_i33.UpdateStateManager>()));
  gh.factory<_i58.AboutScreenStateManager>(
      () => _i58.AboutScreenStateManager(get<_i35.AboutService>()));
  gh.factory<_i59.ActivityStateManager>(() => _i59.ActivityStateManager(
      get<_i50.ProfileService>(), get<_i20.AuthService>()));
  gh.factory<_i60.CaptainOrdersListStateManager>(() =>
      _i60.CaptainOrdersListStateManager(
          get<_i29.OrdersService>(), get<_i50.ProfileService>()));
  gh.factory<_i61.CaptainOrdersScreen>(() =>
      _i61.CaptainOrdersScreen(get<_i60.CaptainOrdersListStateManager>()));
  gh.factory<_i62.ChatPage>(() => _i62.ChatPage(
      get<_i39.ChatStateManager>(),
      get<_i23.ImageUploadService>(),
      get<_i20.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i63.EditProfileStateManager>(() => _i63.EditProfileStateManager(
      get<_i23.ImageUploadService>(),
      get<_i50.ProfileService>(),
      get<_i20.AuthService>()));
  gh.factory<_i64.InitAccountScreen>(
      () => _i64.InitAccountScreen(get<_i44.InitAccountStateManager>()));
  gh.factory<_i65.OrderInfoScreen>(
      () => _i65.OrderInfoScreen(get<_i46.OrderInfoStateManager>()));
  gh.factory<_i66.OrderLogsScreen>(
      () => _i66.OrderLogsScreen(get<_i47.OrderLogsStateManager>()));
  gh.factory<_i67.OrderStatusStateManager>(() => _i67.OrderStatusStateManager(
      get<_i29.OrdersService>(),
      get<_i53.ReportService>(),
      get<_i23.ImageUploadService>()));
  gh.factory<_i68.PlanScreenStateManager>(
      () => _i68.PlanScreenStateManager(get<_i48.PlanService>()));
  gh.factory<_i69.RegisterScreen>(
      () => _i69.RegisterScreen(get<_i51.RegisterStateManager>()));
  gh.factory<_i70.SettingsModule>(() => _i70.SettingsModule(
      get<_i54.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i71.SplashModule>(
      () => _i71.SplashModule(get<_i55.SplashScreen>()));
  gh.factory<_i72.TermsScreen>(
      () => _i72.TermsScreen(get<_i56.TermsStateManager>()));
  gh.factory<_i73.AboutScreen>(
      () => _i73.AboutScreen(get<_i58.AboutScreenStateManager>()));
  gh.factory<_i74.ActivityScreen>(
      () => _i74.ActivityScreen(get<_i59.ActivityStateManager>()));
  gh.factory<_i75.AuthorizationModule>(() => _i75.AuthorizationModule(
      get<_i45.LoginScreen>(),
      get<_i69.RegisterScreen>(),
      get<_i41.ForgotPassScreen>()));
  gh.factory<_i76.ChatModule>(
      () => _i76.ChatModule(get<_i62.ChatPage>(), get<_i20.AuthService>()));
  gh.factory<_i77.EditProfileScreen>(
      () => _i77.EditProfileScreen(get<_i63.EditProfileStateManager>()));
  gh.factory<_i78.InitAccountModule>(
      () => _i78.InitAccountModule(get<_i64.InitAccountScreen>()));
  gh.factory<_i79.OrderStatusScreen>(
      () => _i79.OrderStatusScreen(get<_i67.OrderStatusStateManager>()));
  gh.factory<_i80.OrdersModule>(() => _i80.OrdersModule(
      get<_i79.OrderStatusScreen>(),
      get<_i61.CaptainOrdersScreen>(),
      get<_i57.UpdateScreen>(),
      get<_i72.TermsScreen>(),
      get<_i66.OrderLogsScreen>()));
  gh.factory<_i81.PlanScreen>(
      () => _i81.PlanScreen(get<_i68.PlanScreenStateManager>()));
  gh.factory<_i82.ProfileModule>(() => _i82.ProfileModule(
      get<_i74.ActivityScreen>(),
      get<_i77.EditProfileScreen>(),
      get<_i65.OrderInfoScreen>()));
  gh.factory<_i83.AboutModule>(() => _i83.AboutModule(get<_i73.AboutScreen>()));
  gh.factory<_i84.PlanModule>(() => _i84.PlanModule(get<_i81.PlanScreen>()));
  gh.factory<_i85.MyApp>(() => _i85.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i40.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i71.SplashModule>(),
      get<_i75.AuthorizationModule>(),
      get<_i76.ChatModule>(),
      get<_i70.SettingsModule>(),
      get<_i83.AboutModule>(),
      get<_i78.InitAccountModule>(),
      get<_i82.ProfileModule>(),
      get<_i80.OrdersModule>(),
      get<_i84.PlanModule>()));
  return get;
}
