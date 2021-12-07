// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i96;
import '../module_about/about_module.dart' as _i93;
import '../module_about/manager/about_manager.dart' as _i36;
import '../module_about/repository/about_repository.dart' as _i19;
import '../module_about/service/about_service/about_service.dart' as _i37;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i61;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i79;
import '../module_auth/authoriazation_module.dart' as _i80;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i20;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i21;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i28;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i55;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i52;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i74;
import '../module_balance/balance_module.dart' as _i81;
import '../module_balance/manager/balance_manager.dart' as _i38;
import '../module_balance/repository/balance_repository.dart' as _i22;
import '../module_balance/service/balance_service.dart' as _i39;
import '../module_balance/state_manager/balance_state_manager.dart' as _i40;
import '../module_balance/ui/screen/balance_info_screen.dart' as _i62;
import '../module_categories/categories_module.dart' as _i94;
import '../module_categories/manager/categories_manager.dart' as _i41;
import '../module_categories/repository/categories_repository.dart' as _i23;
import '../module_categories/service/store_categories_service.dart' as _i42;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i73;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i76;
import '../module_categories/ui/screen/product_categories_screen.dart' as _i89;
import '../module_categories/ui/screen/store_products_screen.dart' as _i91;
import '../module_chat/chat_module.dart' as _i82;
import '../module_chat/manager/chat/chat_manager.dart' as _i43;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i24;
import '../module_chat/service/chat/char_service.dart' as _i44;
import '../module_chat/state_manager/chat_state_manager.dart' as _i45;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i63;
import '../module_home/home_module.dart' as _i95;
import '../module_home/manager/home_manager.dart' as _i47;
import '../module_home/repository/home_repository.dart' as _i25;
import '../module_home/sceen/home_screen.dart' as _i83;
import '../module_home/service/home_service.dart' as _i48;
import '../module_home/state_manager/home_state_manager.dart' as _i64;
import '../module_init/init_account_module.dart' as _i84;
import '../module_init/manager/init_account/init_account.manager.dart' as _i49;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i27;
import '../module_init/service/init_account/init_account.service.dart' as _i50;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i51;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i65;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_main/main_module.dart' as _i16;
import '../module_main/ui/screen/main_screen.dart' as _i9;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i30;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i46;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_orders/manager/my_orders_manager.dart' as _i53;
import '../module_orders/orders_module.dart' as _i88;
import '../module_orders/repository/orders_repository.dart' as _i29;
import '../module_orders/service/orders_service.dart' as _i54;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i66;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i67;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i68;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i69;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i70;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i71;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i85;
import '../module_orders/ui/screen/order_details_screen.dart' as _i86;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i87;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i72;
import '../module_profile/manager/stores_manager.dart' as _i58;
import '../module_profile/repository/stores_repository.dart' as _i33;
import '../module_profile/service/store_service.dart' as _i60;
import '../module_profile/state_manager/store_profile_state_manager.dart'
    as _i77;
import '../module_profile/stores_module.dart' as _i92;
import '../module_profile/ui/screen/store_info_screen.dart' as _i90;
import '../module_settings/settings_module.dart' as _i75;
import '../module_settings/ui/settings_page/settings_page.dart' as _i56;
import '../module_splash/splash_module.dart' as _i57;
import '../module_splash/ui/screen/splash_screen.dart' as _i31;
import '../module_stores/manager/stores_manager.dart' as _i32;
import '../module_stores/repository/stores_repository.dart' as _i17;
import '../module_stores/service/stores_service.dart' as _i34;
import '../module_stores/state_manager/stores_state_manager.dart' as _i35;
import '../module_stores/stores_module.dart' as _i78;
import '../module_stores/ui/screen/stores_screen.dart' as _i59;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i18;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i26;
import '../utils/global/global_state_manager.dart' as _i97;
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
  gh.factory<_i9.MainScreen>(() => _i9.MainScreen());
  gh.factory<_i10.NotificationsPrefsHelper>(
      () => _i10.NotificationsPrefsHelper());
  gh.factory<_i11.ThemePreferencesHelper>(() => _i11.ThemePreferencesHelper());
  gh.factory<_i12.UploadRepository>(() => _i12.UploadRepository());
  gh.factory<_i13.ApiClient>(() => _i13.ApiClient(get<_i8.Logger>()));
  gh.factory<_i14.AppThemeDataService>(
      () => _i14.AppThemeDataService(get<_i11.ThemePreferencesHelper>()));
  gh.factory<_i15.AuthRepository>(
      () => _i15.AuthRepository(get<_i13.ApiClient>(), get<_i8.Logger>()));
  gh.factory<_i16.MainModule>(() => _i16.MainModule(get<_i9.MainScreen>()));
  gh.factory<_i17.StoresRepository>(
      () => _i17.StoresRepository(get<_i13.ApiClient>()));
  gh.factory<_i18.UploadManager>(
      () => _i18.UploadManager(get<_i12.UploadRepository>()));
  gh.factory<_i19.AboutRepository>(
      () => _i19.AboutRepository(get<_i13.ApiClient>()));
  gh.factory<_i20.AuthManager>(
      () => _i20.AuthManager(get<_i15.AuthRepository>()));
  gh.factory<_i21.AuthService>(() =>
      _i21.AuthService(get<_i3.AuthPrefsHelper>(), get<_i20.AuthManager>()));
  gh.factory<_i22.BalanceRepository>(() =>
      _i22.BalanceRepository(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i23.CategoriesRepository>(() => _i23.CategoriesRepository(
      get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i24.ChatRepository>(() =>
      _i24.ChatRepository(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i25.HomeRepository>(() =>
      _i25.HomeRepository(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i26.ImageUploadService>(
      () => _i26.ImageUploadService(get<_i18.UploadManager>()));
  gh.factory<_i27.InitAccountRepository>(() => _i27.InitAccountRepository(
      get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i28.LoginStateManager>(
      () => _i28.LoginStateManager(get<_i21.AuthService>()));
  gh.factory<_i29.MyOrdersRepository>(() =>
      _i29.MyOrdersRepository(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i30.NotificationRepo>(() =>
      _i30.NotificationRepo(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i31.SplashScreen>(() => _i31.SplashScreen(
      get<_i21.AuthService>(), get<_i7.LocalizationService>()));
  gh.factory<_i32.StoresManager>(
      () => _i32.StoresManager(get<_i17.StoresRepository>()));
  gh.factory<_i33.StoresRepository>(() =>
      _i33.StoresRepository(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i34.StoresService>(
      () => _i34.StoresService(get<_i32.StoresManager>()));
  gh.factory<_i35.StoresStateManager>(
      () => _i35.StoresStateManager(get<_i34.StoresService>()));
  gh.factory<_i36.AboutManager>(
      () => _i36.AboutManager(get<_i19.AboutRepository>()));
  gh.factory<_i37.AboutService>(
      () => _i37.AboutService(get<_i36.AboutManager>()));
  gh.factory<_i38.BalanceManager>(
      () => _i38.BalanceManager(get<_i22.BalanceRepository>()));
  gh.factory<_i39.BalanceService>(
      () => _i39.BalanceService(get<_i38.BalanceManager>()));
  gh.factory<_i40.BalanceStateManager>(() => _i40.BalanceStateManager(
      get<_i39.BalanceService>(), get<_i21.AuthService>()));
  gh.factory<_i41.CategoriesManager>(
      () => _i41.CategoriesManager(get<_i23.CategoriesRepository>()));
  gh.factory<_i42.CategoriesService>(
      () => _i42.CategoriesService(get<_i41.CategoriesManager>()));
  gh.factory<_i43.ChatManager>(
      () => _i43.ChatManager(get<_i24.ChatRepository>()));
  gh.factory<_i44.ChatService>(() => _i44.ChatService(get<_i43.ChatManager>()));
  gh.factory<_i45.ChatStateManager>(
      () => _i45.ChatStateManager(get<_i44.ChatService>()));
  gh.factory<_i46.FireNotificationService>(() => _i46.FireNotificationService(
      get<_i10.NotificationsPrefsHelper>(), get<_i30.NotificationRepo>()));
  gh.factory<_i47.HomeManager>(
      () => _i47.HomeManager(get<_i25.HomeRepository>()));
  gh.factory<_i48.HomeService>(() => _i48.HomeService(get<_i47.HomeManager>()));
  gh.factory<_i49.InitAccountManager>(
      () => _i49.InitAccountManager(get<_i27.InitAccountRepository>()));
  gh.factory<_i50.InitAccountService>(
      () => _i50.InitAccountService(get<_i49.InitAccountManager>()));
  gh.factory<_i51.InitAccountStateManager>(() => _i51.InitAccountStateManager(
      get<_i50.InitAccountService>(),
      get<_i21.AuthService>(),
      get<_i26.ImageUploadService>(),
      get<_i42.CategoriesService>()));
  gh.factory<_i52.LoginScreen>(
      () => _i52.LoginScreen(get<_i28.LoginStateManager>()));
  gh.factory<_i53.MyOrdersManager>(
      () => _i53.MyOrdersManager(get<_i29.MyOrdersRepository>()));
  gh.factory<_i54.OrdersService>(
      () => _i54.OrdersService(get<_i53.MyOrdersManager>()));
  gh.factory<_i55.RegisterStateManager>(() => _i55.RegisterStateManager(
      get<_i21.AuthService>(), get<_i37.AboutService>()));
  gh.factory<_i56.SettingsScreen>(() => _i56.SettingsScreen(
      get<_i21.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i46.FireNotificationService>()));
  gh.factory<_i57.SplashModule>(
      () => _i57.SplashModule(get<_i31.SplashScreen>()));
  gh.factory<_i58.StoreManager>(
      () => _i58.StoreManager(get<_i33.StoresRepository>()));
  gh.factory<_i59.StoresScreen>(() => _i59.StoresScreen(
      get<_i35.StoresStateManager>(), get<_i21.AuthService>()));
  gh.factory<_i60.StoresService>(
      () => _i60.StoresService(get<_i58.StoreManager>()));
  gh.factory<_i61.AboutScreenStateManager>(
      () => _i61.AboutScreenStateManager(get<_i37.AboutService>()));
  gh.factory<_i62.BalanceScreen>(
      () => _i62.BalanceScreen(get<_i40.BalanceStateManager>()));
  gh.factory<_i63.ChatPage>(() => _i63.ChatPage(
      get<_i45.ChatStateManager>(),
      get<_i26.ImageUploadService>(),
      get<_i21.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i64.HomeStateManager>(() => _i64.HomeStateManager(
      get<_i48.HomeService>(), get<_i60.StoresService>()));
  gh.factory<_i65.InitAccountScreen>(
      () => _i65.InitAccountScreen(get<_i51.InitAccountStateManager>()));
  gh.factory<_i66.MyOrdersStateManager>(() => _i66.MyOrdersStateManager(
      get<_i54.OrdersService>(), get<_i21.AuthService>()));
  gh.factory<_i67.OnGoingOrdersStateManager>(() =>
      _i67.OnGoingOrdersStateManager(
          get<_i54.OrdersService>(), get<_i21.AuthService>()));
  gh.factory<_i68.OrderDetailsStateManager>(
      () => _i68.OrderDetailsStateManager(get<_i54.OrdersService>()));
  gh.factory<_i69.OrderTimeLineStateManager>(
      () => _i69.OrderTimeLineStateManager(get<_i54.OrdersService>()));
  gh.factory<_i70.OrderWithoutPendingStateManager>(() =>
      _i70.OrderWithoutPendingStateManager(
          get<_i54.OrdersService>(), get<_i21.AuthService>()));
  gh.factory<_i71.OrdersScreen>(
      () => _i71.OrdersScreen(get<_i66.MyOrdersStateManager>()));
  gh.factory<_i72.OrdersWithoutPendingScreen>(() =>
      _i72.OrdersWithoutPendingScreen(
          get<_i70.OrderWithoutPendingStateManager>()));
  gh.factory<_i73.ProductsCategoryStateManager>(() =>
      _i73.ProductsCategoryStateManager(
          get<_i42.CategoriesService>(),
          get<_i21.AuthService>(),
          get<_i26.ImageUploadService>(),
          get<_i60.StoresService>()));
  gh.factory<_i74.RegisterScreen>(
      () => _i74.RegisterScreen(get<_i55.RegisterStateManager>()));
  gh.factory<_i75.SettingsModule>(
      () => _i75.SettingsModule(get<_i56.SettingsScreen>()));
  gh.factory<_i76.StoreProductsStateManager>(() =>
      _i76.StoreProductsStateManager(get<_i42.CategoriesService>(),
          get<_i21.AuthService>(), get<_i60.StoresService>()));
  gh.factory<_i77.StoreProfileStateManager>(() => _i77.StoreProfileStateManager(
      get<_i60.StoresService>(),
      get<_i26.ImageUploadService>(),
      get<_i21.AuthService>()));
  gh.factory<_i78.StoresModule>(
      () => _i78.StoresModule(get<_i59.StoresScreen>()));
  gh.factory<_i79.AboutScreen>(
      () => _i79.AboutScreen(get<_i61.AboutScreenStateManager>()));
  gh.factory<_i80.AuthorizationModule>(() => _i80.AuthorizationModule(
      get<_i52.LoginScreen>(), get<_i74.RegisterScreen>()));
  gh.factory<_i81.BalanceModule>(
      () => _i81.BalanceModule(get<_i62.BalanceScreen>()));
  gh.factory<_i82.ChatModule>(
      () => _i82.ChatModule(get<_i63.ChatPage>(), get<_i21.AuthService>()));
  gh.factory<_i83.HomeScreen>(() =>
      _i83.HomeScreen(get<_i64.HomeStateManager>(), get<_i21.AuthService>()));
  gh.factory<_i84.InitAccountModule>(
      () => _i84.InitAccountModule(get<_i65.InitAccountScreen>()));
  gh.factory<_i85.OnGoingOrdersScreen>(
      () => _i85.OnGoingOrdersScreen(get<_i67.OnGoingOrdersStateManager>()));
  gh.factory<_i86.OrderDetailsScreen>(
      () => _i86.OrderDetailsScreen(get<_i68.OrderDetailsStateManager>()));
  gh.factory<_i87.OrderTimLineScreen>(
      () => _i87.OrderTimLineScreen(get<_i69.OrderTimeLineStateManager>()));
  gh.factory<_i88.OrdersModule>(() => _i88.OrdersModule(
      get<_i71.OrdersScreen>(),
      get<_i86.OrderDetailsScreen>(),
      get<_i85.OnGoingOrdersScreen>(),
      get<_i87.OrderTimLineScreen>(),
      get<_i72.OrdersWithoutPendingScreen>()));
  gh.factory<_i89.ProductCategoriesScreen>(() =>
      _i89.ProductCategoriesScreen(get<_i73.ProductsCategoryStateManager>()));
  gh.factory<_i90.StoreInfoScreen>(
      () => _i90.StoreInfoScreen(get<_i77.StoreProfileStateManager>()));
  gh.factory<_i91.StoreProductScreen>(
      () => _i91.StoreProductScreen(get<_i76.StoreProductsStateManager>()));
  gh.factory<_i92.StoresProfileModule>(
      () => _i92.StoresProfileModule(get<_i90.StoreInfoScreen>()));
  gh.factory<_i93.AboutModule>(() => _i93.AboutModule(get<_i79.AboutScreen>()));
  gh.factory<_i94.CategoriesModule>(() => _i94.CategoriesModule(
      get<_i89.ProductCategoriesScreen>(), get<_i91.StoreProductScreen>()));
  gh.factory<_i95.HomeModule>(() => _i95.HomeModule(get<_i83.HomeScreen>()));
  gh.factory<_i96.MyApp>(() => _i96.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i46.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i57.SplashModule>(),
      get<_i80.AuthorizationModule>(),
      get<_i75.SettingsModule>(),
      get<_i82.ChatModule>(),
      get<_i93.AboutModule>(),
      get<_i84.InitAccountModule>(),
      get<_i16.MainModule>(),
      get<_i78.StoresModule>(),
      get<_i88.OrdersModule>(),
      get<_i94.CategoriesModule>(),
      get<_i92.StoresProfileModule>(),
      get<_i81.BalanceModule>()));
  gh.singleton<_i97.GlobalStateManager>(_i97.GlobalStateManager());
  return get;
}
