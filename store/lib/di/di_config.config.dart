// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i86;
import '../module_about/about_module.dart' as _i83;
import '../module_about/manager/about_manager.dart' as _i31;
import '../module_about/repository/about_repository.dart' as _i18;
import '../module_about/service/about_service/about_service.dart' as _i32;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i54;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i71;
import '../module_auth/authoriazation_module.dart' as _i72;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i19;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i20;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i47;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i44;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i66;
import '../module_categories/categories_module.dart' as _i84;
import '../module_categories/manager/categories_manager.dart' as _i33;
import '../module_categories/repository/categories_repository.dart' as _i21;
import '../module_categories/service/store_categories_service.dart' as _i34;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i65;
import '../module_categories/state_manager/store_categories_state_manager.dart'
    as _i50;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i52;
import '../module_categories/ui/screen/product_categories_screen.dart' as _i80;
import '../module_categories/ui/screen/store_categories_screen.dart' as _i68;
import '../module_categories/ui/screen/store_products_screen.dart' as _i69;
import '../module_chat/chat_module.dart' as _i73;
import '../module_chat/manager/chat/chat_manager.dart' as _i35;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i22;
import '../module_chat/service/chat/char_service.dart' as _i36;
import '../module_chat/state_manager/chat_state_manager.dart' as _i37;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i55;
import '../module_home/home_module.dart' as _i85;
import '../module_home/manager/home_manager.dart' as _i39;
import '../module_home/repository/home_repository.dart' as _i23;
import '../module_home/sceen/home_screen.dart' as _i74;
import '../module_home/service/home_service.dart' as _i40;
import '../module_home/state_manager/home_state_manager.dart' as _i56;
import '../module_init/init_account_module.dart' as _i75;
import '../module_init/manager/init_account/init_account.manager.dart' as _i41;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i25;
import '../module_init/service/init_account/init_account.service.dart' as _i42;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i43;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i57;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_main/main_module.dart' as _i16;
import '../module_main/ui/screen/main_screen.dart' as _i9;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i28;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i38;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_orders/manager/my_orders_manager.dart' as _i45;
import '../module_orders/orders_module.dart' as _i79;
import '../module_orders/repository/orders_repository.dart' as _i27;
import '../module_orders/service/orders_service.dart' as _i46;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i58;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i59;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i60;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i61;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i62;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i63;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i76;
import '../module_orders/ui/screen/order_details_screen.dart' as _i77;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i78;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i64;
import '../module_profile/manager/stores_manager.dart' as _i51;
import '../module_profile/repository/stores_repository.dart' as _i30;
import '../module_profile/service/store_service.dart' as _i53;
import '../module_profile/state_manager/store_profile_state_manager.dart'
    as _i70;
import '../module_profile/stores_module.dart' as _i82;
import '../module_profile/ui/screen/store_info_screen.dart' as _i81;
import '../module_settings/settings_module.dart' as _i67;
import '../module_settings/ui/settings_page/settings_page.dart' as _i48;
import '../module_splash/splash_module.dart' as _i49;
import '../module_splash/ui/screen/splash_screen.dart' as _i29;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i24;
import '../utils/global/global_state_manager.dart' as _i87;
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
  gh.factory<_i17.UploadManager>(
      () => _i17.UploadManager(get<_i12.UploadRepository>()));
  gh.factory<_i18.AboutRepository>(
      () => _i18.AboutRepository(get<_i13.ApiClient>()));
  gh.factory<_i19.AuthManager>(
      () => _i19.AuthManager(get<_i15.AuthRepository>()));
  gh.factory<_i20.AuthService>(() =>
      _i20.AuthService(get<_i3.AuthPrefsHelper>(), get<_i19.AuthManager>()));
  gh.factory<_i21.CategoriesRepository>(() => _i21.CategoriesRepository(
      get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i22.ChatRepository>(() =>
      _i22.ChatRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i23.HomeRepository>(() =>
      _i23.HomeRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i24.ImageUploadService>(
      () => _i24.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i25.InitAccountRepository>(() => _i25.InitAccountRepository(
      get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i26.LoginStateManager>(
      () => _i26.LoginStateManager(get<_i20.AuthService>()));
  gh.factory<_i27.MyOrdersRepository>(() =>
      _i27.MyOrdersRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i28.NotificationRepo>(() =>
      _i28.NotificationRepo(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i29.SplashScreen>(
      () => _i29.SplashScreen(get<_i20.AuthService>()));
  gh.factory<_i30.StoresRepository>(() =>
      _i30.StoresRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i31.AboutManager>(
      () => _i31.AboutManager(get<_i18.AboutRepository>()));
  gh.factory<_i32.AboutService>(
      () => _i32.AboutService(get<_i31.AboutManager>()));
  gh.factory<_i33.CategoriesManager>(
      () => _i33.CategoriesManager(get<_i21.CategoriesRepository>()));
  gh.factory<_i34.CategoriesService>(
      () => _i34.CategoriesService(get<_i33.CategoriesManager>()));
  gh.factory<_i35.ChatManager>(
      () => _i35.ChatManager(get<_i22.ChatRepository>()));
  gh.factory<_i36.ChatService>(() => _i36.ChatService(get<_i35.ChatManager>()));
  gh.factory<_i37.ChatStateManager>(
      () => _i37.ChatStateManager(get<_i36.ChatService>()));
  gh.factory<_i38.FireNotificationService>(() => _i38.FireNotificationService(
      get<_i10.NotificationsPrefsHelper>(), get<_i28.NotificationRepo>()));
  gh.factory<_i39.HomeManager>(
      () => _i39.HomeManager(get<_i23.HomeRepository>()));
  gh.factory<_i40.HomeService>(() => _i40.HomeService(get<_i39.HomeManager>()));
  gh.factory<_i41.InitAccountManager>(
      () => _i41.InitAccountManager(get<_i25.InitAccountRepository>()));
  gh.factory<_i42.InitAccountService>(
      () => _i42.InitAccountService(get<_i41.InitAccountManager>()));
  gh.factory<_i43.InitAccountStateManager>(() => _i43.InitAccountStateManager(
      get<_i42.InitAccountService>(),
      get<_i20.AuthService>(),
      get<_i24.ImageUploadService>(),
      get<_i34.CategoriesService>()));
  gh.factory<_i44.LoginScreen>(
      () => _i44.LoginScreen(get<_i26.LoginStateManager>()));
  gh.factory<_i45.MyOrdersManager>(
      () => _i45.MyOrdersManager(get<_i27.MyOrdersRepository>()));
  gh.factory<_i46.OrdersService>(
      () => _i46.OrdersService(get<_i45.MyOrdersManager>()));
  gh.factory<_i47.RegisterStateManager>(() => _i47.RegisterStateManager(
      get<_i20.AuthService>(), get<_i32.AboutService>()));
  gh.factory<_i48.SettingsScreen>(() => _i48.SettingsScreen(
      get<_i20.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i38.FireNotificationService>()));
  gh.factory<_i49.SplashModule>(
      () => _i49.SplashModule(get<_i29.SplashScreen>()));
  gh.factory<_i50.StoreCategoriesStateManager>(() =>
      _i50.StoreCategoriesStateManager(get<_i34.CategoriesService>(),
          get<_i20.AuthService>(), get<_i24.ImageUploadService>()));
  gh.factory<_i51.StoreManager>(
      () => _i51.StoreManager(get<_i30.StoresRepository>()));
  gh.factory<_i52.StoreProductsStateManager>(() =>
      _i52.StoreProductsStateManager(get<_i34.CategoriesService>(),
          get<_i20.AuthService>(), get<_i24.ImageUploadService>()));
  gh.factory<_i53.StoresService>(
      () => _i53.StoresService(get<_i51.StoreManager>()));
  gh.factory<_i54.AboutScreenStateManager>(
      () => _i54.AboutScreenStateManager(get<_i32.AboutService>()));
  gh.factory<_i55.ChatPage>(() => _i55.ChatPage(
      get<_i37.ChatStateManager>(),
      get<_i24.ImageUploadService>(),
      get<_i20.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i56.HomeStateManager>(() => _i56.HomeStateManager(
      get<_i40.HomeService>(), get<_i53.StoresService>()));
  gh.factory<_i57.InitAccountScreen>(
      () => _i57.InitAccountScreen(get<_i43.InitAccountStateManager>()));
  gh.factory<_i58.MyOrdersStateManager>(() => _i58.MyOrdersStateManager(
      get<_i46.OrdersService>(), get<_i20.AuthService>()));
  gh.factory<_i59.OnGoingOrdersStateManager>(() =>
      _i59.OnGoingOrdersStateManager(
          get<_i46.OrdersService>(), get<_i20.AuthService>()));
  gh.factory<_i60.OrderDetailsStateManager>(
      () => _i60.OrderDetailsStateManager(get<_i46.OrdersService>()));
  gh.factory<_i61.OrderTimeLineStateManager>(
      () => _i61.OrderTimeLineStateManager(get<_i46.OrdersService>()));
  gh.factory<_i62.OrderWithoutPendingStateManager>(() =>
      _i62.OrderWithoutPendingStateManager(
          get<_i46.OrdersService>(), get<_i20.AuthService>()));
  gh.factory<_i63.OrdersScreen>(
      () => _i63.OrdersScreen(get<_i58.MyOrdersStateManager>()));
  gh.factory<_i64.OrdersWithoutPendingScreen>(() =>
      _i64.OrdersWithoutPendingScreen(
          get<_i62.OrderWithoutPendingStateManager>()));
  gh.factory<_i65.ProductsCategoryStateManager>(() =>
      _i65.ProductsCategoryStateManager(
          get<_i34.CategoriesService>(),
          get<_i20.AuthService>(),
          get<_i24.ImageUploadService>(),
          get<_i53.StoresService>()));
  gh.factory<_i66.RegisterScreen>(
      () => _i66.RegisterScreen(get<_i47.RegisterStateManager>()));
  gh.factory<_i67.SettingsModule>(
      () => _i67.SettingsModule(get<_i48.SettingsScreen>()));
  gh.factory<_i68.StoreCategoriesScreen>(() =>
      _i68.StoreCategoriesScreen(get<_i50.StoreCategoriesStateManager>()));
  gh.factory<_i69.StoreProductScreen>(
      () => _i69.StoreProductScreen(get<_i52.StoreProductsStateManager>()));
  gh.factory<_i70.StoreProfileStateManager>(
      () => _i70.StoreProfileStateManager(get<_i53.StoresService>()));
  gh.factory<_i71.AboutScreen>(
      () => _i71.AboutScreen(get<_i54.AboutScreenStateManager>()));
  gh.factory<_i72.AuthorizationModule>(() => _i72.AuthorizationModule(
      get<_i44.LoginScreen>(), get<_i66.RegisterScreen>()));
  gh.factory<_i73.ChatModule>(
      () => _i73.ChatModule(get<_i55.ChatPage>(), get<_i20.AuthService>()));
  gh.factory<_i74.HomeScreen>(
      () => _i74.HomeScreen(get<_i56.HomeStateManager>()));
  gh.factory<_i75.InitAccountModule>(
      () => _i75.InitAccountModule(get<_i57.InitAccountScreen>()));
  gh.factory<_i76.OnGoingOrdersScreen>(
      () => _i76.OnGoingOrdersScreen(get<_i59.OnGoingOrdersStateManager>()));
  gh.factory<_i77.OrderDetailsScreen>(
      () => _i77.OrderDetailsScreen(get<_i60.OrderDetailsStateManager>()));
  gh.factory<_i78.OrderTimLineScreen>(
      () => _i78.OrderTimLineScreen(get<_i61.OrderTimeLineStateManager>()));
  gh.factory<_i79.OrdersModule>(() => _i79.OrdersModule(
      get<_i63.OrdersScreen>(),
      get<_i77.OrderDetailsScreen>(),
      get<_i76.OnGoingOrdersScreen>(),
      get<_i78.OrderTimLineScreen>(),
      get<_i64.OrdersWithoutPendingScreen>()));
  gh.factory<_i80.ProductCategoriesScreen>(() =>
      _i80.ProductCategoriesScreen(get<_i65.ProductsCategoryStateManager>()));
  gh.factory<_i81.StoreInfoScreen>(
      () => _i81.StoreInfoScreen(get<_i70.StoreProfileStateManager>()));
  gh.factory<_i82.StoresModule>(
      () => _i82.StoresModule(get<_i81.StoreInfoScreen>()));
  gh.factory<_i83.AboutModule>(() => _i83.AboutModule(get<_i71.AboutScreen>()));
  gh.factory<_i84.CategoriesModule>(() => _i84.CategoriesModule(
      get<_i68.StoreCategoriesScreen>(),
      get<_i80.ProductCategoriesScreen>(),
      get<_i69.StoreProductScreen>()));
  gh.factory<_i85.HomeModule>(() => _i85.HomeModule(get<_i74.HomeScreen>()));
  gh.factory<_i86.MyApp>(() => _i86.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i38.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i49.SplashModule>(),
      get<_i72.AuthorizationModule>(),
      get<_i67.SettingsModule>(),
      get<_i73.ChatModule>(),
      get<_i83.AboutModule>(),
      get<_i75.InitAccountModule>(),
      get<_i16.MainModule>(),
      get<_i82.StoresModule>(),
      get<_i79.OrdersModule>(),
      get<_i84.CategoriesModule>()));
  gh.singleton<_i87.GlobalStateManager>(_i87.GlobalStateManager());
  return get;
}
