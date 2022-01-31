// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i108;
import '../module_about/about_module.dart' as _i105;
import '../module_about/manager/about_manager.dart' as _i42;
import '../module_about/repository/about_repository.dart' as _i23;
import '../module_about/service/about_service/about_service.dart' as _i43;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i71;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i90;
import '../module_auth/authoriazation_module.dart' as _i91;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i24;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i25;
import '../module_auth/state_manager/forgot_pass_state_manager/forgot_state_manager.dart'
    as _i29;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i33;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i65;
import '../module_auth/ui/screen/forgot_pass_screen/forgot_pass_screen.dart'
    as _i53;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i59;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i85;
import '../module_balance/balance_module.dart' as _i92;
import '../module_balance/manager/balance_manager.dart' as _i44;
import '../module_balance/repository/balance_repository.dart' as _i26;
import '../module_balance/service/balance_service.dart' as _i45;
import '../module_balance/state_manager/balance_state_manager.dart' as _i46;
import '../module_balance/ui/screen/balance_info_screen.dart' as _i72;
import '../module_categories/categories_module.dart' as _i106;
import '../module_categories/manager/categories_manager.dart' as _i47;
import '../module_categories/repository/categories_repository.dart' as _i27;
import '../module_categories/service/store_categories_service.dart' as _i48;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i84;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i87;
import '../module_categories/ui/screen/product_categories_screen.dart' as _i101;
import '../module_categories/ui/screen/store_products_screen.dart' as _i103;
import '../module_chat/chat_module.dart' as _i93;
import '../module_chat/manager/chat/chat_manager.dart' as _i49;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i28;
import '../module_chat/service/chat/char_service.dart' as _i50;
import '../module_chat/state_manager/chat_state_manager.dart' as _i51;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i73;
import '../module_home/home_module.dart' as _i107;
import '../module_home/manager/home_manager.dart' as _i54;
import '../module_home/repository/home_repository.dart' as _i30;
import '../module_home/sceen/home_screen.dart' as _i94;
import '../module_home/service/home_service.dart' as _i55;
import '../module_home/state_manager/home_state_manager.dart' as _i74;
import '../module_init/init_account_module.dart' as _i95;
import '../module_init/manager/init_account/init_account.manager.dart' as _i56;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i32;
import '../module_init/service/init_account/init_account.service.dart' as _i57;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i58;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i75;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_main/main_module.dart' as _i19;
import '../module_main/ui/screen/main_screen.dart' as _i10;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i60;
import '../module_my_notifications/my_notifications_module.dart' as _i96;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i34;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i61;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i62;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i76;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i36;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i52;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_orders/manager/my_orders_manager.dart' as _i63;
import '../module_orders/orders_module.dart' as _i100;
import '../module_orders/repository/orders_repository.dart' as _i35;
import '../module_orders/service/orders_service.dart' as _i64;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i77;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i78;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i79;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i80;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i81;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i82;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i97;
import '../module_orders/ui/screen/order_details_screen.dart' as _i98;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i99;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i83;
import '../module_privacy/privacy_module.dart' as _i20;
import '../module_privacy/ui/policies_page/about_page.dart' as _i3;
import '../module_privacy/ui/policies_page/policy_page.dart' as _i12;
import '../module_privacy/ui/policies_page/terms_page.dart' as _i13;
import '../module_profile/manager/stores_manager.dart' as _i68;
import '../module_profile/repository/stores_repository.dart' as _i39;
import '../module_profile/service/store_service.dart' as _i70;
import '../module_profile/state_manager/store_profile_state_manager.dart'
    as _i88;
import '../module_profile/stores_module.dart' as _i104;
import '../module_profile/ui/screen/store_info_screen.dart' as _i102;
import '../module_settings/settings_module.dart' as _i86;
import '../module_settings/ui/settings_page/settings_page.dart' as _i66;
import '../module_splash/splash_module.dart' as _i67;
import '../module_splash/ui/screen/splash_screen.dart' as _i37;
import '../module_stores/manager/stores_manager.dart' as _i38;
import '../module_stores/repository/stores_repository.dart' as _i21;
import '../module_stores/service/stores_service.dart' as _i40;
import '../module_stores/state_manager/stores_state_manager.dart' as _i41;
import '../module_stores/stores_module.dart' as _i89;
import '../module_stores/ui/screen/stores_screen.dart' as _i69;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i22;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i31;
import '../utils/global/global_state_manager.dart' as _i109;
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
  gh.factory<_i10.MainScreen>(() => _i10.MainScreen());
  gh.factory<_i11.NotificationsPrefHelper>(
      () => _i11.NotificationsPrefHelper());
  gh.factory<_i12.PolicyPage>(() => _i12.PolicyPage());
  gh.factory<_i13.TermOfServicePage>(() => _i13.TermOfServicePage());
  gh.factory<_i14.ThemePreferencesHelper>(() => _i14.ThemePreferencesHelper());
  gh.factory<_i15.UploadRepository>(() => _i15.UploadRepository());
  gh.factory<_i16.ApiClient>(() => _i16.ApiClient(get<_i9.Logger>()));
  gh.factory<_i17.AppThemeDataService>(
      () => _i17.AppThemeDataService(get<_i14.ThemePreferencesHelper>()));
  gh.factory<_i18.AuthRepository>(
      () => _i18.AuthRepository(get<_i16.ApiClient>(), get<_i9.Logger>()));
  gh.factory<_i19.MainModule>(() => _i19.MainModule(get<_i10.MainScreen>()));
  gh.factory<_i20.PrivacyModule>(() => _i20.PrivacyModule(
      get<_i13.TermOfServicePage>(),
      get<_i12.PolicyPage>(),
      get<_i3.AboutUsPage>()));
  gh.factory<_i21.StoresRepository>(() => _i21.StoresRepository(
      get<_i16.ApiClient>(), get<_i8.LocalizationService>()));
  gh.factory<_i22.UploadManager>(
      () => _i22.UploadManager(get<_i15.UploadRepository>()));
  gh.factory<_i23.AboutRepository>(
      () => _i23.AboutRepository(get<_i16.ApiClient>()));
  gh.factory<_i24.AuthManager>(
      () => _i24.AuthManager(get<_i18.AuthRepository>()));
  gh.factory<_i25.AuthService>(() =>
      _i25.AuthService(get<_i4.AuthPrefsHelper>(), get<_i24.AuthManager>()));
  gh.factory<_i26.BalanceRepository>(() =>
      _i26.BalanceRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i27.CategoriesRepository>(() => _i27.CategoriesRepository(
      get<_i16.ApiClient>(),
      get<_i25.AuthService>(),
      get<_i8.LocalizationService>()));
  gh.factory<_i28.ChatRepository>(() =>
      _i28.ChatRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i29.ForgotPassStateManager>(
      () => _i29.ForgotPassStateManager(get<_i25.AuthService>()));
  gh.factory<_i30.HomeRepository>(() =>
      _i30.HomeRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i31.ImageUploadService>(
      () => _i31.ImageUploadService(get<_i22.UploadManager>()));
  gh.factory<_i32.InitAccountRepository>(() => _i32.InitAccountRepository(
      get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i33.LoginStateManager>(
      () => _i33.LoginStateManager(get<_i25.AuthService>()));
  gh.factory<_i34.MyNotificationsRepository>(() =>
      _i34.MyNotificationsRepository(
          get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i35.MyOrdersRepository>(() =>
      _i35.MyOrdersRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i36.NotificationRepo>(() =>
      _i36.NotificationRepo(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i37.SplashScreen>(() => _i37.SplashScreen(
      get<_i25.AuthService>(), get<_i8.LocalizationService>()));
  gh.factory<_i38.StoresManager>(
      () => _i38.StoresManager(get<_i21.StoresRepository>()));
  gh.factory<_i39.StoresRepository>(() =>
      _i39.StoresRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i40.StoresService>(
      () => _i40.StoresService(get<_i38.StoresManager>()));
  gh.factory<_i41.StoresStateManager>(
      () => _i41.StoresStateManager(get<_i40.StoresService>()));
  gh.factory<_i42.AboutManager>(
      () => _i42.AboutManager(get<_i23.AboutRepository>()));
  gh.factory<_i43.AboutService>(
      () => _i43.AboutService(get<_i42.AboutManager>()));
  gh.factory<_i44.BalanceManager>(
      () => _i44.BalanceManager(get<_i26.BalanceRepository>()));
  gh.factory<_i45.BalanceService>(
      () => _i45.BalanceService(get<_i44.BalanceManager>()));
  gh.factory<_i46.BalanceStateManager>(() => _i46.BalanceStateManager(
      get<_i45.BalanceService>(), get<_i25.AuthService>()));
  gh.factory<_i47.CategoriesManager>(
      () => _i47.CategoriesManager(get<_i27.CategoriesRepository>()));
  gh.factory<_i48.CategoriesService>(
      () => _i48.CategoriesService(get<_i47.CategoriesManager>()));
  gh.factory<_i49.ChatManager>(
      () => _i49.ChatManager(get<_i28.ChatRepository>()));
  gh.factory<_i50.ChatService>(() => _i50.ChatService(get<_i49.ChatManager>()));
  gh.factory<_i51.ChatStateManager>(
      () => _i51.ChatStateManager(get<_i50.ChatService>()));
  gh.factory<_i52.FireNotificationService>(() => _i52.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i36.NotificationRepo>()));
  gh.factory<_i53.ForgotPassScreen>(
      () => _i53.ForgotPassScreen(get<_i29.ForgotPassStateManager>()));
  gh.factory<_i54.HomeManager>(
      () => _i54.HomeManager(get<_i30.HomeRepository>()));
  gh.factory<_i55.HomeService>(() => _i55.HomeService(get<_i54.HomeManager>()));
  gh.factory<_i56.InitAccountManager>(
      () => _i56.InitAccountManager(get<_i32.InitAccountRepository>()));
  gh.factory<_i57.InitAccountService>(
      () => _i57.InitAccountService(get<_i56.InitAccountManager>()));
  gh.factory<_i58.InitAccountStateManager>(() => _i58.InitAccountStateManager(
      get<_i57.InitAccountService>(),
      get<_i25.AuthService>(),
      get<_i31.ImageUploadService>(),
      get<_i48.CategoriesService>()));
  gh.factory<_i59.LoginScreen>(
      () => _i59.LoginScreen(get<_i33.LoginStateManager>()));
  gh.factory<_i60.MyNotificationsManager>(
      () => _i60.MyNotificationsManager(get<_i34.MyNotificationsRepository>()));
  gh.factory<_i61.MyNotificationsService>(
      () => _i61.MyNotificationsService(get<_i60.MyNotificationsManager>()));
  gh.factory<_i62.MyNotificationsStateManager>(() =>
      _i62.MyNotificationsStateManager(
          get<_i61.MyNotificationsService>(), get<_i25.AuthService>()));
  gh.factory<_i63.MyOrdersManager>(
      () => _i63.MyOrdersManager(get<_i35.MyOrdersRepository>()));
  gh.factory<_i64.OrdersService>(
      () => _i64.OrdersService(get<_i63.MyOrdersManager>()));
  gh.factory<_i65.RegisterStateManager>(() => _i65.RegisterStateManager(
      get<_i25.AuthService>(), get<_i43.AboutService>()));
  gh.factory<_i66.SettingsScreen>(() => _i66.SettingsScreen(
      get<_i25.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i52.FireNotificationService>()));
  gh.factory<_i67.SplashModule>(
      () => _i67.SplashModule(get<_i37.SplashScreen>()));
  gh.factory<_i68.StoreManager>(
      () => _i68.StoreManager(get<_i39.StoresRepository>()));
  gh.factory<_i69.StoresScreen>(() => _i69.StoresScreen(
      get<_i41.StoresStateManager>(), get<_i25.AuthService>()));
  gh.factory<_i70.StoresService>(
      () => _i70.StoresService(get<_i68.StoreManager>()));
  gh.factory<_i71.AboutScreenStateManager>(
      () => _i71.AboutScreenStateManager(get<_i43.AboutService>()));
  gh.factory<_i72.BalanceScreen>(
      () => _i72.BalanceScreen(get<_i46.BalanceStateManager>()));
  gh.factory<_i73.ChatPage>(() => _i73.ChatPage(
      get<_i51.ChatStateManager>(),
      get<_i31.ImageUploadService>(),
      get<_i25.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i74.HomeStateManager>(() => _i74.HomeStateManager(
      get<_i55.HomeService>(), get<_i70.StoresService>()));
  gh.factory<_i75.InitAccountScreen>(
      () => _i75.InitAccountScreen(get<_i58.InitAccountStateManager>()));
  gh.factory<_i76.MyNotificationsScreen>(() =>
      _i76.MyNotificationsScreen(get<_i62.MyNotificationsStateManager>()));
  gh.factory<_i77.MyOrdersStateManager>(() => _i77.MyOrdersStateManager(
      get<_i64.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i78.OnGoingOrdersStateManager>(() =>
      _i78.OnGoingOrdersStateManager(
          get<_i64.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i79.OrderDetailsStateManager>(
      () => _i79.OrderDetailsStateManager(get<_i64.OrdersService>()));
  gh.factory<_i80.OrderTimeLineStateManager>(
      () => _i80.OrderTimeLineStateManager(get<_i64.OrdersService>()));
  gh.factory<_i81.OrderWithoutPendingStateManager>(() =>
      _i81.OrderWithoutPendingStateManager(
          get<_i64.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i82.OrdersScreen>(
      () => _i82.OrdersScreen(get<_i77.MyOrdersStateManager>()));
  gh.factory<_i83.OrdersWithoutPendingScreen>(() =>
      _i83.OrdersWithoutPendingScreen(
          get<_i81.OrderWithoutPendingStateManager>()));
  gh.factory<_i84.ProductsCategoryStateManager>(() =>
      _i84.ProductsCategoryStateManager(
          get<_i48.CategoriesService>(),
          get<_i25.AuthService>(),
          get<_i31.ImageUploadService>(),
          get<_i70.StoresService>(),
          get<_i8.LocalizationService>()));
  gh.factory<_i85.RegisterScreen>(
      () => _i85.RegisterScreen(get<_i65.RegisterStateManager>()));
  gh.factory<_i86.SettingsModule>(
      () => _i86.SettingsModule(get<_i66.SettingsScreen>()));
  gh.factory<_i87.StoreProductsStateManager>(() =>
      _i87.StoreProductsStateManager(
          get<_i48.CategoriesService>(),
          get<_i25.AuthService>(),
          get<_i70.StoresService>(),
          get<_i31.ImageUploadService>(),
          get<_i8.LocalizationService>()));
  gh.factory<_i88.StoreProfileStateManager>(() => _i88.StoreProfileStateManager(
      get<_i70.StoresService>(),
      get<_i31.ImageUploadService>(),
      get<_i25.AuthService>()));
  gh.factory<_i89.StoresModule>(
      () => _i89.StoresModule(get<_i69.StoresScreen>()));
  gh.factory<_i90.AboutScreen>(
      () => _i90.AboutScreen(get<_i71.AboutScreenStateManager>()));
  gh.factory<_i91.AuthorizationModule>(() => _i91.AuthorizationModule(
      get<_i59.LoginScreen>(),
      get<_i85.RegisterScreen>(),
      get<_i53.ForgotPassScreen>()));
  gh.factory<_i92.BalanceModule>(
      () => _i92.BalanceModule(get<_i72.BalanceScreen>()));
  gh.factory<_i93.ChatModule>(
      () => _i93.ChatModule(get<_i73.ChatPage>(), get<_i25.AuthService>()));
  gh.factory<_i94.HomeScreen>(() =>
      _i94.HomeScreen(get<_i74.HomeStateManager>(), get<_i25.AuthService>()));
  gh.factory<_i95.InitAccountModule>(
      () => _i95.InitAccountModule(get<_i75.InitAccountScreen>()));
  gh.factory<_i96.MyNotificationsModule>(
      () => _i96.MyNotificationsModule(get<_i76.MyNotificationsScreen>()));
  gh.factory<_i97.OnGoingOrdersScreen>(
      () => _i97.OnGoingOrdersScreen(get<_i78.OnGoingOrdersStateManager>()));
  gh.factory<_i98.OrderDetailsScreen>(
      () => _i98.OrderDetailsScreen(get<_i79.OrderDetailsStateManager>()));
  gh.factory<_i99.OrderTimLineScreen>(
      () => _i99.OrderTimLineScreen(get<_i80.OrderTimeLineStateManager>()));
  gh.factory<_i100.OrdersModule>(() => _i100.OrdersModule(
      get<_i82.OrdersScreen>(),
      get<_i98.OrderDetailsScreen>(),
      get<_i97.OnGoingOrdersScreen>(),
      get<_i99.OrderTimLineScreen>(),
      get<_i83.OrdersWithoutPendingScreen>()));
  gh.factory<_i101.ProductCategoriesScreen>(() => _i101.ProductCategoriesScreen(
      get<_i84.ProductsCategoryStateManager>(),
      get<_i8.LocalizationService>(),
      get<_i48.CategoriesService>()));
  gh.factory<_i102.StoreInfoScreen>(
      () => _i102.StoreInfoScreen(get<_i88.StoreProfileStateManager>()));
  gh.factory<_i103.StoreProductScreen>(() => _i103.StoreProductScreen(
      get<_i87.StoreProductsStateManager>(), get<_i48.CategoriesService>()));
  gh.factory<_i104.StoresProfileModule>(
      () => _i104.StoresProfileModule(get<_i102.StoreInfoScreen>()));
  gh.factory<_i105.AboutModule>(
      () => _i105.AboutModule(get<_i90.AboutScreen>()));
  gh.factory<_i106.CategoriesModule>(() => _i106.CategoriesModule(
      get<_i101.ProductCategoriesScreen>(), get<_i103.StoreProductScreen>()));
  gh.factory<_i107.HomeModule>(() => _i107.HomeModule(get<_i94.HomeScreen>()));
  gh.factory<_i108.MyApp>(() => _i108.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i52.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i67.SplashModule>(),
      get<_i91.AuthorizationModule>(),
      get<_i86.SettingsModule>(),
      get<_i93.ChatModule>(),
      get<_i105.AboutModule>(),
      get<_i95.InitAccountModule>(),
      get<_i19.MainModule>(),
      get<_i89.StoresModule>(),
      get<_i100.OrdersModule>(),
      get<_i106.CategoriesModule>(),
      get<_i104.StoresProfileModule>(),
      get<_i92.BalanceModule>(),
      get<_i20.PrivacyModule>(),
      get<_i96.MyNotificationsModule>()));
  gh.singleton<_i109.GlobalStateManager>(_i109.GlobalStateManager());
  return get;
}
