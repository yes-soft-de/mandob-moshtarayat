// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i88;
import '../module_about/about_module.dart' as _i86;
import '../module_about/manager/about_manager.dart' as _i37;
import '../module_about/repository/about_repository.dart' as _i21;
import '../module_about/service/about_service/about_service.dart' as _i38;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i61;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i76;
import '../module_auth/authoriazation_module.dart' as _i78;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i22;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i23;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i25;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i28;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i54;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i44;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i48;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i72;
import '../module_chat/chat_module.dart' as _i79;
import '../module_chat/manager/chat/chat_manager.dart' as _i40;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i24;
import '../module_chat/service/chat/char_service.dart' as _i41;
import '../module_chat/state_manager/chat_state_manager.dart' as _i42;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i65;
import '../module_init/init_account_module.dart' as _i81;
import '../module_init/manager/init_account/init_account.manager.dart' as _i45;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i27;
import '../module_init/service/init_account/init_account.service.dart' as _i46;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i47;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i67;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i29;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i43;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i31;
import '../module_orders/orders_module.dart' as _i83;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i30;
import '../module_orders/service/orders/orders.service.dart' as _i32;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i63;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i50;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i70;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i59;
import '../module_orders/state_manager/update/update_state_manager.dart'
    as _i36;
import '../module_orders/ui/screens/captain_orders/captain_orders.dart' as _i64;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i69;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i82;
import '../module_orders/ui/screens/terms/terms.dart' as _i75;
import '../module_orders/ui/screens/update/update.dart' as _i60;
import '../module_plan/manager/captain_balance_manager.dart' as _i39;
import '../module_plan/plan_module.dart' as _i87;
import '../module_plan/repository/package_balance_repository.dart' as _i33;
import '../module_plan/service/plan_service.dart' as _i51;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i71;
import '../module_plan/ui/screen/plan_screen.dart' as _i84;
import '../module_profile/manager/profile/profile.manager.dart' as _i52;
import '../module_profile/module_profile.dart' as _i85;
import '../module_profile/repository/profile/profile.repository.dart' as _i34;
import '../module_profile/service/profile/profile.service.dart' as _i53;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i62;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i66;
import '../module_profile/state_manager/order/order_info_state_manager.dart'
    as _i49;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i77;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i80;
import '../module_profile/ui/screen/order_info/order_info_screen.dart' as _i68;
import '../module_report/manager/report_manager.dart' as _i55;
import '../module_report/presistance/report_prefs_helper.dart' as _i12;
import '../module_report/repository/report_repository.dart' as _i35;
import '../module_report/service/report_service.dart' as _i56;
import '../module_settings/settings_module.dart' as _i73;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i19;
import '../module_settings/ui/settings_page/screen/about.dart' as _i3;
import '../module_settings/ui/settings_page/screen/privecy_policy.dart' as _i11;
import '../module_settings/ui/settings_page/screen/terms_of_use.dart' as _i13;
import '../module_settings/ui/settings_page/settings_page.dart' as _i57;
import '../module_splash/splash_module.dart' as _i74;
import '../module_splash/ui/screen/splash_screen.dart' as _i58;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i20;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i26;
import '../utils/logger/logger.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutScreen>(() => _i3.AboutScreen());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.ChatHiveHelper>(() => _i5.ChatHiveHelper());
  gh.factory<_i6.LocalNotificationService>(
      () => _i6.LocalNotificationService());
  gh.factory<_i7.LocalizationPreferencesHelper>(
      () => _i7.LocalizationPreferencesHelper());
  gh.factory<_i8.LocalizationService>(
      () => _i8.LocalizationService(get<_i7.LocalizationPreferencesHelper>()));
  gh.factory<_i9.Logger>(() => _i9.Logger());
  gh.factory<_i10.NotificationsPrefsHelper>(
      () => _i10.NotificationsPrefsHelper());
  gh.factory<_i11.PrivecyPolicy>(() => _i11.PrivecyPolicy());
  gh.factory<_i12.ReportPrefsHelper>(() => _i12.ReportPrefsHelper());
  gh.factory<_i13.TermsOfUse>(() => _i13.TermsOfUse());
  gh.factory<_i14.ThemePreferencesHelper>(() => _i14.ThemePreferencesHelper());
  gh.factory<_i15.UploadRepository>(() => _i15.UploadRepository());
  gh.factory<_i16.ApiClient>(() => _i16.ApiClient(get<_i9.Logger>()));
  gh.factory<_i17.AppThemeDataService>(
      () => _i17.AppThemeDataService(get<_i14.ThemePreferencesHelper>()));
  gh.factory<_i18.AuthRepository>(
      () => _i18.AuthRepository(get<_i16.ApiClient>(), get<_i9.Logger>()));
  gh.factory<_i19.ChooseLocalScreen>(
      () => _i19.ChooseLocalScreen(get<_i8.LocalizationService>()));
  gh.factory<_i20.UploadManager>(
      () => _i20.UploadManager(get<_i15.UploadRepository>()));
  gh.factory<_i21.AboutRepository>(
      () => _i21.AboutRepository(get<_i16.ApiClient>()));
  gh.factory<_i22.AuthManager>(
      () => _i22.AuthManager(get<_i18.AuthRepository>()));
  gh.factory<_i23.AuthService>(() =>
      _i23.AuthService(get<_i4.AuthPrefsHelper>(), get<_i22.AuthManager>()));
  gh.factory<_i24.ChatRepository>(() =>
      _i24.ChatRepository(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i25.ForgotPassStateManager>(
      () => _i25.ForgotPassStateManager(get<_i23.AuthService>()));
  gh.factory<_i26.ImageUploadService>(
      () => _i26.ImageUploadService(get<_i20.UploadManager>()));
  gh.factory<_i27.InitAccountRepository>(() => _i27.InitAccountRepository(
      get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i28.LoginStateManager>(
      () => _i28.LoginStateManager(get<_i23.AuthService>()));
  gh.factory<_i29.NotificationRepo>(() =>
      _i29.NotificationRepo(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i30.OrderRepository>(() =>
      _i30.OrderRepository(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i31.OrdersManager>(
      () => _i31.OrdersManager(get<_i30.OrderRepository>()));
  gh.factory<_i32.OrdersService>(
      () => _i32.OrdersService(get<_i31.OrdersManager>()));
  gh.factory<_i33.PackageBalanceRepository>(() => _i33.PackageBalanceRepository(
      get<_i23.AuthService>(), get<_i16.ApiClient>()));
  gh.factory<_i34.ProfileRepository>(() =>
      _i34.ProfileRepository(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i35.ReportRepository>(() => _i35.ReportRepository(
      get<_i16.ApiClient>(),
      get<_i23.AuthService>(),
      get<_i12.ReportPrefsHelper>()));
  gh.factory<_i36.UpdateStateManager>(
      () => _i36.UpdateStateManager(get<_i32.OrdersService>()));
  gh.factory<_i37.AboutManager>(
      () => _i37.AboutManager(get<_i21.AboutRepository>()));
  gh.factory<_i38.AboutService>(
      () => _i38.AboutService(get<_i37.AboutManager>()));
  gh.factory<_i39.CaptainBalanceManager>(
      () => _i39.CaptainBalanceManager(get<_i33.PackageBalanceRepository>()));
  gh.factory<_i40.ChatManager>(
      () => _i40.ChatManager(get<_i24.ChatRepository>()));
  gh.factory<_i41.ChatService>(() => _i41.ChatService(get<_i40.ChatManager>()));
  gh.factory<_i42.ChatStateManager>(
      () => _i42.ChatStateManager(get<_i41.ChatService>()));
  gh.factory<_i43.FireNotificationService>(() => _i43.FireNotificationService(
      get<_i10.NotificationsPrefsHelper>(), get<_i29.NotificationRepo>()));
  gh.factory<_i44.ForgotPassScreen>(
      () => _i44.ForgotPassScreen(get<_i25.ForgotPassStateManager>()));
  gh.factory<_i45.InitAccountManager>(
      () => _i45.InitAccountManager(get<_i27.InitAccountRepository>()));
  gh.factory<_i46.InitAccountService>(
      () => _i46.InitAccountService(get<_i45.InitAccountManager>()));
  gh.factory<_i47.InitAccountStateManager>(() => _i47.InitAccountStateManager(
      get<_i46.InitAccountService>(),
      get<_i23.AuthService>(),
      get<_i26.ImageUploadService>()));
  gh.factory<_i48.LoginScreen>(
      () => _i48.LoginScreen(get<_i28.LoginStateManager>()));
  gh.factory<_i49.OrderInfoStateManager>(
      () => _i49.OrderInfoStateManager(get<_i32.OrdersService>()));
  gh.factory<_i50.OrderLogsStateManager>(
      () => _i50.OrderLogsStateManager(get<_i32.OrdersService>()));
  gh.factory<_i51.PlanService>(
      () => _i51.PlanService(get<_i39.CaptainBalanceManager>()));
  gh.factory<_i52.ProfileManager>(
      () => _i52.ProfileManager(get<_i34.ProfileRepository>()));
  gh.factory<_i53.ProfileService>(() => _i53.ProfileService(
      get<_i52.ProfileManager>(), get<_i32.OrdersService>()));
  gh.factory<_i54.RegisterStateManager>(() => _i54.RegisterStateManager(
      get<_i23.AuthService>(), get<_i38.AboutService>()));
  gh.factory<_i55.ReportManager>(
      () => _i55.ReportManager(get<_i35.ReportRepository>()));
  gh.factory<_i56.ReportService>(
      () => _i56.ReportService(get<_i55.ReportManager>()));
  gh.factory<_i57.SettingsScreen>(() => _i57.SettingsScreen(
      get<_i23.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i43.FireNotificationService>()));
  gh.factory<_i58.SplashScreen>(() =>
      _i58.SplashScreen(get<_i23.AuthService>(), get<_i38.AboutService>()));
  gh.factory<_i59.TermsStateManager>(
      () => _i59.TermsStateManager(get<_i53.ProfileService>()));
  gh.factory<_i60.UpdateScreen>(
      () => _i60.UpdateScreen(get<_i36.UpdateStateManager>()));
  gh.factory<_i61.AboutScreenStateManager>(
      () => _i61.AboutScreenStateManager(get<_i38.AboutService>()));
  gh.factory<_i62.ActivityStateManager>(() => _i62.ActivityStateManager(
      get<_i53.ProfileService>(), get<_i23.AuthService>()));
  gh.factory<_i63.CaptainOrdersListStateManager>(() =>
      _i63.CaptainOrdersListStateManager(
          get<_i32.OrdersService>(), get<_i53.ProfileService>()));
  gh.factory<_i64.CaptainOrdersScreen>(() =>
      _i64.CaptainOrdersScreen(get<_i63.CaptainOrdersListStateManager>()));
  gh.factory<_i65.ChatPage>(() => _i65.ChatPage(
      get<_i42.ChatStateManager>(),
      get<_i26.ImageUploadService>(),
      get<_i23.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i66.EditProfileStateManager>(() => _i66.EditProfileStateManager(
      get<_i26.ImageUploadService>(),
      get<_i53.ProfileService>(),
      get<_i23.AuthService>()));
  gh.factory<_i67.InitAccountScreen>(
      () => _i67.InitAccountScreen(get<_i47.InitAccountStateManager>()));
  gh.factory<_i68.OrderInfoScreen>(
      () => _i68.OrderInfoScreen(get<_i49.OrderInfoStateManager>()));
  gh.factory<_i69.OrderLogsScreen>(
      () => _i69.OrderLogsScreen(get<_i50.OrderLogsStateManager>()));
  gh.factory<_i70.OrderStatusStateManager>(() => _i70.OrderStatusStateManager(
      get<_i32.OrdersService>(),
      get<_i56.ReportService>(),
      get<_i26.ImageUploadService>()));
  gh.factory<_i71.PlanScreenStateManager>(
      () => _i71.PlanScreenStateManager(get<_i51.PlanService>()));
  gh.factory<_i72.RegisterScreen>(
      () => _i72.RegisterScreen(get<_i54.RegisterStateManager>()));
  gh.factory<_i73.SettingsModule>(() => _i73.SettingsModule(
      get<_i57.SettingsScreen>(),
      get<_i19.ChooseLocalScreen>(),
      get<_i11.PrivecyPolicy>(),
      get<_i13.TermsOfUse>()));
  gh.factory<_i74.SplashModule>(
      () => _i74.SplashModule(get<_i58.SplashScreen>()));
  gh.factory<_i75.TermsScreen>(
      () => _i75.TermsScreen(get<_i59.TermsStateManager>()));
  gh.factory<_i76.AboutScreen>(
      () => _i76.AboutScreen(get<_i61.AboutScreenStateManager>()));
  gh.factory<_i77.ActivityScreen>(
      () => _i77.ActivityScreen(get<_i62.ActivityStateManager>()));
  gh.factory<_i78.AuthorizationModule>(() => _i78.AuthorizationModule(
      get<_i48.LoginScreen>(),
      get<_i72.RegisterScreen>(),
      get<_i44.ForgotPassScreen>()));
  gh.factory<_i79.ChatModule>(
      () => _i79.ChatModule(get<_i65.ChatPage>(), get<_i23.AuthService>()));
  gh.factory<_i80.EditProfileScreen>(
      () => _i80.EditProfileScreen(get<_i66.EditProfileStateManager>()));
  gh.factory<_i81.InitAccountModule>(
      () => _i81.InitAccountModule(get<_i67.InitAccountScreen>()));
  gh.factory<_i82.OrderStatusScreen>(
      () => _i82.OrderStatusScreen(get<_i70.OrderStatusStateManager>()));
  gh.factory<_i83.OrdersModule>(() => _i83.OrdersModule(
      get<_i82.OrderStatusScreen>(),
      get<_i64.CaptainOrdersScreen>(),
      get<_i60.UpdateScreen>(),
      get<_i75.TermsScreen>(),
      get<_i69.OrderLogsScreen>()));
  gh.factory<_i84.PlanScreen>(
      () => _i84.PlanScreen(get<_i71.PlanScreenStateManager>()));
  gh.factory<_i85.ProfileModule>(() => _i85.ProfileModule(
      get<_i77.ActivityScreen>(),
      get<_i80.EditProfileScreen>(),
      get<_i68.OrderInfoScreen>()));
  gh.factory<_i86.AboutModule>(() => _i86.AboutModule(get<_i76.AboutScreen>()));
  gh.factory<_i87.PlanModule>(() => _i87.PlanModule(get<_i84.PlanScreen>()));
  gh.factory<_i88.MyApp>(() => _i88.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i43.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i74.SplashModule>(),
      get<_i78.AuthorizationModule>(),
      get<_i79.ChatModule>(),
      get<_i73.SettingsModule>(),
      get<_i86.AboutModule>(),
      get<_i81.InitAccountModule>(),
      get<_i85.ProfileModule>(),
      get<_i83.OrdersModule>(),
      get<_i87.PlanModule>()));
  return get;
}
