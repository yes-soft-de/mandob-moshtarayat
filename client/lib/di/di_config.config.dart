// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i106;
import '../module_account/account_module.dart' as _i105;
import '../module_account/manager/account_manager.dart' as _i71;
import '../module_account/repository/account_repository.dart' as _i46;
import '../module_account/service/account_service.dart' as _i72;
import '../module_account/state_manager/account_state_manager.dart' as _i73;
import '../module_account/state_manager/presonal_data_state_manager.dart'
    as _i83;
import '../module_account/ui/screen/account_screen.dart' as _i90;
import '../module_account/ui/screen/presonal_data_screen.dart' as _i99;
import '../module_auth/authoriazation_module.dart' as _i74;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i24;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i25;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i31;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i36;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i52;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i60;
import '../module_chat/chat_module.dart' as _i91;
import '../module_chat/manager/chat/chat_manager.dart' as _i47;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i26;
import '../module_chat/service/chat/char_service.dart' as _i48;
import '../module_chat/state_manager/chat_state_manager.dart' as _i49;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i75;
import '../module_home/home_module.dart' as _i77;
import '../module_home/manager/home_manager.dart' as _i27;
import '../module_home/repository/home_repository.dart' as _i19;
import '../module_home/service/home_service.dart' as _i28;
import '../module_home/state_manager/home_state_manager.dart' as _i29;
import '../module_home/ui/screen/home_screen.dart' as _i51;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main/main_module.dart' as _i20;
import '../module_main/ui/screen/main_screen.dart' as _i12;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i53;
import '../module_my_notifications/my_notifications_module.dart' as _i93;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i32;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i54;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i55;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i78;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import '../module_notifications/repository/notification_repo.dart' as _i34;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i50;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/manager/my_orders_manager.dart' as _i56;
import '../module_orders/orders_module.dart' as _i98;
import '../module_orders/repository/orders_repository.dart' as _i33;
import '../module_orders/service/orders_service.dart' as _i57;
import '../module_orders/state_manager/client_order_state_manager.dart' as _i76;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i79;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i80;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i81;
import '../module_orders/state_manager/order_status_state_manager.dart' as _i82;
import '../module_orders/ui/screen/client_order_screen.dart' as _i92;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i94;
import '../module_orders/ui/screen/order_details_screen.dart' as _i95;
import '../module_orders/ui/screen/order_logs_screen.dart' as _i96;
import '../module_orders/ui/screen/order_status_screen.dart' as _i97;
import '../module_our_services/manager/manager.dart' as _i62;
import '../module_our_services/repository/services_repository.dart' as _i40;
import '../module_our_services/service/services_service.dart' as _i63;
import '../module_our_services/services_module.dart' as _i103;
import '../module_our_services/state_manager/private_order_state_manager.dart'
    as _i84;
import '../module_our_services/state_manager/services_state_manager.dart'
    as _i64;
import '../module_our_services/ui/screen/private_order_screen.dart' as _i100;
import '../module_our_services/ui/screen/send_it_screen.dart' as _i87;
import '../module_products/manager/products_manager.dart' as _i58;
import '../module_products/products_module.dart' as _i102;
import '../module_products/repository/products_repository.dart' as _i35;
import '../module_products/service/products_service.dart' as _i59;
import '../module_products/state_manager/products_state_manager.dart' as _i85;
import '../module_products/ui/screen/cart_screen.dart' as _i4;
import '../module_products/ui/screen/products_details_screen.dart' as _i101;
import '../module_search/manager/search_manager.dart' as _i37;
import '../module_search/repository/search_repository.dart' as _i21;
import '../module_search/search_module.dart' as _i86;
import '../module_search/service/search_service.dart' as _i38;
import '../module_search/state_manager/search_state_manager.dart' as _i39;
import '../module_search/ui/screen/search_screen.dart' as _i61;
import '../module_settings/settings_module.dart' as _i88;
import '../module_settings/ui/settings_page/settings_page.dart' as _i65;
import '../module_splash/splash_module.dart' as _i66;
import '../module_splash/ui/screen/splash_screen.dart' as _i41;
import '../module_stores/manager/store_list_manager.dart' as _i42;
import '../module_stores/manager/store_products.dart' as _i68;
import '../module_stores/repository/store_list_repository.dart' as _i22;
import '../module_stores/repository/store_products_repository.dart' as _i45;
import '../module_stores/service/store_list_service.dart' as _i43;
import '../module_stores/service/store_products_service.dart' as _i69;
import '../module_stores/state_manager/store_list_state_manager.dart' as _i44;
import '../module_stores/state_manager/store_products_state_manager.dart'
    as _i70;
import '../module_stores/store_module.dart' as _i104;
import '../module_stores/ui/screen/store_list_screen.dart' as _i67;
import '../module_stores/ui/screen/store_products_screen.dart' as _i89;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i23;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i30;
import '../utils/global/global_state_manager.dart' as _i7;
import '../utils/helpers/fire_store_helper.dart' as _i6;
import '../utils/logger/logger.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.CartScreen>(() => _i4.CartScreen());
  gh.factory<_i5.ChatHiveHelper>(() => _i5.ChatHiveHelper());
  gh.factory<_i6.FireStoreHelper>(() => _i6.FireStoreHelper());
  gh.singleton<_i7.GlobalStateManager>(_i7.GlobalStateManager());
  gh.factory<_i8.LocalNotificationService>(
      () => _i8.LocalNotificationService());
  gh.factory<_i9.LocalizationPreferencesHelper>(
      () => _i9.LocalizationPreferencesHelper());
  gh.factory<_i10.LocalizationService>(
      () => _i10.LocalizationService(get<_i9.LocalizationPreferencesHelper>()));
  gh.factory<_i11.Logger>(() => _i11.Logger());
  gh.factory<_i12.MainScreen>(() => _i12.MainScreen());
  gh.factory<_i13.NotificationsPrefsHelper>(
      () => _i13.NotificationsPrefsHelper());
  gh.factory<_i14.ThemePreferencesHelper>(() => _i14.ThemePreferencesHelper());
  gh.factory<_i15.UploadRepository>(() => _i15.UploadRepository());
  gh.factory<_i16.ApiClient>(() => _i16.ApiClient(get<_i11.Logger>()));
  gh.factory<_i17.AppThemeDataService>(
      () => _i17.AppThemeDataService(get<_i14.ThemePreferencesHelper>()));
  gh.factory<_i18.AuthRepository>(
      () => _i18.AuthRepository(get<_i16.ApiClient>(), get<_i11.Logger>()));
  gh.factory<_i19.HomeRepository>(
      () => _i19.HomeRepository(get<_i16.ApiClient>()));
  gh.factory<_i20.MainModule>(() => _i20.MainModule(get<_i12.MainScreen>()));
  gh.factory<_i21.SearchRepository>(
      () => _i21.SearchRepository(get<_i16.ApiClient>()));
  gh.factory<_i22.StoreListRepository>(
      () => _i22.StoreListRepository(get<_i16.ApiClient>()));
  gh.factory<_i23.UploadManager>(
      () => _i23.UploadManager(get<_i15.UploadRepository>()));
  gh.factory<_i24.AuthManager>(
      () => _i24.AuthManager(get<_i18.AuthRepository>()));
  gh.factory<_i25.AuthService>(() =>
      _i25.AuthService(get<_i3.AuthPrefsHelper>(), get<_i24.AuthManager>()));
  gh.factory<_i26.ChatRepository>(() =>
      _i26.ChatRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i27.HomeManager>(
      () => _i27.HomeManager(get<_i19.HomeRepository>()));
  gh.factory<_i28.HomeService>(() => _i28.HomeService(get<_i27.HomeManager>()));
  gh.factory<_i29.HomeStateManager>(
      () => _i29.HomeStateManager(get<_i28.HomeService>()));
  gh.factory<_i30.ImageUploadService>(
      () => _i30.ImageUploadService(get<_i23.UploadManager>()));
  gh.factory<_i31.LoginStateManager>(
      () => _i31.LoginStateManager(get<_i25.AuthService>()));
  gh.factory<_i32.MyNotificationsRepository>(() =>
      _i32.MyNotificationsRepository(
          get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i33.MyOrdersRepository>(() =>
      _i33.MyOrdersRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i34.NotificationRepo>(() =>
      _i34.NotificationRepo(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i35.ProductsRepository>(() =>
      _i35.ProductsRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i36.RegisterStateManager>(
      () => _i36.RegisterStateManager(get<_i25.AuthService>()));
  gh.factory<_i37.SearchManager>(
      () => _i37.SearchManager(get<_i21.SearchRepository>()));
  gh.factory<_i38.SearchService>(
      () => _i38.SearchService(get<_i37.SearchManager>()));
  gh.factory<_i39.SearchStateManager>(
      () => _i39.SearchStateManager(get<_i38.SearchService>()));
  gh.factory<_i40.ServicesRepository>(() =>
      _i40.ServicesRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i41.SplashScreen>(
      () => _i41.SplashScreen(get<_i25.AuthService>()));
  gh.factory<_i42.StoreListManager>(
      () => _i42.StoreListManager(get<_i22.StoreListRepository>()));
  gh.factory<_i43.StoreListService>(
      () => _i43.StoreListService(get<_i42.StoreListManager>()));
  gh.factory<_i44.StoreListStateManager>(
      () => _i44.StoreListStateManager(get<_i43.StoreListService>()));
  gh.factory<_i45.StoreProductsRepository>(() => _i45.StoreProductsRepository(
      get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i46.AccountRepository>(() =>
      _i46.AccountRepository(get<_i25.AuthService>(), get<_i16.ApiClient>()));
  gh.factory<_i47.ChatManager>(
      () => _i47.ChatManager(get<_i26.ChatRepository>()));
  gh.factory<_i48.ChatService>(() => _i48.ChatService(get<_i47.ChatManager>()));
  gh.factory<_i49.ChatStateManager>(
      () => _i49.ChatStateManager(get<_i48.ChatService>()));
  gh.factory<_i50.FireNotificationService>(() => _i50.FireNotificationService(
      get<_i13.NotificationsPrefsHelper>(), get<_i34.NotificationRepo>()));
  gh.factory<_i51.HomeScreen>(
      () => _i51.HomeScreen(get<_i29.HomeStateManager>()));
  gh.factory<_i52.LoginScreen>(
      () => _i52.LoginScreen(get<_i31.LoginStateManager>()));
  gh.factory<_i53.MyNotificationsManager>(
      () => _i53.MyNotificationsManager(get<_i32.MyNotificationsRepository>()));
  gh.factory<_i54.MyNotificationsService>(
      () => _i54.MyNotificationsService(get<_i53.MyNotificationsManager>()));
  gh.factory<_i55.MyNotificationsStateManager>(() =>
      _i55.MyNotificationsStateManager(
          get<_i54.MyNotificationsService>(), get<_i25.AuthService>()));
  gh.factory<_i56.MyOrdersManager>(
      () => _i56.MyOrdersManager(get<_i33.MyOrdersRepository>()));
  gh.factory<_i57.OrdersService>(() => _i57.OrdersService(
      get<_i56.MyOrdersManager>(), get<_i6.FireStoreHelper>()));
  gh.factory<_i58.ProductsManager>(
      () => _i58.ProductsManager(get<_i35.ProductsRepository>()));
  gh.factory<_i59.ProductsService>(
      () => _i59.ProductsService(get<_i58.ProductsManager>()));
  gh.factory<_i60.RegisterScreen>(
      () => _i60.RegisterScreen(get<_i36.RegisterStateManager>()));
  gh.factory<_i61.SearchScreen>(
      () => _i61.SearchScreen(get<_i39.SearchStateManager>()));
  gh.factory<_i62.ServicesManager>(
      () => _i62.ServicesManager(get<_i40.ServicesRepository>()));
  gh.factory<_i63.ServicesService>(() => _i63.ServicesService(
      get<_i62.ServicesManager>(), get<_i6.FireStoreHelper>()));
  gh.factory<_i64.ServicesStateManager>(() => _i64.ServicesStateManager(
      get<_i63.ServicesService>(), get<_i25.AuthService>()));
  gh.factory<_i65.SettingsScreen>(() => _i65.SettingsScreen(
      get<_i25.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i50.FireNotificationService>()));
  gh.factory<_i66.SplashModule>(
      () => _i66.SplashModule(get<_i41.SplashScreen>()));
  gh.factory<_i67.StoreListScreen>(
      () => _i67.StoreListScreen(get<_i44.StoreListStateManager>()));
  gh.factory<_i68.StoreProductsManager>(
      () => _i68.StoreProductsManager(get<_i45.StoreProductsRepository>()));
  gh.factory<_i69.StoreProductsService>(
      () => _i69.StoreProductsService(get<_i68.StoreProductsManager>()));
  gh.factory<_i70.StoreProductsStateManager>(
      () => _i70.StoreProductsStateManager(get<_i69.StoreProductsService>()));
  gh.factory<_i71.AccountManager>(
      () => _i71.AccountManager(get<_i46.AccountRepository>()));
  gh.factory<_i72.AccountService>(
      () => _i72.AccountService(get<_i71.AccountManager>()));
  gh.factory<_i73.AccountStateManager>(() => _i73.AccountStateManager(
      get<_i72.AccountService>(), get<_i25.AuthService>()));
  gh.factory<_i74.AuthorizationModule>(() => _i74.AuthorizationModule(
      get<_i52.LoginScreen>(), get<_i60.RegisterScreen>()));
  gh.factory<_i75.ChatPage>(() => _i75.ChatPage(
      get<_i49.ChatStateManager>(),
      get<_i30.ImageUploadService>(),
      get<_i25.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i76.ClientOrderStateManager>(() => _i76.ClientOrderStateManager(
      get<_i57.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i77.HomeModule>(() => _i77.HomeModule(get<_i51.HomeScreen>()));
  gh.factory<_i78.MyNotificationsScreen>(() =>
      _i78.MyNotificationsScreen(get<_i55.MyNotificationsStateManager>()));
  gh.factory<_i79.MyOrdersStateManager>(() => _i79.MyOrdersStateManager(
      get<_i57.OrdersService>(),
      get<_i25.AuthService>(),
      get<_i6.FireStoreHelper>()));
  gh.factory<_i80.OrderDetailsStateManager>(() => _i80.OrderDetailsStateManager(
      get<_i57.OrdersService>(), get<_i6.FireStoreHelper>()));
  gh.factory<_i81.OrderLogsStateManager>(
      () => _i81.OrderLogsStateManager(get<_i57.OrdersService>()));
  gh.factory<_i82.OrderStatusStateManager>(() => _i82.OrderStatusStateManager(
      get<_i57.OrdersService>(), get<_i6.FireStoreHelper>()));
  gh.factory<_i83.PersonalDataStateManager>(() => _i83.PersonalDataStateManager(
      get<_i72.AccountService>(), get<_i30.ImageUploadService>()));
  gh.factory<_i84.PrivateOrderStateManager>(() => _i84.PrivateOrderStateManager(
      get<_i63.ServicesService>(), get<_i25.AuthService>()));
  gh.factory<_i85.ProductDetailsStateManager>(
      () => _i85.ProductDetailsStateManager(get<_i59.ProductsService>()));
  gh.factory<_i86.SearchModule>(
      () => _i86.SearchModule(get<_i61.SearchScreen>()));
  gh.factory<_i87.SendItScreen>(
      () => _i87.SendItScreen(get<_i64.ServicesStateManager>()));
  gh.factory<_i88.SettingsModule>(
      () => _i88.SettingsModule(get<_i65.SettingsScreen>()));
  gh.factory<_i89.StoreProductsScreen>(() => _i89.StoreProductsScreen(
      get<_i70.StoreProductsStateManager>(), get<_i25.AuthService>()));
  gh.factory<_i90.AccountScreen>(
      () => _i90.AccountScreen(get<_i73.AccountStateManager>()));
  gh.factory<_i91.ChatModule>(
      () => _i91.ChatModule(get<_i75.ChatPage>(), get<_i25.AuthService>()));
  gh.factory<_i92.ClientOrderScreen>(
      () => _i92.ClientOrderScreen(get<_i76.ClientOrderStateManager>()));
  gh.factory<_i93.MyNotificationsModule>(
      () => _i93.MyNotificationsModule(get<_i78.MyNotificationsScreen>()));
  gh.factory<_i94.MyOrdersScreen>(
      () => _i94.MyOrdersScreen(get<_i79.MyOrdersStateManager>()));
  gh.factory<_i95.OrderDetailsScreen>(
      () => _i95.OrderDetailsScreen(get<_i80.OrderDetailsStateManager>()));
  gh.factory<_i96.OrderLogsScreen>(
      () => _i96.OrderLogsScreen(get<_i81.OrderLogsStateManager>()));
  gh.factory<_i97.OrderStatusScreen>(
      () => _i97.OrderStatusScreen(get<_i82.OrderStatusStateManager>()));
  gh.factory<_i98.OrdersModule>(() => _i98.OrdersModule(
      get<_i94.MyOrdersScreen>(),
      get<_i95.OrderDetailsScreen>(),
      get<_i97.OrderStatusScreen>(),
      get<_i92.ClientOrderScreen>(),
      get<_i96.OrderLogsScreen>()));
  gh.factory<_i99.PersonalDataScreen>(
      () => _i99.PersonalDataScreen(get<_i83.PersonalDataStateManager>()));
  gh.factory<_i100.PrivateOrderScreen>(
      () => _i100.PrivateOrderScreen(get<_i84.PrivateOrderStateManager>()));
  gh.factory<_i101.ProductDetailsScreen>(
      () => _i101.ProductDetailsScreen(get<_i85.ProductDetailsStateManager>()));
  gh.factory<_i102.ProductsModule>(() => _i102.ProductsModule(
      get<_i101.ProductDetailsScreen>(), get<_i4.CartScreen>()));
  gh.factory<_i103.ServicesModule>(() => _i103.ServicesModule(
      get<_i87.SendItScreen>(), get<_i100.PrivateOrderScreen>()));
  gh.factory<_i104.StoreModule>(() => _i104.StoreModule(
      get<_i67.StoreListScreen>(), get<_i89.StoreProductsScreen>()));
  gh.factory<_i105.AccountModule>(() => _i105.AccountModule(
      get<_i90.AccountScreen>(), get<_i99.PersonalDataScreen>()));
  gh.factory<_i106.MyApp>(() => _i106.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i50.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i66.SplashModule>(),
      get<_i74.AuthorizationModule>(),
      get<_i91.ChatModule>(),
      get<_i88.SettingsModule>(),
      get<_i20.MainModule>(),
      get<_i98.OrdersModule>(),
      get<_i86.SearchModule>(),
      get<_i105.AccountModule>(),
      get<_i103.ServicesModule>(),
      get<_i104.StoreModule>(),
      get<_i93.MyNotificationsModule>(),
      get<_i102.ProductsModule>()));
  return get;
}
