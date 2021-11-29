// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i90;
import '../module_about/about_module.dart' as _i87;
import '../module_about/manager/about_manager.dart' as _i35;
import '../module_about/repository/about_repository.dart' as _i19;
import '../module_about/service/about_service/about_service.dart' as _i36;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i58;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i75;
import '../module_auth/authoriazation_module.dart' as _i76;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i20;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i21;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i51;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i48;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i70;
import '../module_categories/categories_module.dart' as _i88;
import '../module_categories/manager/categories_manager.dart' as _i37;
import '../module_categories/repository/categories_repository.dart' as _i22;
import '../module_categories/service/store_categories_service.dart' as _i38;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i69;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i55;
import '../module_categories/ui/screen/product_categories_screen.dart' as _i84;
import '../module_categories/ui/screen/store_products_screen.dart' as _i72;
import '../module_chat/chat_module.dart' as _i77;
import '../module_chat/manager/chat/chat_manager.dart' as _i39;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i23;
import '../module_chat/service/chat/char_service.dart' as _i40;
import '../module_chat/state_manager/chat_state_manager.dart' as _i41;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i59;
import '../module_home/home_module.dart' as _i89;
import '../module_home/manager/home_manager.dart' as _i43;
import '../module_home/repository/home_repository.dart' as _i24;
import '../module_home/sceen/home_screen.dart' as _i78;
import '../module_home/service/home_service.dart' as _i44;
import '../module_home/state_manager/home_state_manager.dart' as _i60;
import '../module_init/init_account_module.dart' as _i79;
import '../module_init/manager/init_account/init_account.manager.dart' as _i45;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i26;
import '../module_init/service/init_account/init_account.service.dart' as _i46;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i47;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i61;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_main/main_module.dart' as _i16;
import '../module_main/ui/screen/main_screen.dart' as _i9;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i29;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i42;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_orders/manager/my_orders_manager.dart' as _i49;
import '../module_orders/orders_module.dart' as _i83;
import '../module_orders/repository/orders_repository.dart' as _i28;
import '../module_orders/service/orders_service.dart' as _i50;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i62;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i63;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i64;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i65;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i66;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i67;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i80;
import '../module_orders/ui/screen/order_details_screen.dart' as _i81;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i82;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i68;
import '../module_profile/manager/stores_manager.dart' as _i54;
import '../module_profile/repository/stores_repository.dart' as _i32;
import '../module_profile/service/store_service.dart' as _i57;
import '../module_profile/state_manager/store_profile_state_manager.dart'
    as _i73;
import '../module_profile/stores_module.dart' as _i86;
import '../module_profile/ui/screen/store_info_screen.dart' as _i85;
import '../module_settings/settings_module.dart' as _i71;
import '../module_settings/ui/settings_page/settings_page.dart' as _i52;
import '../module_splash/splash_module.dart' as _i53;
import '../module_splash/ui/screen/splash_screen.dart' as _i30;
import '../module_stores/manager/stores_manager.dart' as _i31;
import '../module_stores/repository/stores_repository.dart' as _i17;
import '../module_stores/service/stores_service.dart' as _i33;
import '../module_stores/state_manager/stores_state_manager.dart' as _i34;
import '../module_stores/stores_module.dart' as _i74;
import '../module_stores/ui/screen/stores_screen.dart' as _i56;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i18;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i25;
import '../utils/global/global_state_manager.dart' as _i91;
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
  gh.factory<_i22.CategoriesRepository>(() => _i22.CategoriesRepository(
      get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i23.ChatRepository>(() =>
      _i23.ChatRepository(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i24.HomeRepository>(() =>
      _i24.HomeRepository(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i25.ImageUploadService>(
      () => _i25.ImageUploadService(get<_i18.UploadManager>()));
  gh.factory<_i26.InitAccountRepository>(() => _i26.InitAccountRepository(
      get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i27.LoginStateManager>(
      () => _i27.LoginStateManager(get<_i21.AuthService>()));
  gh.factory<_i28.MyOrdersRepository>(() =>
      _i28.MyOrdersRepository(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i29.NotificationRepo>(() =>
      _i29.NotificationRepo(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i30.SplashScreen>(() => _i30.SplashScreen(
      get<_i21.AuthService>(), get<_i7.LocalizationService>()));
  gh.factory<_i31.StoresManager>(
      () => _i31.StoresManager(get<_i17.StoresRepository>()));
  gh.factory<_i32.StoresRepository>(() =>
      _i32.StoresRepository(get<_i13.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i33.StoresService>(
      () => _i33.StoresService(get<_i31.StoresManager>()));
  gh.factory<_i34.StoresStateManager>(
      () => _i34.StoresStateManager(get<_i33.StoresService>()));
  gh.factory<_i35.AboutManager>(
      () => _i35.AboutManager(get<_i19.AboutRepository>()));
  gh.factory<_i36.AboutService>(
      () => _i36.AboutService(get<_i35.AboutManager>()));
  gh.factory<_i37.CategoriesManager>(
      () => _i37.CategoriesManager(get<_i22.CategoriesRepository>()));
  gh.factory<_i38.CategoriesService>(
      () => _i38.CategoriesService(get<_i37.CategoriesManager>()));
  gh.factory<_i39.ChatManager>(
      () => _i39.ChatManager(get<_i23.ChatRepository>()));
  gh.factory<_i40.ChatService>(() => _i40.ChatService(get<_i39.ChatManager>()));
  gh.factory<_i41.ChatStateManager>(
      () => _i41.ChatStateManager(get<_i40.ChatService>()));
  gh.factory<_i42.FireNotificationService>(() => _i42.FireNotificationService(
      get<_i10.NotificationsPrefsHelper>(), get<_i29.NotificationRepo>()));
  gh.factory<_i43.HomeManager>(
      () => _i43.HomeManager(get<_i24.HomeRepository>()));
  gh.factory<_i44.HomeService>(() => _i44.HomeService(get<_i43.HomeManager>()));
  gh.factory<_i45.InitAccountManager>(
      () => _i45.InitAccountManager(get<_i26.InitAccountRepository>()));
  gh.factory<_i46.InitAccountService>(
      () => _i46.InitAccountService(get<_i45.InitAccountManager>()));
  gh.factory<_i47.InitAccountStateManager>(() => _i47.InitAccountStateManager(
      get<_i46.InitAccountService>(),
      get<_i21.AuthService>(),
      get<_i25.ImageUploadService>(),
      get<_i38.CategoriesService>()));
  gh.factory<_i48.LoginScreen>(
      () => _i48.LoginScreen(get<_i27.LoginStateManager>()));
  gh.factory<_i49.MyOrdersManager>(
      () => _i49.MyOrdersManager(get<_i28.MyOrdersRepository>()));
  gh.factory<_i50.OrdersService>(
      () => _i50.OrdersService(get<_i49.MyOrdersManager>()));
  gh.factory<_i51.RegisterStateManager>(() => _i51.RegisterStateManager(
      get<_i21.AuthService>(), get<_i36.AboutService>()));
  gh.factory<_i52.SettingsScreen>(() => _i52.SettingsScreen(
      get<_i21.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i42.FireNotificationService>()));
  gh.factory<_i53.SplashModule>(
      () => _i53.SplashModule(get<_i30.SplashScreen>()));
  gh.factory<_i54.StoreManager>(
      () => _i54.StoreManager(get<_i32.StoresRepository>()));
  gh.factory<_i55.StoreProductsStateManager>(() =>
      _i55.StoreProductsStateManager(get<_i38.CategoriesService>(),
          get<_i21.AuthService>(), get<_i25.ImageUploadService>()));
  gh.factory<_i56.StoresScreen>(() => _i56.StoresScreen(
      get<_i34.StoresStateManager>(), get<_i21.AuthService>()));
  gh.factory<_i57.StoresService>(
      () => _i57.StoresService(get<_i54.StoreManager>()));
  gh.factory<_i58.AboutScreenStateManager>(
      () => _i58.AboutScreenStateManager(get<_i36.AboutService>()));
  gh.factory<_i59.ChatPage>(() => _i59.ChatPage(
      get<_i41.ChatStateManager>(),
      get<_i25.ImageUploadService>(),
      get<_i21.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i60.HomeStateManager>(() => _i60.HomeStateManager(
      get<_i44.HomeService>(), get<_i57.StoresService>()));
  gh.factory<_i61.InitAccountScreen>(
      () => _i61.InitAccountScreen(get<_i47.InitAccountStateManager>()));
  gh.factory<_i62.MyOrdersStateManager>(() => _i62.MyOrdersStateManager(
      get<_i50.OrdersService>(), get<_i21.AuthService>()));
  gh.factory<_i63.OnGoingOrdersStateManager>(() =>
      _i63.OnGoingOrdersStateManager(
          get<_i50.OrdersService>(), get<_i21.AuthService>()));
  gh.factory<_i64.OrderDetailsStateManager>(
      () => _i64.OrderDetailsStateManager(get<_i50.OrdersService>()));
  gh.factory<_i65.OrderTimeLineStateManager>(
      () => _i65.OrderTimeLineStateManager(get<_i50.OrdersService>()));
  gh.factory<_i66.OrderWithoutPendingStateManager>(() =>
      _i66.OrderWithoutPendingStateManager(
          get<_i50.OrdersService>(), get<_i21.AuthService>()));
  gh.factory<_i67.OrdersScreen>(
      () => _i67.OrdersScreen(get<_i62.MyOrdersStateManager>()));
  gh.factory<_i68.OrdersWithoutPendingScreen>(() =>
      _i68.OrdersWithoutPendingScreen(
          get<_i66.OrderWithoutPendingStateManager>()));
  gh.factory<_i69.ProductsCategoryStateManager>(() =>
      _i69.ProductsCategoryStateManager(
          get<_i38.CategoriesService>(),
          get<_i21.AuthService>(),
          get<_i25.ImageUploadService>(),
          get<_i57.StoresService>()));
  gh.factory<_i70.RegisterScreen>(
      () => _i70.RegisterScreen(get<_i51.RegisterStateManager>()));
  gh.factory<_i71.SettingsModule>(
      () => _i71.SettingsModule(get<_i52.SettingsScreen>()));
  gh.factory<_i72.StoreProductScreen>(
      () => _i72.StoreProductScreen(get<_i55.StoreProductsStateManager>()));
  gh.factory<_i73.StoreProfileStateManager>(() => _i73.StoreProfileStateManager(
      get<_i57.StoresService>(),
      get<_i25.ImageUploadService>(),
      get<_i21.AuthService>()));
  gh.factory<_i74.StoresModule>(
      () => _i74.StoresModule(get<_i56.StoresScreen>()));
  gh.factory<_i75.AboutScreen>(
      () => _i75.AboutScreen(get<_i58.AboutScreenStateManager>()));
  gh.factory<_i76.AuthorizationModule>(() => _i76.AuthorizationModule(
      get<_i48.LoginScreen>(), get<_i70.RegisterScreen>()));
  gh.factory<_i77.ChatModule>(
      () => _i77.ChatModule(get<_i59.ChatPage>(), get<_i21.AuthService>()));
  gh.factory<_i78.HomeScreen>(() =>
      _i78.HomeScreen(get<_i60.HomeStateManager>(), get<_i21.AuthService>()));
  gh.factory<_i79.InitAccountModule>(
      () => _i79.InitAccountModule(get<_i61.InitAccountScreen>()));
  gh.factory<_i80.OnGoingOrdersScreen>(
      () => _i80.OnGoingOrdersScreen(get<_i63.OnGoingOrdersStateManager>()));
  gh.factory<_i81.OrderDetailsScreen>(
      () => _i81.OrderDetailsScreen(get<_i64.OrderDetailsStateManager>()));
  gh.factory<_i82.OrderTimLineScreen>(
      () => _i82.OrderTimLineScreen(get<_i65.OrderTimeLineStateManager>()));
  gh.factory<_i83.OrdersModule>(() => _i83.OrdersModule(
      get<_i67.OrdersScreen>(),
      get<_i81.OrderDetailsScreen>(),
      get<_i80.OnGoingOrdersScreen>(),
      get<_i82.OrderTimLineScreen>(),
      get<_i68.OrdersWithoutPendingScreen>()));
  gh.factory<_i84.ProductCategoriesScreen>(() =>
      _i84.ProductCategoriesScreen(get<_i69.ProductsCategoryStateManager>()));
  gh.factory<_i85.StoreInfoScreen>(
      () => _i85.StoreInfoScreen(get<_i73.StoreProfileStateManager>()));
  gh.factory<_i86.StoresProfileModule>(
      () => _i86.StoresProfileModule(get<_i85.StoreInfoScreen>()));
  gh.factory<_i87.AboutModule>(() => _i87.AboutModule(get<_i75.AboutScreen>()));
  gh.factory<_i88.CategoriesModule>(() => _i88.CategoriesModule(
      get<_i84.ProductCategoriesScreen>(), get<_i72.StoreProductScreen>()));
  gh.factory<_i89.HomeModule>(() => _i89.HomeModule(get<_i78.HomeScreen>()));
  gh.factory<_i90.MyApp>(() => _i90.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i42.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i53.SplashModule>(),
      get<_i76.AuthorizationModule>(),
      get<_i71.SettingsModule>(),
      get<_i77.ChatModule>(),
      get<_i87.AboutModule>(),
      get<_i79.InitAccountModule>(),
      get<_i16.MainModule>(),
      get<_i74.StoresModule>(),
      get<_i83.OrdersModule>(),
      get<_i88.CategoriesModule>(),
      get<_i86.StoresProfileModule>()));
  gh.singleton<_i91.GlobalStateManager>(_i91.GlobalStateManager());
  return get;
}
