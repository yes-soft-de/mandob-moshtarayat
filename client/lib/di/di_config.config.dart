// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i113;
import '../module_account/account_module.dart' as _i112;
import '../module_account/hive/favorite_store_category.dart' as _i7;
import '../module_account/manager/account_manager.dart' as _i75;
import '../module_account/repository/account_repository.dart' as _i48;
import '../module_account/service/account_service.dart' as _i76;
import '../module_account/state_manager/account_state_manager.dart' as _i77;
import '../module_account/state_manager/favorite_state_manager.dart' as _i81;
import '../module_account/state_manager/presonal_data_state_manager.dart'
    as _i88;
import '../module_account/ui/screen/about.dart' as _i3;
import '../module_account/ui/screen/account_screen.dart' as _i95;
import '../module_account/ui/screen/favourite_screen.dart' as _i98;
import '../module_account/ui/screen/presonal_data_screen.dart' as _i106;
import '../module_account/ui/screen/privecy_policy.dart' as _i16;
import '../module_account/ui/screen/terms_of_use.dart' as _i17;
import '../module_auth/authoriazation_module.dart' as _i78;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i28;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i22;
import '../module_auth/service/auth_service/auth_service.dart' as _i29;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i33;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i38;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i56;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i64;
import '../module_chat/chat_module.dart' as _i96;
import '../module_chat/manager/chat/chat_manager.dart' as _i49;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i30;
import '../module_chat/service/chat/char_service.dart' as _i50;
import '../module_chat/state_manager/chat_state_manager.dart' as _i51;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i79;
import '../module_home/home_module.dart' as _i99;
import '../module_home/manager/home_manager.dart' as _i53;
import '../module_home/repository/home_repository.dart' as _i31;
import '../module_home/service/home_service.dart' as _i54;
import '../module_home/state_manager/home_state_manager.dart' as _i55;
import '../module_home/ui/screen/home_screen.dart' as _i82;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i11;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i12;
import '../module_main/main_module.dart' as _i24;
import '../module_main/ui/screen/main_screen.dart' as _i14;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i57;
import '../module_my_notifications/my_notifications_module.dart' as _i100;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i34;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i58;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i59;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i83;
import '../module_network/http_client/http_client.dart' as _i20;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i15;
import '../module_notifications/repository/notification_repo.dart' as _i36;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i52;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i10;
import '../module_orders/manager/my_orders_manager.dart' as _i60;
import '../module_orders/orders_module.dart' as _i105;
import '../module_orders/repository/orders_repository.dart' as _i35;
import '../module_orders/service/orders_service.dart' as _i61;
import '../module_orders/state_manager/client_order_state_manager.dart' as _i80;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i84;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i85;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i86;
import '../module_orders/state_manager/order_status_state_manager.dart' as _i87;
import '../module_orders/ui/screen/client_order_screen.dart' as _i97;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i101;
import '../module_orders/ui/screen/order_details_screen.dart' as _i102;
import '../module_orders/ui/screen/order_logs_screen.dart' as _i103;
import '../module_orders/ui/screen/order_status_screen.dart' as _i104;
import '../module_our_services/manager/manager.dart' as _i66;
import '../module_our_services/repository/services_repository.dart' as _i42;
import '../module_our_services/service/services_service.dart' as _i67;
import '../module_our_services/services_module.dart' as _i110;
import '../module_our_services/state_manager/private_order_state_manager.dart'
    as _i89;
import '../module_our_services/state_manager/services_state_manager.dart'
    as _i68;
import '../module_our_services/ui/screen/private_order_screen.dart' as _i107;
import '../module_our_services/ui/screen/send_it_screen.dart' as _i92;
import '../module_products/manager/products_manager.dart' as _i62;
import '../module_products/products_module.dart' as _i109;
import '../module_products/repository/products_repository.dart' as _i37;
import '../module_products/service/products_service.dart' as _i63;
import '../module_products/state_manager/products_state_manager.dart' as _i90;
import '../module_products/ui/screen/cart_screen.dart' as _i5;
import '../module_products/ui/screen/products_details_screen.dart' as _i108;
import '../module_search/manager/search_manager.dart' as _i39;
import '../module_search/repository/search_repository.dart' as _i25;
import '../module_search/search_module.dart' as _i91;
import '../module_search/service/search_service.dart' as _i40;
import '../module_search/state_manager/search_state_manager.dart' as _i41;
import '../module_search/ui/screen/search_screen.dart' as _i65;
import '../module_settings/settings_module.dart' as _i93;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i23;
import '../module_settings/ui/settings_page/settings_page.dart' as _i69;
import '../module_splash/splash_module.dart' as _i70;
import '../module_splash/ui/screen/splash_screen.dart' as _i43;
import '../module_stores/manager/store_list_manager.dart' as _i44;
import '../module_stores/manager/store_products.dart' as _i72;
import '../module_stores/repository/store_list_repository.dart' as _i26;
import '../module_stores/repository/store_products_repository.dart' as _i47;
import '../module_stores/service/store_list_service.dart' as _i45;
import '../module_stores/service/store_products_service.dart' as _i73;
import '../module_stores/state_manager/store_list_state_manager.dart' as _i46;
import '../module_stores/state_manager/store_products_state_manager.dart'
    as _i74;
import '../module_stores/store_module.dart' as _i111;
import '../module_stores/ui/screen/store_list_screen.dart' as _i71;
import '../module_stores/ui/screen/store_products_screen.dart' as _i94;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i18;
import '../module_theme/service/theme_service/theme_service.dart' as _i21;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i27;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i19;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i32;
import '../utils/global/global_state_manager.dart' as _i9;
import '../utils/helpers/fire_store_helper.dart' as _i8;
import '../utils/logger/logger.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutScreen>(() => _i3.AboutScreen());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.CartScreen>(() => _i5.CartScreen());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
  gh.singleton<_i7.FavoriteHiveHelper>(_i7.FavoriteHiveHelper());
  gh.factory<_i8.FireStoreHelper>(() => _i8.FireStoreHelper());
  gh.singleton<_i9.GlobalStateManager>(_i9.GlobalStateManager());
  gh.factory<_i10.LocalNotificationService>(
      () => _i10.LocalNotificationService());
  gh.factory<_i11.LocalizationPreferencesHelper>(
      () => _i11.LocalizationPreferencesHelper());
  gh.factory<_i12.LocalizationService>(() =>
      _i12.LocalizationService(get<_i11.LocalizationPreferencesHelper>()));
  gh.factory<_i13.Logger>(() => _i13.Logger());
  gh.factory<_i14.MainScreen>(() => _i14.MainScreen());
  gh.factory<_i15.NotificationsPrefHelper>(
      () => _i15.NotificationsPrefHelper());
  gh.factory<_i16.PrivecyPolicy>(() => _i16.PrivecyPolicy());
  gh.factory<_i17.TermsOfUse>(() => _i17.TermsOfUse());
  gh.factory<_i18.ThemePreferencesHelper>(() => _i18.ThemePreferencesHelper());
  gh.factory<_i19.UploadRepository>(() => _i19.UploadRepository());
  gh.factory<_i20.ApiClient>(() => _i20.ApiClient(get<_i13.Logger>()));
  gh.factory<_i21.AppThemeDataService>(
      () => _i21.AppThemeDataService(get<_i18.ThemePreferencesHelper>()));
  gh.factory<_i22.AuthRepository>(
      () => _i22.AuthRepository(get<_i20.ApiClient>(), get<_i13.Logger>()));
  gh.factory<_i23.ChooseLocalScreen>(
      () => _i23.ChooseLocalScreen(get<_i12.LocalizationService>()));
  gh.factory<_i24.MainModule>(() => _i24.MainModule(get<_i14.MainScreen>()));
  gh.factory<_i25.SearchRepository>(
      () => _i25.SearchRepository(get<_i20.ApiClient>()));
  gh.factory<_i26.StoreListRepository>(
      () => _i26.StoreListRepository(get<_i20.ApiClient>()));
  gh.factory<_i27.UploadManager>(
      () => _i27.UploadManager(get<_i19.UploadRepository>()));
  gh.factory<_i28.AuthManager>(
      () => _i28.AuthManager(get<_i22.AuthRepository>()));
  gh.factory<_i29.AuthService>(() =>
      _i29.AuthService(get<_i4.AuthPrefsHelper>(), get<_i28.AuthManager>()));
  gh.factory<_i30.ChatRepository>(() =>
      _i30.ChatRepository(get<_i20.ApiClient>(), get<_i29.AuthService>()));
  gh.factory<_i31.HomeRepository>(() =>
      _i31.HomeRepository(get<_i20.ApiClient>(), get<_i29.AuthService>()));
  gh.factory<_i32.ImageUploadService>(
      () => _i32.ImageUploadService(get<_i27.UploadManager>()));
  gh.factory<_i33.LoginStateManager>(
      () => _i33.LoginStateManager(get<_i29.AuthService>()));
  gh.factory<_i34.MyNotificationsRepository>(() =>
      _i34.MyNotificationsRepository(
          get<_i20.ApiClient>(), get<_i29.AuthService>()));
  gh.factory<_i35.MyOrdersRepository>(() =>
      _i35.MyOrdersRepository(get<_i20.ApiClient>(), get<_i29.AuthService>()));
  gh.factory<_i36.NotificationRepo>(() =>
      _i36.NotificationRepo(get<_i20.ApiClient>(), get<_i29.AuthService>()));
  gh.factory<_i37.ProductsRepository>(() =>
      _i37.ProductsRepository(get<_i20.ApiClient>(), get<_i29.AuthService>()));
  gh.factory<_i38.RegisterStateManager>(
      () => _i38.RegisterStateManager(get<_i29.AuthService>()));
  gh.factory<_i39.SearchManager>(
      () => _i39.SearchManager(get<_i25.SearchRepository>()));
  gh.factory<_i40.SearchService>(
      () => _i40.SearchService(get<_i39.SearchManager>()));
  gh.factory<_i41.SearchStateManager>(
      () => _i41.SearchStateManager(get<_i40.SearchService>()));
  gh.factory<_i42.ServicesRepository>(() =>
      _i42.ServicesRepository(get<_i20.ApiClient>(), get<_i29.AuthService>()));
  gh.factory<_i43.SplashScreen>(() => _i43.SplashScreen(
      get<_i29.AuthService>(), get<_i12.LocalizationService>()));
  gh.factory<_i44.StoreListManager>(
      () => _i44.StoreListManager(get<_i26.StoreListRepository>()));
  gh.factory<_i45.StoreListService>(
      () => _i45.StoreListService(get<_i44.StoreListManager>()));
  gh.factory<_i46.StoreListStateManager>(
      () => _i46.StoreListStateManager(get<_i45.StoreListService>()));
  gh.factory<_i47.StoreProductsRepository>(() => _i47.StoreProductsRepository(
      get<_i20.ApiClient>(), get<_i29.AuthService>()));
  gh.factory<_i48.AccountRepository>(() =>
      _i48.AccountRepository(get<_i29.AuthService>(), get<_i20.ApiClient>()));
  gh.factory<_i49.ChatManager>(
      () => _i49.ChatManager(get<_i30.ChatRepository>()));
  gh.factory<_i50.ChatService>(() => _i50.ChatService(get<_i49.ChatManager>()));
  gh.factory<_i51.ChatStateManager>(
      () => _i51.ChatStateManager(get<_i50.ChatService>()));
  gh.factory<_i52.FireNotificationService>(() => _i52.FireNotificationService(
      get<_i15.NotificationsPrefHelper>(), get<_i36.NotificationRepo>()));
  gh.factory<_i53.HomeManager>(
      () => _i53.HomeManager(get<_i31.HomeRepository>()));
  gh.factory<_i54.HomeService>(() => _i54.HomeService(get<_i53.HomeManager>()));
  gh.factory<_i55.HomeStateManager>(
      () => _i55.HomeStateManager(get<_i54.HomeService>()));
  gh.factory<_i56.LoginScreen>(
      () => _i56.LoginScreen(get<_i33.LoginStateManager>()));
  gh.factory<_i57.MyNotificationsManager>(
      () => _i57.MyNotificationsManager(get<_i34.MyNotificationsRepository>()));
  gh.factory<_i58.MyNotificationsService>(
      () => _i58.MyNotificationsService(get<_i57.MyNotificationsManager>()));
  gh.factory<_i59.MyNotificationsStateManager>(() =>
      _i59.MyNotificationsStateManager(
          get<_i58.MyNotificationsService>(), get<_i29.AuthService>()));
  gh.factory<_i60.MyOrdersManager>(
      () => _i60.MyOrdersManager(get<_i35.MyOrdersRepository>()));
  gh.factory<_i61.OrdersService>(() => _i61.OrdersService(
      get<_i60.MyOrdersManager>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i62.ProductsManager>(
      () => _i62.ProductsManager(get<_i37.ProductsRepository>()));
  gh.factory<_i63.ProductsService>(
      () => _i63.ProductsService(get<_i62.ProductsManager>()));
  gh.factory<_i64.RegisterScreen>(
      () => _i64.RegisterScreen(get<_i38.RegisterStateManager>()));
  gh.factory<_i65.SearchScreen>(
      () => _i65.SearchScreen(get<_i41.SearchStateManager>()));
  gh.factory<_i66.ServicesManager>(
      () => _i66.ServicesManager(get<_i42.ServicesRepository>()));
  gh.factory<_i67.ServicesService>(() => _i67.ServicesService(
      get<_i66.ServicesManager>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i68.ServicesStateManager>(() => _i68.ServicesStateManager(
      get<_i67.ServicesService>(), get<_i29.AuthService>()));
  gh.factory<_i69.SettingsScreen>(() => _i69.SettingsScreen(
      get<_i29.AuthService>(),
      get<_i12.LocalizationService>(),
      get<_i21.AppThemeDataService>(),
      get<_i52.FireNotificationService>()));
  gh.factory<_i70.SplashModule>(
      () => _i70.SplashModule(get<_i43.SplashScreen>()));
  gh.factory<_i71.StoreListScreen>(
      () => _i71.StoreListScreen(get<_i46.StoreListStateManager>()));
  gh.factory<_i72.StoreProductsManager>(
      () => _i72.StoreProductsManager(get<_i47.StoreProductsRepository>()));
  gh.factory<_i73.StoreProductsService>(
      () => _i73.StoreProductsService(get<_i72.StoreProductsManager>()));
  gh.factory<_i74.StoreProductsStateManager>(
      () => _i74.StoreProductsStateManager(get<_i73.StoreProductsService>()));
  gh.factory<_i75.AccountManager>(
      () => _i75.AccountManager(get<_i48.AccountRepository>()));
  gh.factory<_i76.AccountService>(
      () => _i76.AccountService(get<_i75.AccountManager>()));
  gh.factory<_i77.AccountStateManager>(() => _i77.AccountStateManager(
      get<_i76.AccountService>(), get<_i29.AuthService>()));
  gh.factory<_i78.AuthorizationModule>(() => _i78.AuthorizationModule(
      get<_i56.LoginScreen>(), get<_i64.RegisterScreen>()));
  gh.factory<_i79.ChatPage>(() => _i79.ChatPage(
      get<_i51.ChatStateManager>(),
      get<_i32.ImageUploadService>(),
      get<_i29.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i80.ClientOrderStateManager>(() => _i80.ClientOrderStateManager(
      get<_i61.OrdersService>(), get<_i29.AuthService>()));
  gh.factory<_i81.FavouriteStateManager>(() => _i81.FavouriteStateManager(
      get<_i76.AccountService>(), get<_i54.HomeService>()));
  gh.factory<_i82.HomeScreen>(
      () => _i82.HomeScreen(get<_i55.HomeStateManager>()));
  gh.factory<_i83.MyNotificationsScreen>(() =>
      _i83.MyNotificationsScreen(get<_i59.MyNotificationsStateManager>()));
  gh.factory<_i84.MyOrdersStateManager>(() => _i84.MyOrdersStateManager(
      get<_i61.OrdersService>(),
      get<_i29.AuthService>(),
      get<_i8.FireStoreHelper>()));
  gh.factory<_i85.OrderDetailsStateManager>(() => _i85.OrderDetailsStateManager(
      get<_i61.OrdersService>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i86.OrderLogsStateManager>(
      () => _i86.OrderLogsStateManager(get<_i61.OrdersService>()));
  gh.factory<_i87.OrderStatusStateManager>(() => _i87.OrderStatusStateManager(
      get<_i61.OrdersService>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i88.PersonalDataStateManager>(() => _i88.PersonalDataStateManager(
      get<_i76.AccountService>(), get<_i32.ImageUploadService>()));
  gh.factory<_i89.PrivateOrderStateManager>(() => _i89.PrivateOrderStateManager(
      get<_i67.ServicesService>(), get<_i29.AuthService>()));
  gh.factory<_i90.ProductDetailsStateManager>(
      () => _i90.ProductDetailsStateManager(get<_i63.ProductsService>()));
  gh.factory<_i91.SearchModule>(
      () => _i91.SearchModule(get<_i65.SearchScreen>()));
  gh.factory<_i92.SendItScreen>(
      () => _i92.SendItScreen(get<_i68.ServicesStateManager>()));
  gh.factory<_i93.SettingsModule>(() => _i93.SettingsModule(
      get<_i69.SettingsScreen>(), get<_i23.ChooseLocalScreen>()));
  gh.factory<_i94.StoreProductsScreen>(() => _i94.StoreProductsScreen(
      get<_i74.StoreProductsStateManager>(), get<_i29.AuthService>()));
  gh.factory<_i95.AccountScreen>(
      () => _i95.AccountScreen(get<_i77.AccountStateManager>()));
  gh.factory<_i96.ChatModule>(
      () => _i96.ChatModule(get<_i79.ChatPage>(), get<_i29.AuthService>()));
  gh.factory<_i97.ClientOrderScreen>(
      () => _i97.ClientOrderScreen(get<_i80.ClientOrderStateManager>()));
  gh.factory<_i98.FavouritScreen>(
      () => _i98.FavouritScreen(get<_i81.FavouriteStateManager>()));
  gh.factory<_i99.HomeModule>(() => _i99.HomeModule(get<_i82.HomeScreen>()));
  gh.factory<_i100.MyNotificationsModule>(
      () => _i100.MyNotificationsModule(get<_i83.MyNotificationsScreen>()));
  gh.factory<_i101.MyOrdersScreen>(
      () => _i101.MyOrdersScreen(get<_i84.MyOrdersStateManager>()));
  gh.factory<_i102.OrderDetailsScreen>(
      () => _i102.OrderDetailsScreen(get<_i85.OrderDetailsStateManager>()));
  gh.factory<_i103.OrderLogsScreen>(
      () => _i103.OrderLogsScreen(get<_i86.OrderLogsStateManager>()));
  gh.factory<_i104.OrderStatusScreen>(
      () => _i104.OrderStatusScreen(get<_i87.OrderStatusStateManager>()));
  gh.factory<_i105.OrdersModule>(() => _i105.OrdersModule(
      get<_i101.MyOrdersScreen>(),
      get<_i102.OrderDetailsScreen>(),
      get<_i104.OrderStatusScreen>(),
      get<_i97.ClientOrderScreen>(),
      get<_i103.OrderLogsScreen>()));
  gh.factory<_i106.PersonalDataScreen>(
      () => _i106.PersonalDataScreen(get<_i88.PersonalDataStateManager>()));
  gh.factory<_i107.PrivateOrderScreen>(
      () => _i107.PrivateOrderScreen(get<_i89.PrivateOrderStateManager>()));
  gh.factory<_i108.ProductDetailsScreen>(
      () => _i108.ProductDetailsScreen(get<_i90.ProductDetailsStateManager>()));
  gh.factory<_i109.ProductsModule>(() => _i109.ProductsModule(
      get<_i108.ProductDetailsScreen>(), get<_i5.CartScreen>()));
  gh.factory<_i110.ServicesModule>(() => _i110.ServicesModule(
      get<_i92.SendItScreen>(), get<_i107.PrivateOrderScreen>()));
  gh.factory<_i111.StoreModule>(() => _i111.StoreModule(
      get<_i71.StoreListScreen>(), get<_i94.StoreProductsScreen>()));
  gh.factory<_i112.AccountModule>(() => _i112.AccountModule(
      get<_i95.AccountScreen>(),
      get<_i106.PersonalDataScreen>(),
      get<_i3.AboutScreen>(),
      get<_i16.PrivecyPolicy>(),
      get<_i17.TermsOfUse>()));
  gh.factory<_i113.MyApp>(() => _i113.MyApp(
      get<_i21.AppThemeDataService>(),
      get<_i12.LocalizationService>(),
      get<_i52.FireNotificationService>(),
      get<_i10.LocalNotificationService>(),
      get<_i70.SplashModule>(),
      get<_i78.AuthorizationModule>(),
      get<_i96.ChatModule>(),
      get<_i93.SettingsModule>(),
      get<_i24.MainModule>(),
      get<_i105.OrdersModule>(),
      get<_i91.SearchModule>(),
      get<_i112.AccountModule>(),
      get<_i110.ServicesModule>(),
      get<_i111.StoreModule>(),
      get<_i100.MyNotificationsModule>(),
      get<_i109.ProductsModule>()));
  return get;
}
