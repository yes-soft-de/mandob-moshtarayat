// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i109;
import '../module_account/account_module.dart' as _i108;
import '../module_account/manager/account_manager.dart' as _i71;
import '../module_account/repository/account_repository.dart' as _i44;
import '../module_account/service/account_service.dart' as _i72;
import '../module_account/state_manager/account_state_manager.dart' as _i73;
import '../module_account/state_manager/favorite_state_manager.dart' as _i77;
import '../module_account/state_manager/presonal_data_state_manager.dart'
    as _i84;
import '../module_account/ui/screen/account_screen.dart' as _i91;
import '../module_account/ui/screen/favourite_screen.dart' as _i94;
import '../module_account/ui/screen/presonal_data_screen.dart' as _i102;
import '../module_auth/authoriazation_module.dart' as _i74;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i24;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i25;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i29;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i34;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i52;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i60;
import '../module_chat/chat_module.dart' as _i92;
import '../module_chat/manager/chat/chat_manager.dart' as _i45;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i26;
import '../module_chat/service/chat/char_service.dart' as _i46;
import '../module_chat/state_manager/chat_state_manager.dart' as _i47;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i75;
import '../module_home/home_module.dart' as _i95;
import '../module_home/manager/home_manager.dart' as _i49;
import '../module_home/repository/home_repository.dart' as _i27;
import '../module_home/service/home_service.dart' as _i50;
import '../module_home/state_manager/home_state_manager.dart' as _i51;
import '../module_home/ui/screen/home_screen.dart' as _i78;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main/main_module.dart' as _i20;
import '../module_main/ui/screen/main_screen.dart' as _i12;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i53;
import '../module_my_notifications/my_notifications_module.dart' as _i96;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i30;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i54;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i55;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i79;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import '../module_notifications/repository/notification_repo.dart' as _i32;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i48;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/manager/my_orders_manager.dart' as _i56;
import '../module_orders/orders_module.dart' as _i101;
import '../module_orders/repository/orders_repository.dart' as _i31;
import '../module_orders/service/orders_service.dart' as _i57;
import '../module_orders/state_manager/client_order_state_manager.dart' as _i76;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i80;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i81;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i82;
import '../module_orders/state_manager/order_status_state_manager.dart' as _i83;
import '../module_orders/ui/screen/client_order_screen.dart' as _i93;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i97;
import '../module_orders/ui/screen/order_details_screen.dart' as _i98;
import '../module_orders/ui/screen/order_logs_screen.dart' as _i99;
import '../module_orders/ui/screen/order_status_screen.dart' as _i100;
import '../module_our_services/manager/manager.dart' as _i62;
import '../module_our_services/repository/services_repository.dart' as _i38;
import '../module_our_services/service/services_service.dart' as _i63;
import '../module_our_services/services_module.dart' as _i106;
import '../module_our_services/state_manager/private_order_state_manager.dart'
    as _i85;
import '../module_our_services/state_manager/services_state_manager.dart'
    as _i64;
import '../module_our_services/ui/screen/private_order_screen.dart' as _i103;
import '../module_our_services/ui/screen/send_it_screen.dart' as _i88;
import '../module_products/manager/products_manager.dart' as _i58;
import '../module_products/products_module.dart' as _i105;
import '../module_products/repository/products_repository.dart' as _i33;
import '../module_products/service/products_service.dart' as _i59;
import '../module_products/state_manager/products_state_manager.dart' as _i86;
import '../module_products/ui/screen/cart_screen.dart' as _i4;
import '../module_products/ui/screen/products_details_screen.dart' as _i104;
import '../module_search/manager/search_manager.dart' as _i35;
import '../module_search/repository/search_repository.dart' as _i21;
import '../module_search/search_module.dart' as _i87;
import '../module_search/service/search_service.dart' as _i36;
import '../module_search/state_manager/search_state_manager.dart' as _i37;
import '../module_search/ui/screen/search_screen.dart' as _i61;
import '../module_settings/settings_module.dart' as _i89;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i19;
import '../module_settings/ui/settings_page/settings_page.dart' as _i65;
import '../module_splash/splash_module.dart' as _i66;
import '../module_splash/ui/screen/splash_screen.dart' as _i39;
import '../module_stores/manager/store_list_manager.dart' as _i40;
import '../module_stores/manager/store_products.dart' as _i68;
import '../module_stores/repository/store_list_repository.dart' as _i22;
import '../module_stores/repository/store_products_repository.dart' as _i43;
import '../module_stores/service/store_list_service.dart' as _i41;
import '../module_stores/service/store_products_service.dart' as _i69;
import '../module_stores/state_manager/store_list_state_manager.dart' as _i42;
import '../module_stores/state_manager/store_products_state_manager.dart'
    as _i70;
import '../module_stores/store_module.dart' as _i107;
import '../module_stores/ui/screen/store_list_screen.dart' as _i67;
import '../module_stores/ui/screen/store_products_screen.dart' as _i90;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i23;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i28;
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
  gh.factory<_i19.ChooseLocalScreen>(
      () => _i19.ChooseLocalScreen(get<_i10.LocalizationService>()));
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
  gh.factory<_i27.HomeRepository>(() =>
      _i27.HomeRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i28.ImageUploadService>(
      () => _i28.ImageUploadService(get<_i23.UploadManager>()));
  gh.factory<_i29.LoginStateManager>(
      () => _i29.LoginStateManager(get<_i25.AuthService>()));
  gh.factory<_i30.MyNotificationsRepository>(() =>
      _i30.MyNotificationsRepository(
          get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i31.MyOrdersRepository>(() =>
      _i31.MyOrdersRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i32.NotificationRepo>(() =>
      _i32.NotificationRepo(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i33.ProductsRepository>(() =>
      _i33.ProductsRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i34.RegisterStateManager>(
      () => _i34.RegisterStateManager(get<_i25.AuthService>()));
  gh.factory<_i35.SearchManager>(
      () => _i35.SearchManager(get<_i21.SearchRepository>()));
  gh.factory<_i36.SearchService>(
      () => _i36.SearchService(get<_i35.SearchManager>()));
  gh.factory<_i37.SearchStateManager>(
      () => _i37.SearchStateManager(get<_i36.SearchService>()));
  gh.factory<_i38.ServicesRepository>(() =>
      _i38.ServicesRepository(get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i39.SplashScreen>(() => _i39.SplashScreen(
      get<_i25.AuthService>(), get<_i10.LocalizationService>()));
  gh.factory<_i40.StoreListManager>(
      () => _i40.StoreListManager(get<_i22.StoreListRepository>()));
  gh.factory<_i41.StoreListService>(
      () => _i41.StoreListService(get<_i40.StoreListManager>()));
  gh.factory<_i42.StoreListStateManager>(
      () => _i42.StoreListStateManager(get<_i41.StoreListService>()));
  gh.factory<_i43.StoreProductsRepository>(() => _i43.StoreProductsRepository(
      get<_i16.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i44.AccountRepository>(() =>
      _i44.AccountRepository(get<_i25.AuthService>(), get<_i16.ApiClient>()));
  gh.factory<_i45.ChatManager>(
      () => _i45.ChatManager(get<_i26.ChatRepository>()));
  gh.factory<_i46.ChatService>(() => _i46.ChatService(get<_i45.ChatManager>()));
  gh.factory<_i47.ChatStateManager>(
      () => _i47.ChatStateManager(get<_i46.ChatService>()));
  gh.factory<_i48.FireNotificationService>(() => _i48.FireNotificationService(
      get<_i13.NotificationsPrefsHelper>(), get<_i32.NotificationRepo>()));
  gh.factory<_i49.HomeManager>(
      () => _i49.HomeManager(get<_i27.HomeRepository>()));
  gh.factory<_i50.HomeService>(() => _i50.HomeService(get<_i49.HomeManager>()));
  gh.factory<_i51.HomeStateManager>(
      () => _i51.HomeStateManager(get<_i50.HomeService>()));
  gh.factory<_i52.LoginScreen>(
      () => _i52.LoginScreen(get<_i29.LoginStateManager>()));
  gh.factory<_i53.MyNotificationsManager>(
      () => _i53.MyNotificationsManager(get<_i30.MyNotificationsRepository>()));
  gh.factory<_i54.MyNotificationsService>(
      () => _i54.MyNotificationsService(get<_i53.MyNotificationsManager>()));
  gh.factory<_i55.MyNotificationsStateManager>(() =>
      _i55.MyNotificationsStateManager(
          get<_i54.MyNotificationsService>(), get<_i25.AuthService>()));
  gh.factory<_i56.MyOrdersManager>(
      () => _i56.MyOrdersManager(get<_i31.MyOrdersRepository>()));
  gh.factory<_i57.OrdersService>(() => _i57.OrdersService(
      get<_i56.MyOrdersManager>(), get<_i6.FireStoreHelper>()));
  gh.factory<_i58.ProductsManager>(
      () => _i58.ProductsManager(get<_i33.ProductsRepository>()));
  gh.factory<_i59.ProductsService>(
      () => _i59.ProductsService(get<_i58.ProductsManager>()));
  gh.factory<_i60.RegisterScreen>(
      () => _i60.RegisterScreen(get<_i34.RegisterStateManager>()));
  gh.factory<_i61.SearchScreen>(
      () => _i61.SearchScreen(get<_i37.SearchStateManager>()));
  gh.factory<_i62.ServicesManager>(
      () => _i62.ServicesManager(get<_i38.ServicesRepository>()));
  gh.factory<_i63.ServicesService>(() => _i63.ServicesService(
      get<_i62.ServicesManager>(), get<_i6.FireStoreHelper>()));
  gh.factory<_i64.ServicesStateManager>(() => _i64.ServicesStateManager(
      get<_i63.ServicesService>(), get<_i25.AuthService>()));
  gh.factory<_i65.SettingsScreen>(() => _i65.SettingsScreen(
      get<_i25.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i48.FireNotificationService>()));
  gh.factory<_i66.SplashModule>(
      () => _i66.SplashModule(get<_i39.SplashScreen>()));
  gh.factory<_i67.StoreListScreen>(
      () => _i67.StoreListScreen(get<_i42.StoreListStateManager>()));
  gh.factory<_i68.StoreProductsManager>(
      () => _i68.StoreProductsManager(get<_i43.StoreProductsRepository>()));
  gh.factory<_i69.StoreProductsService>(
      () => _i69.StoreProductsService(get<_i68.StoreProductsManager>()));
  gh.factory<_i70.StoreProductsStateManager>(
      () => _i70.StoreProductsStateManager(get<_i69.StoreProductsService>()));
  gh.factory<_i71.AccountManager>(
      () => _i71.AccountManager(get<_i44.AccountRepository>()));
  gh.factory<_i72.AccountService>(
      () => _i72.AccountService(get<_i71.AccountManager>()));
  gh.factory<_i73.AccountStateManager>(() => _i73.AccountStateManager(
      get<_i72.AccountService>(), get<_i25.AuthService>()));
  gh.factory<_i74.AuthorizationModule>(() => _i74.AuthorizationModule(
      get<_i52.LoginScreen>(), get<_i60.RegisterScreen>()));
  gh.factory<_i75.ChatPage>(() => _i75.ChatPage(
      get<_i47.ChatStateManager>(),
      get<_i28.ImageUploadService>(),
      get<_i25.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i76.ClientOrderStateManager>(() => _i76.ClientOrderStateManager(
      get<_i57.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i77.FavouriteStateManager>(() => _i77.FavouriteStateManager(
      get<_i72.AccountService>(),
      get<_i25.AuthService>(),
      get<_i50.HomeService>()));
  gh.factory<_i78.HomeScreen>(
      () => _i78.HomeScreen(get<_i51.HomeStateManager>()));
  gh.factory<_i79.MyNotificationsScreen>(() =>
      _i79.MyNotificationsScreen(get<_i55.MyNotificationsStateManager>()));
  gh.factory<_i80.MyOrdersStateManager>(() => _i80.MyOrdersStateManager(
      get<_i57.OrdersService>(),
      get<_i25.AuthService>(),
      get<_i6.FireStoreHelper>()));
  gh.factory<_i81.OrderDetailsStateManager>(() => _i81.OrderDetailsStateManager(
      get<_i57.OrdersService>(), get<_i6.FireStoreHelper>()));
  gh.factory<_i82.OrderLogsStateManager>(
      () => _i82.OrderLogsStateManager(get<_i57.OrdersService>()));
  gh.factory<_i83.OrderStatusStateManager>(() => _i83.OrderStatusStateManager(
      get<_i57.OrdersService>(), get<_i6.FireStoreHelper>()));
  gh.factory<_i84.PersonalDataStateManager>(() => _i84.PersonalDataStateManager(
      get<_i72.AccountService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i85.PrivateOrderStateManager>(() => _i85.PrivateOrderStateManager(
      get<_i63.ServicesService>(), get<_i25.AuthService>()));
  gh.factory<_i86.ProductDetailsStateManager>(
      () => _i86.ProductDetailsStateManager(get<_i59.ProductsService>()));
  gh.factory<_i87.SearchModule>(
      () => _i87.SearchModule(get<_i61.SearchScreen>()));
  gh.factory<_i88.SendItScreen>(
      () => _i88.SendItScreen(get<_i64.ServicesStateManager>()));
  gh.factory<_i89.SettingsModule>(() => _i89.SettingsModule(
      get<_i65.SettingsScreen>(), get<_i19.ChooseLocalScreen>()));
  gh.factory<_i90.StoreProductsScreen>(() => _i90.StoreProductsScreen(
      get<_i70.StoreProductsStateManager>(), get<_i25.AuthService>()));
  gh.factory<_i91.AccountScreen>(
      () => _i91.AccountScreen(get<_i73.AccountStateManager>()));
  gh.factory<_i92.ChatModule>(
      () => _i92.ChatModule(get<_i75.ChatPage>(), get<_i25.AuthService>()));
  gh.factory<_i93.ClientOrderScreen>(
      () => _i93.ClientOrderScreen(get<_i76.ClientOrderStateManager>()));
  gh.factory<_i94.FavouritScreen>(
      () => _i94.FavouritScreen(get<_i77.FavouriteStateManager>()));
  gh.factory<_i95.HomeModule>(() => _i95.HomeModule(get<_i78.HomeScreen>()));
  gh.factory<_i96.MyNotificationsModule>(
      () => _i96.MyNotificationsModule(get<_i79.MyNotificationsScreen>()));
  gh.factory<_i97.MyOrdersScreen>(
      () => _i97.MyOrdersScreen(get<_i80.MyOrdersStateManager>()));
  gh.factory<_i98.OrderDetailsScreen>(
      () => _i98.OrderDetailsScreen(get<_i81.OrderDetailsStateManager>()));
  gh.factory<_i99.OrderLogsScreen>(
      () => _i99.OrderLogsScreen(get<_i82.OrderLogsStateManager>()));
  gh.factory<_i100.OrderStatusScreen>(
      () => _i100.OrderStatusScreen(get<_i83.OrderStatusStateManager>()));
  gh.factory<_i101.OrdersModule>(() => _i101.OrdersModule(
      get<_i97.MyOrdersScreen>(),
      get<_i98.OrderDetailsScreen>(),
      get<_i100.OrderStatusScreen>(),
      get<_i93.ClientOrderScreen>(),
      get<_i99.OrderLogsScreen>()));
  gh.factory<_i102.PersonalDataScreen>(
      () => _i102.PersonalDataScreen(get<_i84.PersonalDataStateManager>()));
  gh.factory<_i103.PrivateOrderScreen>(
      () => _i103.PrivateOrderScreen(get<_i85.PrivateOrderStateManager>()));
  gh.factory<_i104.ProductDetailsScreen>(
      () => _i104.ProductDetailsScreen(get<_i86.ProductDetailsStateManager>()));
  gh.factory<_i105.ProductsModule>(() => _i105.ProductsModule(
      get<_i104.ProductDetailsScreen>(), get<_i4.CartScreen>()));
  gh.factory<_i106.ServicesModule>(() => _i106.ServicesModule(
      get<_i88.SendItScreen>(), get<_i103.PrivateOrderScreen>()));
  gh.factory<_i107.StoreModule>(() => _i107.StoreModule(
      get<_i67.StoreListScreen>(), get<_i90.StoreProductsScreen>()));
  gh.factory<_i108.AccountModule>(() => _i108.AccountModule(
      get<_i91.AccountScreen>(), get<_i102.PersonalDataScreen>()));
  gh.factory<_i109.MyApp>(() => _i109.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i48.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i66.SplashModule>(),
      get<_i74.AuthorizationModule>(),
      get<_i92.ChatModule>(),
      get<_i89.SettingsModule>(),
      get<_i20.MainModule>(),
      get<_i101.OrdersModule>(),
      get<_i87.SearchModule>(),
      get<_i108.AccountModule>(),
      get<_i106.ServicesModule>(),
      get<_i107.StoreModule>(),
      get<_i96.MyNotificationsModule>(),
      get<_i105.ProductsModule>()));
  return get;
}
