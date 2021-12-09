// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i110;
import '../module_account/account_module.dart' as _i109;
import '../module_account/hive/favorite_store_category.dart' as _i6;
import '../module_account/manager/account_manager.dart' as _i72;
import '../module_account/repository/account_repository.dart' as _i45;
import '../module_account/service/account_service.dart' as _i73;
import '../module_account/state_manager/account_state_manager.dart' as _i74;
import '../module_account/state_manager/favorite_state_manager.dart' as _i78;
import '../module_account/state_manager/presonal_data_state_manager.dart'
    as _i85;
import '../module_account/ui/screen/account_screen.dart' as _i92;
import '../module_account/ui/screen/favourite_screen.dart' as _i95;
import '../module_account/ui/screen/presonal_data_screen.dart' as _i103;
import '../module_auth/authoriazation_module.dart' as _i75;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i25;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../module_auth/service/auth_service/auth_service.dart' as _i26;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i30;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i35;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i53;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i61;
import '../module_chat/chat_module.dart' as _i93;
import '../module_chat/manager/chat/chat_manager.dart' as _i46;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i27;
import '../module_chat/service/chat/char_service.dart' as _i47;
import '../module_chat/state_manager/chat_state_manager.dart' as _i48;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i76;
import '../module_home/home_module.dart' as _i96;
import '../module_home/manager/home_manager.dart' as _i50;
import '../module_home/repository/home_repository.dart' as _i28;
import '../module_home/service/home_service.dart' as _i51;
import '../module_home/state_manager/home_state_manager.dart' as _i52;
import '../module_home/ui/screen/home_screen.dart' as _i79;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i11;
import '../module_main/main_module.dart' as _i21;
import '../module_main/ui/screen/main_screen.dart' as _i13;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i54;
import '../module_my_notifications/my_notifications_module.dart' as _i97;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i31;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i55;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i56;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i80;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i14;
import '../module_notifications/repository/notification_repo.dart' as _i33;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i49;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import '../module_orders/manager/my_orders_manager.dart' as _i57;
import '../module_orders/orders_module.dart' as _i102;
import '../module_orders/repository/orders_repository.dart' as _i32;
import '../module_orders/service/orders_service.dart' as _i58;
import '../module_orders/state_manager/client_order_state_manager.dart' as _i77;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i81;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i82;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i83;
import '../module_orders/state_manager/order_status_state_manager.dart' as _i84;
import '../module_orders/ui/screen/client_order_screen.dart' as _i94;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i98;
import '../module_orders/ui/screen/order_details_screen.dart' as _i99;
import '../module_orders/ui/screen/order_logs_screen.dart' as _i100;
import '../module_orders/ui/screen/order_status_screen.dart' as _i101;
import '../module_our_services/manager/manager.dart' as _i63;
import '../module_our_services/repository/services_repository.dart' as _i39;
import '../module_our_services/service/services_service.dart' as _i64;
import '../module_our_services/services_module.dart' as _i107;
import '../module_our_services/state_manager/private_order_state_manager.dart'
    as _i86;
import '../module_our_services/state_manager/services_state_manager.dart'
    as _i65;
import '../module_our_services/ui/screen/private_order_screen.dart' as _i104;
import '../module_our_services/ui/screen/send_it_screen.dart' as _i89;
import '../module_products/manager/products_manager.dart' as _i59;
import '../module_products/products_module.dart' as _i106;
import '../module_products/repository/products_repository.dart' as _i34;
import '../module_products/service/products_service.dart' as _i60;
import '../module_products/state_manager/products_state_manager.dart' as _i87;
import '../module_products/ui/screen/cart_screen.dart' as _i4;
import '../module_products/ui/screen/products_details_screen.dart' as _i105;
import '../module_search/manager/search_manager.dart' as _i36;
import '../module_search/repository/search_repository.dart' as _i22;
import '../module_search/search_module.dart' as _i88;
import '../module_search/service/search_service.dart' as _i37;
import '../module_search/state_manager/search_state_manager.dart' as _i38;
import '../module_search/ui/screen/search_screen.dart' as _i62;
import '../module_settings/settings_module.dart' as _i90;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/settings_page.dart' as _i66;
import '../module_splash/splash_module.dart' as _i67;
import '../module_splash/ui/screen/splash_screen.dart' as _i40;
import '../module_stores/manager/store_list_manager.dart' as _i41;
import '../module_stores/manager/store_products.dart' as _i69;
import '../module_stores/repository/store_list_repository.dart' as _i23;
import '../module_stores/repository/store_products_repository.dart' as _i44;
import '../module_stores/service/store_list_service.dart' as _i42;
import '../module_stores/service/store_products_service.dart' as _i70;
import '../module_stores/state_manager/store_list_state_manager.dart' as _i43;
import '../module_stores/state_manager/store_products_state_manager.dart'
    as _i71;
import '../module_stores/store_module.dart' as _i108;
import '../module_stores/ui/screen/store_list_screen.dart' as _i68;
import '../module_stores/ui/screen/store_products_screen.dart' as _i91;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i24;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i29;
import '../utils/global/global_state_manager.dart' as _i8;
import '../utils/helpers/fire_store_helper.dart' as _i7;
import '../utils/logger/logger.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.CartScreen>(() => _i4.CartScreen());
  gh.factory<_i5.ChatHiveHelper>(() => _i5.ChatHiveHelper());
  gh.singleton<_i6.FavoriteHiveHelper>(_i6.FavoriteHiveHelper());
  gh.factory<_i7.FireStoreHelper>(() => _i7.FireStoreHelper());
  gh.singleton<_i8.GlobalStateManager>(_i8.GlobalStateManager());
  gh.factory<_i9.LocalNotificationService>(
      () => _i9.LocalNotificationService());
  gh.factory<_i10.LocalizationPreferencesHelper>(
      () => _i10.LocalizationPreferencesHelper());
  gh.factory<_i11.LocalizationService>(() =>
      _i11.LocalizationService(get<_i10.LocalizationPreferencesHelper>()));
  gh.factory<_i12.Logger>(() => _i12.Logger());
  gh.factory<_i13.MainScreen>(() => _i13.MainScreen());
  gh.factory<_i14.NotificationsPrefsHelper>(
      () => _i14.NotificationsPrefsHelper());
  gh.factory<_i15.ThemePreferencesHelper>(() => _i15.ThemePreferencesHelper());
  gh.factory<_i16.UploadRepository>(() => _i16.UploadRepository());
  gh.factory<_i17.ApiClient>(() => _i17.ApiClient(get<_i12.Logger>()));
  gh.factory<_i18.AppThemeDataService>(
      () => _i18.AppThemeDataService(get<_i15.ThemePreferencesHelper>()));
  gh.factory<_i19.AuthRepository>(
      () => _i19.AuthRepository(get<_i17.ApiClient>(), get<_i12.Logger>()));
  gh.factory<_i20.ChooseLocalScreen>(
      () => _i20.ChooseLocalScreen(get<_i11.LocalizationService>()));
  gh.factory<_i21.MainModule>(() => _i21.MainModule(get<_i13.MainScreen>()));
  gh.factory<_i22.SearchRepository>(
      () => _i22.SearchRepository(get<_i17.ApiClient>()));
  gh.factory<_i23.StoreListRepository>(
      () => _i23.StoreListRepository(get<_i17.ApiClient>()));
  gh.factory<_i24.UploadManager>(
      () => _i24.UploadManager(get<_i16.UploadRepository>()));
  gh.factory<_i25.AuthManager>(
      () => _i25.AuthManager(get<_i19.AuthRepository>()));
  gh.factory<_i26.AuthService>(() =>
      _i26.AuthService(get<_i3.AuthPrefsHelper>(), get<_i25.AuthManager>()));
  gh.factory<_i27.ChatRepository>(() =>
      _i27.ChatRepository(get<_i17.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i28.HomeRepository>(() =>
      _i28.HomeRepository(get<_i17.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i29.ImageUploadService>(
      () => _i29.ImageUploadService(get<_i24.UploadManager>()));
  gh.factory<_i30.LoginStateManager>(
      () => _i30.LoginStateManager(get<_i26.AuthService>()));
  gh.factory<_i31.MyNotificationsRepository>(() =>
      _i31.MyNotificationsRepository(
          get<_i17.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i32.MyOrdersRepository>(() =>
      _i32.MyOrdersRepository(get<_i17.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i33.NotificationRepo>(() =>
      _i33.NotificationRepo(get<_i17.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i34.ProductsRepository>(() =>
      _i34.ProductsRepository(get<_i17.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i35.RegisterStateManager>(
      () => _i35.RegisterStateManager(get<_i26.AuthService>()));
  gh.factory<_i36.SearchManager>(
      () => _i36.SearchManager(get<_i22.SearchRepository>()));
  gh.factory<_i37.SearchService>(
      () => _i37.SearchService(get<_i36.SearchManager>()));
  gh.factory<_i38.SearchStateManager>(
      () => _i38.SearchStateManager(get<_i37.SearchService>()));
  gh.factory<_i39.ServicesRepository>(() =>
      _i39.ServicesRepository(get<_i17.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i40.SplashScreen>(() => _i40.SplashScreen(
      get<_i26.AuthService>(), get<_i11.LocalizationService>()));
  gh.factory<_i41.StoreListManager>(
      () => _i41.StoreListManager(get<_i23.StoreListRepository>()));
  gh.factory<_i42.StoreListService>(
      () => _i42.StoreListService(get<_i41.StoreListManager>()));
  gh.factory<_i43.StoreListStateManager>(
      () => _i43.StoreListStateManager(get<_i42.StoreListService>()));
  gh.factory<_i44.StoreProductsRepository>(() => _i44.StoreProductsRepository(
      get<_i17.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i45.AccountRepository>(() =>
      _i45.AccountRepository(get<_i26.AuthService>(), get<_i17.ApiClient>()));
  gh.factory<_i46.ChatManager>(
      () => _i46.ChatManager(get<_i27.ChatRepository>()));
  gh.factory<_i47.ChatService>(() => _i47.ChatService(get<_i46.ChatManager>()));
  gh.factory<_i48.ChatStateManager>(
      () => _i48.ChatStateManager(get<_i47.ChatService>()));
  gh.factory<_i49.FireNotificationService>(() => _i49.FireNotificationService(
      get<_i14.NotificationsPrefsHelper>(), get<_i33.NotificationRepo>()));
  gh.factory<_i50.HomeManager>(
      () => _i50.HomeManager(get<_i28.HomeRepository>()));
  gh.factory<_i51.HomeService>(() => _i51.HomeService(get<_i50.HomeManager>()));
  gh.factory<_i52.HomeStateManager>(
      () => _i52.HomeStateManager(get<_i51.HomeService>()));
  gh.factory<_i53.LoginScreen>(
      () => _i53.LoginScreen(get<_i30.LoginStateManager>()));
  gh.factory<_i54.MyNotificationsManager>(
      () => _i54.MyNotificationsManager(get<_i31.MyNotificationsRepository>()));
  gh.factory<_i55.MyNotificationsService>(
      () => _i55.MyNotificationsService(get<_i54.MyNotificationsManager>()));
  gh.factory<_i56.MyNotificationsStateManager>(() =>
      _i56.MyNotificationsStateManager(
          get<_i55.MyNotificationsService>(), get<_i26.AuthService>()));
  gh.factory<_i57.MyOrdersManager>(
      () => _i57.MyOrdersManager(get<_i32.MyOrdersRepository>()));
  gh.factory<_i58.OrdersService>(() => _i58.OrdersService(
      get<_i57.MyOrdersManager>(), get<_i7.FireStoreHelper>()));
  gh.factory<_i59.ProductsManager>(
      () => _i59.ProductsManager(get<_i34.ProductsRepository>()));
  gh.factory<_i60.ProductsService>(
      () => _i60.ProductsService(get<_i59.ProductsManager>()));
  gh.factory<_i61.RegisterScreen>(
      () => _i61.RegisterScreen(get<_i35.RegisterStateManager>()));
  gh.factory<_i62.SearchScreen>(
      () => _i62.SearchScreen(get<_i38.SearchStateManager>()));
  gh.factory<_i63.ServicesManager>(
      () => _i63.ServicesManager(get<_i39.ServicesRepository>()));
  gh.factory<_i64.ServicesService>(() => _i64.ServicesService(
      get<_i63.ServicesManager>(), get<_i7.FireStoreHelper>()));
  gh.factory<_i65.ServicesStateManager>(() => _i65.ServicesStateManager(
      get<_i64.ServicesService>(), get<_i26.AuthService>()));
  gh.factory<_i66.SettingsScreen>(() => _i66.SettingsScreen(
      get<_i26.AuthService>(),
      get<_i11.LocalizationService>(),
      get<_i18.AppThemeDataService>(),
      get<_i49.FireNotificationService>()));
  gh.factory<_i67.SplashModule>(
      () => _i67.SplashModule(get<_i40.SplashScreen>()));
  gh.factory<_i68.StoreListScreen>(
      () => _i68.StoreListScreen(get<_i43.StoreListStateManager>()));
  gh.factory<_i69.StoreProductsManager>(
      () => _i69.StoreProductsManager(get<_i44.StoreProductsRepository>()));
  gh.factory<_i70.StoreProductsService>(
      () => _i70.StoreProductsService(get<_i69.StoreProductsManager>()));
  gh.factory<_i71.StoreProductsStateManager>(
      () => _i71.StoreProductsStateManager(get<_i70.StoreProductsService>()));
  gh.factory<_i72.AccountManager>(
      () => _i72.AccountManager(get<_i45.AccountRepository>()));
  gh.factory<_i73.AccountService>(
      () => _i73.AccountService(get<_i72.AccountManager>()));
  gh.factory<_i74.AccountStateManager>(() => _i74.AccountStateManager(
      get<_i73.AccountService>(), get<_i26.AuthService>()));
  gh.factory<_i75.AuthorizationModule>(() => _i75.AuthorizationModule(
      get<_i53.LoginScreen>(), get<_i61.RegisterScreen>()));
  gh.factory<_i76.ChatPage>(() => _i76.ChatPage(
      get<_i48.ChatStateManager>(),
      get<_i29.ImageUploadService>(),
      get<_i26.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i77.ClientOrderStateManager>(() => _i77.ClientOrderStateManager(
      get<_i58.OrdersService>(), get<_i26.AuthService>()));
  gh.factory<_i78.FavouriteStateManager>(() => _i78.FavouriteStateManager(
      get<_i73.AccountService>(),
      get<_i26.AuthService>(),
      get<_i51.HomeService>()));
  gh.factory<_i79.HomeScreen>(
      () => _i79.HomeScreen(get<_i52.HomeStateManager>()));
  gh.factory<_i80.MyNotificationsScreen>(() =>
      _i80.MyNotificationsScreen(get<_i56.MyNotificationsStateManager>()));
  gh.factory<_i81.MyOrdersStateManager>(() => _i81.MyOrdersStateManager(
      get<_i58.OrdersService>(),
      get<_i26.AuthService>(),
      get<_i7.FireStoreHelper>()));
  gh.factory<_i82.OrderDetailsStateManager>(() => _i82.OrderDetailsStateManager(
      get<_i58.OrdersService>(), get<_i7.FireStoreHelper>()));
  gh.factory<_i83.OrderLogsStateManager>(
      () => _i83.OrderLogsStateManager(get<_i58.OrdersService>()));
  gh.factory<_i84.OrderStatusStateManager>(() => _i84.OrderStatusStateManager(
      get<_i58.OrdersService>(), get<_i7.FireStoreHelper>()));
  gh.factory<_i85.PersonalDataStateManager>(() => _i85.PersonalDataStateManager(
      get<_i73.AccountService>(), get<_i29.ImageUploadService>()));
  gh.factory<_i86.PrivateOrderStateManager>(() => _i86.PrivateOrderStateManager(
      get<_i64.ServicesService>(), get<_i26.AuthService>()));
  gh.factory<_i87.ProductDetailsStateManager>(
      () => _i87.ProductDetailsStateManager(get<_i60.ProductsService>()));
  gh.factory<_i88.SearchModule>(
      () => _i88.SearchModule(get<_i62.SearchScreen>()));
  gh.factory<_i89.SendItScreen>(
      () => _i89.SendItScreen(get<_i65.ServicesStateManager>()));
  gh.factory<_i90.SettingsModule>(() => _i90.SettingsModule(
      get<_i66.SettingsScreen>(), get<_i20.ChooseLocalScreen>()));
  gh.factory<_i91.StoreProductsScreen>(() => _i91.StoreProductsScreen(
      get<_i71.StoreProductsStateManager>(), get<_i26.AuthService>()));
  gh.factory<_i92.AccountScreen>(
      () => _i92.AccountScreen(get<_i74.AccountStateManager>()));
  gh.factory<_i93.ChatModule>(
      () => _i93.ChatModule(get<_i76.ChatPage>(), get<_i26.AuthService>()));
  gh.factory<_i94.ClientOrderScreen>(
      () => _i94.ClientOrderScreen(get<_i77.ClientOrderStateManager>()));
  gh.factory<_i95.FavouritScreen>(
      () => _i95.FavouritScreen(get<_i78.FavouriteStateManager>()));
  gh.factory<_i96.HomeModule>(() => _i96.HomeModule(get<_i79.HomeScreen>()));
  gh.factory<_i97.MyNotificationsModule>(
      () => _i97.MyNotificationsModule(get<_i80.MyNotificationsScreen>()));
  gh.factory<_i98.MyOrdersScreen>(
      () => _i98.MyOrdersScreen(get<_i81.MyOrdersStateManager>()));
  gh.factory<_i99.OrderDetailsScreen>(
      () => _i99.OrderDetailsScreen(get<_i82.OrderDetailsStateManager>()));
  gh.factory<_i100.OrderLogsScreen>(
      () => _i100.OrderLogsScreen(get<_i83.OrderLogsStateManager>()));
  gh.factory<_i101.OrderStatusScreen>(
      () => _i101.OrderStatusScreen(get<_i84.OrderStatusStateManager>()));
  gh.factory<_i102.OrdersModule>(() => _i102.OrdersModule(
      get<_i98.MyOrdersScreen>(),
      get<_i99.OrderDetailsScreen>(),
      get<_i101.OrderStatusScreen>(),
      get<_i94.ClientOrderScreen>(),
      get<_i100.OrderLogsScreen>()));
  gh.factory<_i103.PersonalDataScreen>(
      () => _i103.PersonalDataScreen(get<_i85.PersonalDataStateManager>()));
  gh.factory<_i104.PrivateOrderScreen>(
      () => _i104.PrivateOrderScreen(get<_i86.PrivateOrderStateManager>()));
  gh.factory<_i105.ProductDetailsScreen>(
      () => _i105.ProductDetailsScreen(get<_i87.ProductDetailsStateManager>()));
  gh.factory<_i106.ProductsModule>(() => _i106.ProductsModule(
      get<_i105.ProductDetailsScreen>(), get<_i4.CartScreen>()));
  gh.factory<_i107.ServicesModule>(() => _i107.ServicesModule(
      get<_i89.SendItScreen>(), get<_i104.PrivateOrderScreen>()));
  gh.factory<_i108.StoreModule>(() => _i108.StoreModule(
      get<_i68.StoreListScreen>(), get<_i91.StoreProductsScreen>()));
  gh.factory<_i109.AccountModule>(() => _i109.AccountModule(
      get<_i92.AccountScreen>(), get<_i103.PersonalDataScreen>()));
  gh.factory<_i110.MyApp>(() => _i110.MyApp(
      get<_i18.AppThemeDataService>(),
      get<_i11.LocalizationService>(),
      get<_i49.FireNotificationService>(),
      get<_i9.LocalNotificationService>(),
      get<_i67.SplashModule>(),
      get<_i75.AuthorizationModule>(),
      get<_i93.ChatModule>(),
      get<_i90.SettingsModule>(),
      get<_i21.MainModule>(),
      get<_i102.OrdersModule>(),
      get<_i88.SearchModule>(),
      get<_i109.AccountModule>(),
      get<_i107.ServicesModule>(),
      get<_i108.StoreModule>(),
      get<_i97.MyNotificationsModule>(),
      get<_i106.ProductsModule>()));
  return get;
}
