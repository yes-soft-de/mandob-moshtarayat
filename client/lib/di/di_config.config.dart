// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i114;
import '../module_account/account_module.dart' as _i113;
import '../module_account/hive/favorite_store_category.dart' as _i7;
import '../module_account/manager/account_manager.dart' as _i76;
import '../module_account/repository/account_repository.dart' as _i49;
import '../module_account/service/account_service.dart' as _i77;
import '../module_account/state_manager/account_state_manager.dart' as _i78;
import '../module_account/state_manager/favorite_state_manager.dart' as _i82;
import '../module_account/state_manager/presonal_data_state_manager.dart'
    as _i89;
import '../module_account/ui/screen/about.dart' as _i3;
import '../module_account/ui/screen/account_screen.dart' as _i96;
import '../module_account/ui/screen/favourite_screen.dart' as _i99;
import '../module_account/ui/screen/presonal_data_screen.dart' as _i107;
import '../module_account/ui/screen/privecy_policy.dart' as _i17;
import '../module_account/ui/screen/terms_of_use.dart' as _i18;
import '../module_auth/authoriazation_module.dart' as _i79;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i29;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i23;
import '../module_auth/service/auth_service/auth_service.dart' as _i30;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i34;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i39;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i57;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i65;
import '../module_chat/chat_module.dart' as _i97;
import '../module_chat/manager/chat/chat_manager.dart' as _i50;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i31;
import '../module_chat/service/chat/char_service.dart' as _i51;
import '../module_chat/state_manager/chat_state_manager.dart' as _i52;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i80;
import '../module_home/home_module.dart' as _i100;
import '../module_home/manager/home_manager.dart' as _i54;
import '../module_home/repository/home_repository.dart' as _i32;
import '../module_home/service/home_service.dart' as _i55;
import '../module_home/state_manager/home_state_manager.dart' as _i56;
import '../module_home/ui/screen/home_screen.dart' as _i83;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i11;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i12;
import '../module_main/main_module.dart' as _i25;
import '../module_main/ui/screen/main_screen.dart' as _i14;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i58;
import '../module_my_notifications/my_notifications_module.dart' as _i101;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i35;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i59;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i60;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i84;
import '../module_network/http_client/http_client.dart' as _i21;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i15;
import '../module_notifications/repository/notification_repo.dart' as _i37;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i53;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i10;
import '../module_orders/manager/my_orders_manager.dart' as _i61;
import '../module_orders/orders_module.dart' as _i106;
import '../module_orders/repository/orders_repository.dart' as _i36;
import '../module_orders/service/orders_service.dart' as _i62;
import '../module_orders/state_manager/client_order_state_manager.dart' as _i81;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i85;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i86;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i87;
import '../module_orders/state_manager/order_status_state_manager.dart' as _i88;
import '../module_orders/ui/screen/client_order_screen.dart' as _i98;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i102;
import '../module_orders/ui/screen/order_details_screen.dart' as _i103;
import '../module_orders/ui/screen/order_logs_screen.dart' as _i104;
import '../module_orders/ui/screen/order_status_screen.dart' as _i105;
import '../module_our_services/manager/manager.dart' as _i67;
import '../module_our_services/repository/services_repository.dart' as _i43;
import '../module_our_services/service/services_service.dart' as _i68;
import '../module_our_services/services_module.dart' as _i111;
import '../module_our_services/state_manager/private_order_state_manager.dart'
    as _i90;
import '../module_our_services/state_manager/services_state_manager.dart'
    as _i69;
import '../module_our_services/ui/screen/private_order_screen.dart' as _i108;
import '../module_our_services/ui/screen/send_it_screen.dart' as _i93;
import '../module_products/manager/products_manager.dart' as _i63;
import '../module_products/products_module.dart' as _i110;
import '../module_products/repository/products_repository.dart' as _i38;
import '../module_products/service/products_service.dart' as _i64;
import '../module_products/state_manager/products_state_manager.dart' as _i91;
import '../module_products/ui/screen/cart_screen.dart' as _i5;
import '../module_products/ui/screen/products_details_screen.dart' as _i109;
import '../module_search/manager/search_manager.dart' as _i40;
import '../module_search/repository/search_repository.dart' as _i26;
import '../module_search/search_module.dart' as _i92;
import '../module_search/service/search_service.dart' as _i41;
import '../module_search/state_manager/search_state_manager.dart' as _i42;
import '../module_search/ui/screen/search_screen.dart' as _i66;
import '../module_settings/settings_module.dart' as _i94;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i24;
import '../module_settings/ui/settings_page/settings_page.dart' as _i70;
import '../module_splash/splash_module.dart' as _i71;
import '../module_splash/ui/screen/splash_screen.dart' as _i44;
import '../module_stores/manager/store_list_manager.dart' as _i45;
import '../module_stores/manager/store_products.dart' as _i73;
import '../module_stores/repository/store_list_repository.dart' as _i27;
import '../module_stores/repository/store_products_repository.dart' as _i48;
import '../module_stores/service/store_list_service.dart' as _i46;
import '../module_stores/service/store_products_service.dart' as _i74;
import '../module_stores/state_manager/store_list_state_manager.dart' as _i47;
import '../module_stores/state_manager/store_products_state_manager.dart'
    as _i75;
import '../module_stores/store_module.dart' as _i112;
import '../module_stores/ui/screen/store_list_screen.dart' as _i72;
import '../module_stores/ui/screen/store_products_screen.dart' as _i95;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i19;
import '../module_theme/service/theme_service/theme_service.dart' as _i22;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i28;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i20;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i33;
import '../utils/global/global_state_manager.dart' as _i9;
import '../utils/helpers/fire_store_helper.dart' as _i8;
import '../utils/helpers/payment_portal.dart' as _i16;
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
  gh.factory<_i16.PaymentsPortal>(() => _i16.PaymentsPortal());
  gh.factory<_i17.PrivecyPolicy>(() => _i17.PrivecyPolicy());
  gh.factory<_i18.TermsOfUse>(() => _i18.TermsOfUse());
  gh.factory<_i19.ThemePreferencesHelper>(() => _i19.ThemePreferencesHelper());
  gh.factory<_i20.UploadRepository>(() => _i20.UploadRepository());
  gh.factory<_i21.ApiClient>(() => _i21.ApiClient(get<_i13.Logger>()));
  gh.factory<_i22.AppThemeDataService>(
      () => _i22.AppThemeDataService(get<_i19.ThemePreferencesHelper>()));
  gh.factory<_i23.AuthRepository>(
      () => _i23.AuthRepository(get<_i21.ApiClient>(), get<_i13.Logger>()));
  gh.factory<_i24.ChooseLocalScreen>(
      () => _i24.ChooseLocalScreen(get<_i12.LocalizationService>()));
  gh.factory<_i25.MainModule>(() => _i25.MainModule(get<_i14.MainScreen>()));
  gh.factory<_i26.SearchRepository>(
      () => _i26.SearchRepository(get<_i21.ApiClient>()));
  gh.factory<_i27.StoreListRepository>(
      () => _i27.StoreListRepository(get<_i21.ApiClient>()));
  gh.factory<_i28.UploadManager>(
      () => _i28.UploadManager(get<_i20.UploadRepository>()));
  gh.factory<_i29.AuthManager>(
      () => _i29.AuthManager(get<_i23.AuthRepository>()));
  gh.factory<_i30.AuthService>(() =>
      _i30.AuthService(get<_i4.AuthPrefsHelper>(), get<_i29.AuthManager>()));
  gh.factory<_i31.ChatRepository>(() =>
      _i31.ChatRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i32.HomeRepository>(() =>
      _i32.HomeRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i33.ImageUploadService>(
      () => _i33.ImageUploadService(get<_i28.UploadManager>()));
  gh.factory<_i34.LoginStateManager>(
      () => _i34.LoginStateManager(get<_i30.AuthService>()));
  gh.factory<_i35.MyNotificationsRepository>(() =>
      _i35.MyNotificationsRepository(
          get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i36.MyOrdersRepository>(() =>
      _i36.MyOrdersRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i37.NotificationRepo>(() =>
      _i37.NotificationRepo(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i38.ProductsRepository>(() =>
      _i38.ProductsRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i39.RegisterStateManager>(
      () => _i39.RegisterStateManager(get<_i30.AuthService>()));
  gh.factory<_i40.SearchManager>(
      () => _i40.SearchManager(get<_i26.SearchRepository>()));
  gh.factory<_i41.SearchService>(
      () => _i41.SearchService(get<_i40.SearchManager>()));
  gh.factory<_i42.SearchStateManager>(
      () => _i42.SearchStateManager(get<_i41.SearchService>()));
  gh.factory<_i43.ServicesRepository>(() =>
      _i43.ServicesRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i44.SplashScreen>(() => _i44.SplashScreen(
      get<_i30.AuthService>(), get<_i12.LocalizationService>()));
  gh.factory<_i45.StoreListManager>(
      () => _i45.StoreListManager(get<_i27.StoreListRepository>()));
  gh.factory<_i46.StoreListService>(
      () => _i46.StoreListService(get<_i45.StoreListManager>()));
  gh.factory<_i47.StoreListStateManager>(
      () => _i47.StoreListStateManager(get<_i46.StoreListService>()));
  gh.factory<_i48.StoreProductsRepository>(() => _i48.StoreProductsRepository(
      get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i49.AccountRepository>(() =>
      _i49.AccountRepository(get<_i30.AuthService>(), get<_i21.ApiClient>()));
  gh.factory<_i50.ChatManager>(
      () => _i50.ChatManager(get<_i31.ChatRepository>()));
  gh.factory<_i51.ChatService>(() => _i51.ChatService(get<_i50.ChatManager>()));
  gh.factory<_i52.ChatStateManager>(
      () => _i52.ChatStateManager(get<_i51.ChatService>()));
  gh.factory<_i53.FireNotificationService>(() => _i53.FireNotificationService(
      get<_i15.NotificationsPrefHelper>(), get<_i37.NotificationRepo>()));
  gh.factory<_i54.HomeManager>(
      () => _i54.HomeManager(get<_i32.HomeRepository>()));
  gh.factory<_i55.HomeService>(() => _i55.HomeService(get<_i54.HomeManager>()));
  gh.factory<_i56.HomeStateManager>(
      () => _i56.HomeStateManager(get<_i55.HomeService>()));
  gh.factory<_i57.LoginScreen>(
      () => _i57.LoginScreen(get<_i34.LoginStateManager>()));
  gh.factory<_i58.MyNotificationsManager>(
      () => _i58.MyNotificationsManager(get<_i35.MyNotificationsRepository>()));
  gh.factory<_i59.MyNotificationsService>(
      () => _i59.MyNotificationsService(get<_i58.MyNotificationsManager>()));
  gh.factory<_i60.MyNotificationsStateManager>(() =>
      _i60.MyNotificationsStateManager(
          get<_i59.MyNotificationsService>(), get<_i30.AuthService>()));
  gh.factory<_i61.MyOrdersManager>(
      () => _i61.MyOrdersManager(get<_i36.MyOrdersRepository>()));
  gh.factory<_i62.OrdersService>(() => _i62.OrdersService(
      get<_i61.MyOrdersManager>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i63.ProductsManager>(
      () => _i63.ProductsManager(get<_i38.ProductsRepository>()));
  gh.factory<_i64.ProductsService>(
      () => _i64.ProductsService(get<_i63.ProductsManager>()));
  gh.factory<_i65.RegisterScreen>(
      () => _i65.RegisterScreen(get<_i39.RegisterStateManager>()));
  gh.factory<_i66.SearchScreen>(
      () => _i66.SearchScreen(get<_i42.SearchStateManager>()));
  gh.factory<_i67.ServicesManager>(
      () => _i67.ServicesManager(get<_i43.ServicesRepository>()));
  gh.factory<_i68.ServicesService>(() => _i68.ServicesService(
      get<_i67.ServicesManager>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i69.ServicesStateManager>(() => _i69.ServicesStateManager(
      get<_i68.ServicesService>(), get<_i30.AuthService>()));
  gh.factory<_i70.SettingsScreen>(() => _i70.SettingsScreen(
      get<_i30.AuthService>(),
      get<_i12.LocalizationService>(),
      get<_i22.AppThemeDataService>(),
      get<_i53.FireNotificationService>()));
  gh.factory<_i71.SplashModule>(
      () => _i71.SplashModule(get<_i44.SplashScreen>()));
  gh.factory<_i72.StoreListScreen>(
      () => _i72.StoreListScreen(get<_i47.StoreListStateManager>()));
  gh.factory<_i73.StoreProductsManager>(
      () => _i73.StoreProductsManager(get<_i48.StoreProductsRepository>()));
  gh.factory<_i74.StoreProductsService>(
      () => _i74.StoreProductsService(get<_i73.StoreProductsManager>()));
  gh.factory<_i75.StoreProductsStateManager>(
      () => _i75.StoreProductsStateManager(get<_i74.StoreProductsService>()));
  gh.factory<_i76.AccountManager>(
      () => _i76.AccountManager(get<_i49.AccountRepository>()));
  gh.factory<_i77.AccountService>(
      () => _i77.AccountService(get<_i76.AccountManager>()));
  gh.factory<_i78.AccountStateManager>(() => _i78.AccountStateManager(
      get<_i77.AccountService>(), get<_i30.AuthService>()));
  gh.factory<_i79.AuthorizationModule>(() => _i79.AuthorizationModule(
      get<_i57.LoginScreen>(), get<_i65.RegisterScreen>()));
  gh.factory<_i80.ChatPage>(() => _i80.ChatPage(
      get<_i52.ChatStateManager>(),
      get<_i33.ImageUploadService>(),
      get<_i30.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i81.ClientOrderStateManager>(() => _i81.ClientOrderStateManager(
      get<_i62.OrdersService>(), get<_i30.AuthService>()));
  gh.factory<_i82.FavouriteStateManager>(() => _i82.FavouriteStateManager(
      get<_i77.AccountService>(), get<_i55.HomeService>()));
  gh.factory<_i83.HomeScreen>(
      () => _i83.HomeScreen(get<_i56.HomeStateManager>()));
  gh.factory<_i84.MyNotificationsScreen>(() =>
      _i84.MyNotificationsScreen(get<_i60.MyNotificationsStateManager>()));
  gh.factory<_i85.MyOrdersStateManager>(() => _i85.MyOrdersStateManager(
      get<_i62.OrdersService>(),
      get<_i30.AuthService>(),
      get<_i8.FireStoreHelper>()));
  gh.factory<_i86.OrderDetailsStateManager>(() => _i86.OrderDetailsStateManager(
      get<_i62.OrdersService>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i87.OrderLogsStateManager>(
      () => _i87.OrderLogsStateManager(get<_i62.OrdersService>()));
  gh.factory<_i88.OrderStatusStateManager>(() => _i88.OrderStatusStateManager(
      get<_i62.OrdersService>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i89.PersonalDataStateManager>(() => _i89.PersonalDataStateManager(
      get<_i77.AccountService>(), get<_i33.ImageUploadService>()));
  gh.factory<_i90.PrivateOrderStateManager>(() => _i90.PrivateOrderStateManager(
      get<_i68.ServicesService>(), get<_i30.AuthService>()));
  gh.factory<_i91.ProductDetailsStateManager>(
      () => _i91.ProductDetailsStateManager(get<_i64.ProductsService>()));
  gh.factory<_i92.SearchModule>(
      () => _i92.SearchModule(get<_i66.SearchScreen>()));
  gh.factory<_i93.SendItScreen>(
      () => _i93.SendItScreen(get<_i69.ServicesStateManager>()));
  gh.factory<_i94.SettingsModule>(() => _i94.SettingsModule(
      get<_i70.SettingsScreen>(), get<_i24.ChooseLocalScreen>()));
  gh.factory<_i95.StoreProductsScreen>(() => _i95.StoreProductsScreen(
      get<_i75.StoreProductsStateManager>(), get<_i30.AuthService>()));
  gh.factory<_i96.AccountScreen>(
      () => _i96.AccountScreen(get<_i78.AccountStateManager>()));
  gh.factory<_i97.ChatModule>(
      () => _i97.ChatModule(get<_i80.ChatPage>(), get<_i30.AuthService>()));
  gh.factory<_i98.ClientOrderScreen>(
      () => _i98.ClientOrderScreen(get<_i81.ClientOrderStateManager>()));
  gh.factory<_i99.FavouritScreen>(
      () => _i99.FavouritScreen(get<_i82.FavouriteStateManager>()));
  gh.factory<_i100.HomeModule>(() => _i100.HomeModule(get<_i83.HomeScreen>()));
  gh.factory<_i101.MyNotificationsModule>(
      () => _i101.MyNotificationsModule(get<_i84.MyNotificationsScreen>()));
  gh.factory<_i102.MyOrdersScreen>(
      () => _i102.MyOrdersScreen(get<_i85.MyOrdersStateManager>()));
  gh.factory<_i103.OrderDetailsScreen>(
      () => _i103.OrderDetailsScreen(get<_i86.OrderDetailsStateManager>()));
  gh.factory<_i104.OrderLogsScreen>(
      () => _i104.OrderLogsScreen(get<_i87.OrderLogsStateManager>()));
  gh.factory<_i105.OrderStatusScreen>(
      () => _i105.OrderStatusScreen(get<_i88.OrderStatusStateManager>()));
  gh.factory<_i106.OrdersModule>(() => _i106.OrdersModule(
      get<_i102.MyOrdersScreen>(),
      get<_i103.OrderDetailsScreen>(),
      get<_i105.OrderStatusScreen>(),
      get<_i98.ClientOrderScreen>(),
      get<_i104.OrderLogsScreen>()));
  gh.factory<_i107.PersonalDataScreen>(
      () => _i107.PersonalDataScreen(get<_i89.PersonalDataStateManager>()));
  gh.factory<_i108.PrivateOrderScreen>(
      () => _i108.PrivateOrderScreen(get<_i90.PrivateOrderStateManager>()));
  gh.factory<_i109.ProductDetailsScreen>(
      () => _i109.ProductDetailsScreen(get<_i91.ProductDetailsStateManager>()));
  gh.factory<_i110.ProductsModule>(() => _i110.ProductsModule(
      get<_i109.ProductDetailsScreen>(), get<_i5.CartScreen>()));
  gh.factory<_i111.ServicesModule>(() => _i111.ServicesModule(
      get<_i93.SendItScreen>(), get<_i108.PrivateOrderScreen>()));
  gh.factory<_i112.StoreModule>(() => _i112.StoreModule(
      get<_i72.StoreListScreen>(), get<_i95.StoreProductsScreen>()));
  gh.factory<_i113.AccountModule>(() => _i113.AccountModule(
      get<_i96.AccountScreen>(),
      get<_i107.PersonalDataScreen>(),
      get<_i3.AboutScreen>(),
      get<_i17.PrivecyPolicy>(),
      get<_i18.TermsOfUse>()));
  gh.factory<_i114.MyApp>(() => _i114.MyApp(
      get<_i22.AppThemeDataService>(),
      get<_i12.LocalizationService>(),
      get<_i53.FireNotificationService>(),
      get<_i10.LocalNotificationService>(),
      get<_i71.SplashModule>(),
      get<_i79.AuthorizationModule>(),
      get<_i97.ChatModule>(),
      get<_i94.SettingsModule>(),
      get<_i25.MainModule>(),
      get<_i106.OrdersModule>(),
      get<_i92.SearchModule>(),
      get<_i113.AccountModule>(),
      get<_i111.ServicesModule>(),
      get<_i112.StoreModule>(),
      get<_i101.MyNotificationsModule>(),
      get<_i110.ProductsModule>()));
  return get;
}
