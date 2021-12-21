// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i100;
import '../module_about/about_module.dart' as _i97;
import '../module_about/manager/about_manager.dart' as _i40;
import '../module_about/repository/about_repository.dart' as _i23;
import '../module_about/service/about_service/about_service.dart' as _i41;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i65;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i83;
import '../module_auth/authoriazation_module.dart' as _i84;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i24;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i25;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i32;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i59;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i56;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i78;
import '../module_balance/balance_module.dart' as _i85;
import '../module_balance/manager/balance_manager.dart' as _i42;
import '../module_balance/repository/balance_repository.dart' as _i26;
import '../module_balance/service/balance_service.dart' as _i43;
import '../module_balance/state_manager/balance_state_manager.dart' as _i44;
import '../module_balance/ui/screen/balance_info_screen.dart' as _i66;
import '../module_categories/categories_module.dart' as _i98;
import '../module_categories/manager/categories_manager.dart' as _i45;
import '../module_categories/repository/categories_repository.dart' as _i27;
import '../module_categories/service/store_categories_service.dart' as _i46;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i77;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i80;
import '../module_categories/ui/screen/product_categories_screen.dart' as _i93;
import '../module_categories/ui/screen/store_products_screen.dart' as _i95;
import '../module_chat/chat_module.dart' as _i86;
import '../module_chat/manager/chat/chat_manager.dart' as _i47;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i28;
import '../module_chat/service/chat/char_service.dart' as _i48;
import '../module_chat/state_manager/chat_state_manager.dart' as _i49;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i67;
import '../module_home/home_module.dart' as _i99;
import '../module_home/manager/home_manager.dart' as _i51;
import '../module_home/repository/home_repository.dart' as _i29;
import '../module_home/sceen/home_screen.dart' as _i87;
import '../module_home/service/home_service.dart' as _i52;
import '../module_home/state_manager/home_state_manager.dart' as _i68;
import '../module_init/init_account_module.dart' as _i88;
import '../module_init/manager/init_account/init_account.manager.dart' as _i53;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i31;
import '../module_init/service/init_account/init_account.service.dart' as _i54;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i55;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i69;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_main/main_module.dart' as _i19;
import '../module_main/ui/screen/main_screen.dart' as _i10;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i34;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i50;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_orders/manager/my_orders_manager.dart' as _i57;
import '../module_orders/orders_module.dart' as _i92;
import '../module_orders/repository/orders_repository.dart' as _i33;
import '../module_orders/service/orders_service.dart' as _i58;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i70;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i71;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i72;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i73;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i74;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i75;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i89;
import '../module_orders/ui/screen/order_details_screen.dart' as _i90;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i91;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i76;
import '../module_privacy/privacy_module.dart' as _i20;
import '../module_privacy/ui/policies_page/about_page.dart' as _i3;
import '../module_privacy/ui/policies_page/policy_page.dart' as _i12;
import '../module_privacy/ui/policies_page/terms_page.dart' as _i13;
import '../module_profile/manager/stores_manager.dart' as _i62;
import '../module_profile/repository/stores_repository.dart' as _i37;
import '../module_profile/service/store_service.dart' as _i64;
import '../module_profile/state_manager/store_profile_state_manager.dart'
    as _i81;
import '../module_profile/stores_module.dart' as _i96;
import '../module_profile/ui/screen/store_info_screen.dart' as _i94;
import '../module_settings/settings_module.dart' as _i79;
import '../module_settings/ui/settings_page/settings_page.dart' as _i60;
import '../module_splash/splash_module.dart' as _i61;
import '../module_splash/ui/screen/splash_screen.dart' as _i35;
import '../module_stores/manager/stores_manager.dart' as _i36;
import '../module_stores/repository/stores_repository.dart' as _i21;
import '../module_stores/service/stores_service.dart' as _i38;
import '../module_stores/state_manager/stores_state_manager.dart' as _i39;
import '../module_stores/stores_module.dart' as _i82;
import '../module_stores/ui/screen/stores_screen.dart' as _i63;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i22;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i30;
import '../utils/global/global_state_manager.dart' as _i101;
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
  gh.factory<_i29.HomeRepository>(() =>
      _i29.HomeRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i30.ImageUploadService>(
      () => _i30.ImageUploadService(get<_i22.UploadManager>()));
  gh.factory<_i31.InitAccountRepository>(() => _i31.InitAccountRepository(
      get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i32.LoginStateManager>(
      () => _i32.LoginStateManager(get<_i25.AuthService>()));
  gh.factory<_i33.MyOrdersRepository>(() =>
      _i33.MyOrdersRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i34.NotificationRepo>(() =>
      _i34.NotificationRepo(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i35.SplashScreen>(() => _i35.SplashScreen(
      get<_i25.AuthService>(), get<_i8.LocalizationService>()));
  gh.factory<_i36.StoresManager>(
      () => _i36.StoresManager(get<_i21.StoresRepository>()));
  gh.factory<_i37.StoresRepository>(() =>
      _i37.StoresRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i38.StoresService>(
      () => _i38.StoresService(get<_i36.StoresManager>()));
  gh.factory<_i39.StoresStateManager>(
      () => _i39.StoresStateManager(get<_i38.StoresService>()));
  gh.factory<_i40.AboutManager>(
      () => _i40.AboutManager(get<_i23.AboutRepository>()));
  gh.factory<_i41.AboutService>(
      () => _i41.AboutService(get<_i40.AboutManager>()));
  gh.factory<_i42.BalanceManager>(
      () => _i42.BalanceManager(get<_i26.BalanceRepository>()));
  gh.factory<_i43.BalanceService>(
      () => _i43.BalanceService(get<_i42.BalanceManager>()));
  gh.factory<_i44.BalanceStateManager>(() => _i44.BalanceStateManager(
      get<_i43.BalanceService>(), get<_i25.AuthService>()));
  gh.factory<_i45.CategoriesManager>(
      () => _i45.CategoriesManager(get<_i27.CategoriesRepository>()));
  gh.factory<_i46.CategoriesService>(
      () => _i46.CategoriesService(get<_i45.CategoriesManager>()));
  gh.factory<_i47.ChatManager>(
      () => _i47.ChatManager(get<_i28.ChatRepository>()));
  gh.factory<_i48.ChatService>(() => _i48.ChatService(get<_i47.ChatManager>()));
  gh.factory<_i49.ChatStateManager>(
      () => _i49.ChatStateManager(get<_i48.ChatService>()));
  gh.factory<_i50.FireNotificationService>(() => _i50.FireNotificationService(
      get<_i11.NotificationsPrefsHelper>(), get<_i34.NotificationRepo>()));
  gh.factory<_i51.HomeManager>(
      () => _i51.HomeManager(get<_i29.HomeRepository>()));
  gh.factory<_i52.HomeService>(() => _i52.HomeService(get<_i51.HomeManager>()));
  gh.factory<_i53.InitAccountManager>(
      () => _i53.InitAccountManager(get<_i31.InitAccountRepository>()));
  gh.factory<_i54.InitAccountService>(
      () => _i54.InitAccountService(get<_i53.InitAccountManager>()));
  gh.factory<_i55.InitAccountStateManager>(() => _i55.InitAccountStateManager(
      get<_i54.InitAccountService>(),
      get<_i25.AuthService>(),
      get<_i30.ImageUploadService>(),
      get<_i46.CategoriesService>()));
  gh.factory<_i56.LoginScreen>(
      () => _i56.LoginScreen(get<_i32.LoginStateManager>()));
  gh.factory<_i57.MyOrdersManager>(
      () => _i57.MyOrdersManager(get<_i33.MyOrdersRepository>()));
  gh.factory<_i58.OrdersService>(
      () => _i58.OrdersService(get<_i57.MyOrdersManager>()));
  gh.factory<_i59.RegisterStateManager>(() => _i59.RegisterStateManager(
      get<_i25.AuthService>(), get<_i41.AboutService>()));
  gh.factory<_i60.SettingsScreen>(() => _i60.SettingsScreen(
      get<_i25.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i50.FireNotificationService>()));
  gh.factory<_i61.SplashModule>(
      () => _i61.SplashModule(get<_i35.SplashScreen>()));
  gh.factory<_i62.StoreManager>(
      () => _i62.StoreManager(get<_i37.StoresRepository>()));
  gh.factory<_i63.StoresScreen>(() => _i63.StoresScreen(
      get<_i39.StoresStateManager>(), get<_i25.AuthService>()));
  gh.factory<_i64.StoresService>(
      () => _i64.StoresService(get<_i62.StoreManager>()));
  gh.factory<_i65.AboutScreenStateManager>(
      () => _i65.AboutScreenStateManager(get<_i41.AboutService>()));
  gh.factory<_i66.BalanceScreen>(
      () => _i66.BalanceScreen(get<_i44.BalanceStateManager>()));
  gh.factory<_i67.ChatPage>(() => _i67.ChatPage(
      get<_i49.ChatStateManager>(),
      get<_i30.ImageUploadService>(),
      get<_i25.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i68.HomeStateManager>(() => _i68.HomeStateManager(
      get<_i52.HomeService>(), get<_i64.StoresService>()));
  gh.factory<_i69.InitAccountScreen>(
      () => _i69.InitAccountScreen(get<_i55.InitAccountStateManager>()));
  gh.factory<_i70.MyOrdersStateManager>(() => _i70.MyOrdersStateManager(
      get<_i58.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i71.OnGoingOrdersStateManager>(() =>
      _i71.OnGoingOrdersStateManager(
          get<_i58.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i72.OrderDetailsStateManager>(
      () => _i72.OrderDetailsStateManager(get<_i58.OrdersService>()));
  gh.factory<_i73.OrderTimeLineStateManager>(
      () => _i73.OrderTimeLineStateManager(get<_i58.OrdersService>()));
  gh.factory<_i74.OrderWithoutPendingStateManager>(() =>
      _i74.OrderWithoutPendingStateManager(
          get<_i58.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i75.OrdersScreen>(
      () => _i75.OrdersScreen(get<_i70.MyOrdersStateManager>()));
  gh.factory<_i76.OrdersWithoutPendingScreen>(() =>
      _i76.OrdersWithoutPendingScreen(
          get<_i74.OrderWithoutPendingStateManager>()));
  gh.factory<_i77.ProductsCategoryStateManager>(() =>
      _i77.ProductsCategoryStateManager(
          get<_i46.CategoriesService>(),
          get<_i25.AuthService>(),
          get<_i30.ImageUploadService>(),
          get<_i64.StoresService>()));
  gh.factory<_i78.RegisterScreen>(
      () => _i78.RegisterScreen(get<_i59.RegisterStateManager>()));
  gh.factory<_i79.SettingsModule>(
      () => _i79.SettingsModule(get<_i60.SettingsScreen>()));
  gh.factory<_i80.StoreProductsStateManager>(() =>
      _i80.StoreProductsStateManager(get<_i46.CategoriesService>(),
          get<_i25.AuthService>(), get<_i64.StoresService>()));
  gh.factory<_i81.StoreProfileStateManager>(() => _i81.StoreProfileStateManager(
      get<_i64.StoresService>(),
      get<_i30.ImageUploadService>(),
      get<_i25.AuthService>()));
  gh.factory<_i82.StoresModule>(
      () => _i82.StoresModule(get<_i63.StoresScreen>()));
  gh.factory<_i83.AboutScreen>(
      () => _i83.AboutScreen(get<_i65.AboutScreenStateManager>()));
  gh.factory<_i84.AuthorizationModule>(() => _i84.AuthorizationModule(
      get<_i56.LoginScreen>(), get<_i78.RegisterScreen>()));
  gh.factory<_i85.BalanceModule>(
      () => _i85.BalanceModule(get<_i66.BalanceScreen>()));
  gh.factory<_i86.ChatModule>(
      () => _i86.ChatModule(get<_i67.ChatPage>(), get<_i25.AuthService>()));
  gh.factory<_i87.HomeScreen>(() =>
      _i87.HomeScreen(get<_i68.HomeStateManager>(), get<_i25.AuthService>()));
  gh.factory<_i88.InitAccountModule>(
      () => _i88.InitAccountModule(get<_i69.InitAccountScreen>()));
  gh.factory<_i89.OnGoingOrdersScreen>(
      () => _i89.OnGoingOrdersScreen(get<_i71.OnGoingOrdersStateManager>()));
  gh.factory<_i90.OrderDetailsScreen>(
      () => _i90.OrderDetailsScreen(get<_i72.OrderDetailsStateManager>()));
  gh.factory<_i91.OrderTimLineScreen>(
      () => _i91.OrderTimLineScreen(get<_i73.OrderTimeLineStateManager>()));
  gh.factory<_i92.OrdersModule>(() => _i92.OrdersModule(
      get<_i75.OrdersScreen>(),
      get<_i90.OrderDetailsScreen>(),
      get<_i89.OnGoingOrdersScreen>(),
      get<_i91.OrderTimLineScreen>(),
      get<_i76.OrdersWithoutPendingScreen>()));
  gh.factory<_i93.ProductCategoriesScreen>(() => _i93.ProductCategoriesScreen(
      get<_i77.ProductsCategoryStateManager>(),
      get<_i8.LocalizationService>()));
  gh.factory<_i94.StoreInfoScreen>(
      () => _i94.StoreInfoScreen(get<_i81.StoreProfileStateManager>()));
  gh.factory<_i95.StoreProductScreen>(
      () => _i95.StoreProductScreen(get<_i80.StoreProductsStateManager>()));
  gh.factory<_i96.StoresProfileModule>(
      () => _i96.StoresProfileModule(get<_i94.StoreInfoScreen>()));
  gh.factory<_i97.AboutModule>(() => _i97.AboutModule(get<_i83.AboutScreen>()));
  gh.factory<_i98.CategoriesModule>(() => _i98.CategoriesModule(
      get<_i93.ProductCategoriesScreen>(), get<_i95.StoreProductScreen>()));
  gh.factory<_i99.HomeModule>(() => _i99.HomeModule(get<_i87.HomeScreen>()));
  gh.factory<_i100.MyApp>(() => _i100.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i50.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i61.SplashModule>(),
      get<_i84.AuthorizationModule>(),
      get<_i79.SettingsModule>(),
      get<_i86.ChatModule>(),
      get<_i97.AboutModule>(),
      get<_i88.InitAccountModule>(),
      get<_i19.MainModule>(),
      get<_i82.StoresModule>(),
      get<_i92.OrdersModule>(),
      get<_i98.CategoriesModule>(),
      get<_i96.StoresProfileModule>(),
      get<_i85.BalanceModule>(),
      get<_i20.PrivacyModule>()));
  gh.singleton<_i101.GlobalStateManager>(_i101.GlobalStateManager());
  return get;
}
