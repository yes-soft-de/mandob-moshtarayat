// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i117;
import '../module_account/account_module.dart' as _i116;
import '../module_account/hive/favorite_store_category.dart' as _i7;
import '../module_account/manager/account_manager.dart' as _i79;
import '../module_account/repository/account_repository.dart' as _i50;
import '../module_account/service/account_service.dart' as _i80;
import '../module_account/state_manager/account_state_manager.dart' as _i81;
import '../module_account/state_manager/favorite_state_manager.dart' as _i85;
import '../module_account/state_manager/presonal_data_state_manager.dart'
    as _i92;
import '../module_account/ui/screen/about.dart' as _i3;
import '../module_account/ui/screen/account_screen.dart' as _i99;
import '../module_account/ui/screen/favourite_screen.dart' as _i102;
import '../module_account/ui/screen/presonal_data_screen.dart' as _i110;
import '../module_account/ui/screen/privecy_policy.dart' as _i16;
import '../module_account/ui/screen/terms_of_use.dart' as _i18;
import '../module_auth/authoriazation_module.dart' as _i82;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i29;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i23;
import '../module_auth/service/auth_service/auth_service.dart' as _i30;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i34;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i39;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i58;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i66;
import '../module_chat/chat_module.dart' as _i100;
import '../module_chat/manager/chat/chat_manager.dart' as _i51;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i31;
import '../module_chat/service/chat/char_service.dart' as _i52;
import '../module_chat/state_manager/chat_state_manager.dart' as _i53;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i83;
import '../module_home/home_module.dart' as _i103;
import '../module_home/manager/home_manager.dart' as _i55;
import '../module_home/repository/home_repository.dart' as _i32;
import '../module_home/service/home_service.dart' as _i56;
import '../module_home/state_manager/home_state_manager.dart' as _i57;
import '../module_home/ui/screen/home_screen.dart' as _i86;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i11;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i12;
import '../module_main/main_module.dart' as _i25;
import '../module_main/ui/screen/main_screen.dart' as _i14;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i59;
import '../module_my_notifications/my_notifications_module.dart' as _i104;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i35;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i60;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i61;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i87;
import '../module_network/http_client/http_client.dart' as _i21;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i15;
import '../module_notifications/repository/notification_repo.dart' as _i37;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i54;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i10;
import '../module_orders/manager/my_orders_manager.dart' as _i62;
import '../module_orders/orders_module.dart' as _i109;
import '../module_orders/repository/orders_repository.dart' as _i36;
import '../module_orders/service/orders_service.dart' as _i63;
import '../module_orders/state_manager/client_order_state_manager.dart' as _i84;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i88;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i89;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i90;
import '../module_orders/state_manager/order_status_state_manager.dart' as _i91;
import '../module_orders/ui/screen/client_order_screen.dart' as _i101;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i105;
import '../module_orders/ui/screen/order_details_screen.dart' as _i106;
import '../module_orders/ui/screen/order_logs_screen.dart' as _i107;
import '../module_orders/ui/screen/order_status_screen.dart' as _i108;
import '../module_our_services/manager/manager.dart' as _i70;
import '../module_our_services/repository/services_repository.dart' as _i44;
import '../module_our_services/service/services_service.dart' as _i71;
import '../module_our_services/services_module.dart' as _i114;
import '../module_our_services/state_manager/private_order_state_manager.dart'
    as _i93;
import '../module_our_services/state_manager/services_state_manager.dart'
    as _i72;
import '../module_our_services/ui/screen/private_order_screen.dart' as _i111;
import '../module_our_services/ui/screen/send_it_screen.dart' as _i96;
import '../module_products/manager/products_manager.dart' as _i64;
import '../module_products/products_module.dart' as _i113;
import '../module_products/repository/products_repository.dart' as _i38;
import '../module_products/service/products_service.dart' as _i65;
import '../module_products/state_manager/products_state_manager.dart' as _i94;
import '../module_products/ui/screen/cart_screen.dart' as _i5;
import '../module_products/ui/screen/products_details_screen.dart' as _i112;
import '../module_report/manager/report_manager.dart' as _i67;
import '../module_report/presistance/report_prefs_helper.dart' as _i17;
import '../module_report/repository/report_repository.dart' as _i40;
import '../module_report/service/report_service.dart' as _i68;
import '../module_search/manager/search_manager.dart' as _i41;
import '../module_search/repository/search_repository.dart' as _i26;
import '../module_search/search_module.dart' as _i95;
import '../module_search/service/search_service.dart' as _i42;
import '../module_search/state_manager/search_state_manager.dart' as _i43;
import '../module_search/ui/screen/search_screen.dart' as _i69;
import '../module_settings/settings_module.dart' as _i97;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i24;
import '../module_settings/ui/settings_page/settings_page.dart' as _i73;
import '../module_splash/splash_module.dart' as _i74;
import '../module_splash/ui/screen/splash_screen.dart' as _i45;
import '../module_stores/manager/store_list_manager.dart' as _i46;
import '../module_stores/manager/store_products.dart' as _i76;
import '../module_stores/repository/store_list_repository.dart' as _i27;
import '../module_stores/repository/store_products_repository.dart' as _i49;
import '../module_stores/service/store_list_service.dart' as _i47;
import '../module_stores/service/store_products_service.dart' as _i77;
import '../module_stores/state_manager/store_list_state_manager.dart' as _i48;
import '../module_stores/state_manager/store_products_state_manager.dart'
    as _i78;
import '../module_stores/store_module.dart' as _i115;
import '../module_stores/ui/screen/store_list_screen.dart' as _i75;
import '../module_stores/ui/screen/store_products_screen.dart' as _i98;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i19;
import '../module_theme/service/theme_service/theme_service.dart' as _i22;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i28;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i20;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i33;
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
  gh.factory<_i17.ReportPrefsHelper>(() => _i17.ReportPrefsHelper());
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
  gh.factory<_i40.ReportRepository>(() => _i40.ReportRepository(
      get<_i21.ApiClient>(),
      get<_i30.AuthService>(),
      get<_i17.ReportPrefsHelper>()));
  gh.factory<_i41.SearchManager>(
      () => _i41.SearchManager(get<_i26.SearchRepository>()));
  gh.factory<_i42.SearchService>(
      () => _i42.SearchService(get<_i41.SearchManager>()));
  gh.factory<_i43.SearchStateManager>(
      () => _i43.SearchStateManager(get<_i42.SearchService>()));
  gh.factory<_i44.ServicesRepository>(() =>
      _i44.ServicesRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i45.SplashScreen>(() => _i45.SplashScreen(
      get<_i30.AuthService>(), get<_i12.LocalizationService>()));
  gh.factory<_i46.StoreListManager>(
      () => _i46.StoreListManager(get<_i27.StoreListRepository>()));
  gh.factory<_i47.StoreListService>(
      () => _i47.StoreListService(get<_i46.StoreListManager>()));
  gh.factory<_i48.StoreListStateManager>(
      () => _i48.StoreListStateManager(get<_i47.StoreListService>()));
  gh.factory<_i49.StoreProductsRepository>(() => _i49.StoreProductsRepository(
      get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i50.AccountRepository>(() =>
      _i50.AccountRepository(get<_i30.AuthService>(), get<_i21.ApiClient>()));
  gh.factory<_i51.ChatManager>(
      () => _i51.ChatManager(get<_i31.ChatRepository>()));
  gh.factory<_i52.ChatService>(() => _i52.ChatService(get<_i51.ChatManager>()));
  gh.factory<_i53.ChatStateManager>(
      () => _i53.ChatStateManager(get<_i52.ChatService>()));
  gh.factory<_i54.FireNotificationService>(() => _i54.FireNotificationService(
      get<_i15.NotificationsPrefHelper>(), get<_i37.NotificationRepo>()));
  gh.factory<_i55.HomeManager>(
      () => _i55.HomeManager(get<_i32.HomeRepository>()));
  gh.factory<_i56.HomeService>(() => _i56.HomeService(get<_i55.HomeManager>()));
  gh.factory<_i57.HomeStateManager>(
      () => _i57.HomeStateManager(get<_i56.HomeService>()));
  gh.factory<_i58.LoginScreen>(
      () => _i58.LoginScreen(get<_i34.LoginStateManager>()));
  gh.factory<_i59.MyNotificationsManager>(
      () => _i59.MyNotificationsManager(get<_i35.MyNotificationsRepository>()));
  gh.factory<_i60.MyNotificationsService>(
      () => _i60.MyNotificationsService(get<_i59.MyNotificationsManager>()));
  gh.factory<_i61.MyNotificationsStateManager>(() =>
      _i61.MyNotificationsStateManager(
          get<_i60.MyNotificationsService>(), get<_i30.AuthService>()));
  gh.factory<_i62.MyOrdersManager>(
      () => _i62.MyOrdersManager(get<_i36.MyOrdersRepository>()));
  gh.factory<_i63.OrdersService>(() => _i63.OrdersService(
      get<_i62.MyOrdersManager>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i64.ProductsManager>(
      () => _i64.ProductsManager(get<_i38.ProductsRepository>()));
  gh.factory<_i65.ProductsService>(
      () => _i65.ProductsService(get<_i64.ProductsManager>()));
  gh.factory<_i66.RegisterScreen>(
      () => _i66.RegisterScreen(get<_i39.RegisterStateManager>()));
  gh.factory<_i67.ReportManager>(
      () => _i67.ReportManager(get<_i40.ReportRepository>()));
  gh.factory<_i68.ReportService>(
      () => _i68.ReportService(get<_i67.ReportManager>()));
  gh.factory<_i69.SearchScreen>(
      () => _i69.SearchScreen(get<_i43.SearchStateManager>()));
  gh.factory<_i70.ServicesManager>(
      () => _i70.ServicesManager(get<_i44.ServicesRepository>()));
  gh.factory<_i71.ServicesService>(() => _i71.ServicesService(
      get<_i70.ServicesManager>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i72.ServicesStateManager>(() => _i72.ServicesStateManager(
      get<_i71.ServicesService>(), get<_i30.AuthService>()));
  gh.factory<_i73.SettingsScreen>(() => _i73.SettingsScreen(
      get<_i30.AuthService>(),
      get<_i12.LocalizationService>(),
      get<_i22.AppThemeDataService>(),
      get<_i54.FireNotificationService>()));
  gh.factory<_i74.SplashModule>(
      () => _i74.SplashModule(get<_i45.SplashScreen>()));
  gh.factory<_i75.StoreListScreen>(
      () => _i75.StoreListScreen(get<_i48.StoreListStateManager>()));
  gh.factory<_i76.StoreProductsManager>(
      () => _i76.StoreProductsManager(get<_i49.StoreProductsRepository>()));
  gh.factory<_i77.StoreProductsService>(
      () => _i77.StoreProductsService(get<_i76.StoreProductsManager>()));
  gh.factory<_i78.StoreProductsStateManager>(
      () => _i78.StoreProductsStateManager(get<_i77.StoreProductsService>()));
  gh.factory<_i79.AccountManager>(
      () => _i79.AccountManager(get<_i50.AccountRepository>()));
  gh.factory<_i80.AccountService>(
      () => _i80.AccountService(get<_i79.AccountManager>()));
  gh.factory<_i81.AccountStateManager>(() => _i81.AccountStateManager(
      get<_i80.AccountService>(), get<_i30.AuthService>()));
  gh.factory<_i82.AuthorizationModule>(() => _i82.AuthorizationModule(
      get<_i58.LoginScreen>(), get<_i66.RegisterScreen>()));
  gh.factory<_i83.ChatPage>(() => _i83.ChatPage(
      get<_i53.ChatStateManager>(),
      get<_i33.ImageUploadService>(),
      get<_i30.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i84.ClientOrderStateManager>(() => _i84.ClientOrderStateManager(
      get<_i63.OrdersService>(), get<_i30.AuthService>()));
  gh.factory<_i85.FavouriteStateManager>(() => _i85.FavouriteStateManager(
      get<_i80.AccountService>(), get<_i56.HomeService>()));
  gh.factory<_i86.HomeScreen>(
      () => _i86.HomeScreen(get<_i57.HomeStateManager>()));
  gh.factory<_i87.MyNotificationsScreen>(() =>
      _i87.MyNotificationsScreen(get<_i61.MyNotificationsStateManager>()));
  gh.factory<_i88.MyOrdersStateManager>(() => _i88.MyOrdersStateManager(
      get<_i63.OrdersService>(),
      get<_i30.AuthService>(),
      get<_i8.FireStoreHelper>()));
  gh.factory<_i89.OrderDetailsStateManager>(() => _i89.OrderDetailsStateManager(
      get<_i63.OrdersService>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i90.OrderLogsStateManager>(
      () => _i90.OrderLogsStateManager(get<_i63.OrdersService>()));
  gh.factory<_i91.OrderStatusStateManager>(() => _i91.OrderStatusStateManager(
      get<_i63.OrdersService>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i92.PersonalDataStateManager>(() => _i92.PersonalDataStateManager(
      get<_i80.AccountService>(), get<_i33.ImageUploadService>()));
  gh.factory<_i93.PrivateOrderStateManager>(() => _i93.PrivateOrderStateManager(
      get<_i71.ServicesService>(), get<_i30.AuthService>()));
  gh.factory<_i94.ProductDetailsStateManager>(
      () => _i94.ProductDetailsStateManager(get<_i65.ProductsService>()));
  gh.factory<_i95.SearchModule>(
      () => _i95.SearchModule(get<_i69.SearchScreen>()));
  gh.factory<_i96.SendItScreen>(
      () => _i96.SendItScreen(get<_i72.ServicesStateManager>()));
  gh.factory<_i97.SettingsModule>(() => _i97.SettingsModule(
      get<_i73.SettingsScreen>(), get<_i24.ChooseLocalScreen>()));
  gh.factory<_i98.StoreProductsScreen>(() => _i98.StoreProductsScreen(
      get<_i78.StoreProductsStateManager>(), get<_i30.AuthService>()));
  gh.factory<_i99.AccountScreen>(
      () => _i99.AccountScreen(get<_i81.AccountStateManager>()));
  gh.factory<_i100.ChatModule>(
      () => _i100.ChatModule(get<_i83.ChatPage>(), get<_i30.AuthService>()));
  gh.factory<_i101.ClientOrderScreen>(
      () => _i101.ClientOrderScreen(get<_i84.ClientOrderStateManager>()));
  gh.factory<_i102.FavouritScreen>(
      () => _i102.FavouritScreen(get<_i85.FavouriteStateManager>()));
  gh.factory<_i103.HomeModule>(() => _i103.HomeModule(get<_i86.HomeScreen>()));
  gh.factory<_i104.MyNotificationsModule>(
      () => _i104.MyNotificationsModule(get<_i87.MyNotificationsScreen>()));
  gh.factory<_i105.MyOrdersScreen>(
      () => _i105.MyOrdersScreen(get<_i88.MyOrdersStateManager>()));
  gh.factory<_i106.OrderDetailsScreen>(
      () => _i106.OrderDetailsScreen(get<_i89.OrderDetailsStateManager>()));
  gh.factory<_i107.OrderLogsScreen>(
      () => _i107.OrderLogsScreen(get<_i90.OrderLogsStateManager>()));
  gh.factory<_i108.OrderStatusScreen>(
      () => _i108.OrderStatusScreen(get<_i91.OrderStatusStateManager>()));
  gh.factory<_i109.OrdersModule>(() => _i109.OrdersModule(
      get<_i105.MyOrdersScreen>(),
      get<_i106.OrderDetailsScreen>(),
      get<_i108.OrderStatusScreen>(),
      get<_i101.ClientOrderScreen>(),
      get<_i107.OrderLogsScreen>()));
  gh.factory<_i110.PersonalDataScreen>(
      () => _i110.PersonalDataScreen(get<_i92.PersonalDataStateManager>()));
  gh.factory<_i111.PrivateOrderScreen>(
      () => _i111.PrivateOrderScreen(get<_i93.PrivateOrderStateManager>()));
  gh.factory<_i112.ProductDetailsScreen>(
      () => _i112.ProductDetailsScreen(get<_i94.ProductDetailsStateManager>()));
  gh.factory<_i113.ProductsModule>(() => _i113.ProductsModule(
      get<_i112.ProductDetailsScreen>(), get<_i5.CartScreen>()));
  gh.factory<_i114.ServicesModule>(() => _i114.ServicesModule(
      get<_i96.SendItScreen>(), get<_i111.PrivateOrderScreen>()));
  gh.factory<_i115.StoreModule>(() => _i115.StoreModule(
      get<_i75.StoreListScreen>(), get<_i98.StoreProductsScreen>()));
  gh.factory<_i116.AccountModule>(() => _i116.AccountModule(
      get<_i99.AccountScreen>(),
      get<_i110.PersonalDataScreen>(),
      get<_i3.AboutScreen>(),
      get<_i16.PrivecyPolicy>(),
      get<_i18.TermsOfUse>()));
  gh.factory<_i117.MyApp>(() => _i117.MyApp(
      get<_i22.AppThemeDataService>(),
      get<_i12.LocalizationService>(),
      get<_i54.FireNotificationService>(),
      get<_i10.LocalNotificationService>(),
      get<_i74.SplashModule>(),
      get<_i82.AuthorizationModule>(),
      get<_i100.ChatModule>(),
      get<_i97.SettingsModule>(),
      get<_i25.MainModule>(),
      get<_i109.OrdersModule>(),
      get<_i95.SearchModule>(),
      get<_i116.AccountModule>(),
      get<_i114.ServicesModule>(),
      get<_i115.StoreModule>(),
      get<_i104.MyNotificationsModule>(),
      get<_i113.ProductsModule>()));
  return get;
}
