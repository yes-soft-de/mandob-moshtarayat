// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i119;
import '../module_account/account_module.dart' as _i118;
import '../module_account/hive/favorite_store_category.dart' as _i7;
import '../module_account/manager/account_manager.dart' as _i81;
import '../module_account/repository/account_repository.dart' as _i51;
import '../module_account/service/account_service.dart' as _i82;
import '../module_account/state_manager/account_state_manager.dart' as _i83;
import '../module_account/state_manager/favorite_state_manager.dart' as _i87;
import '../module_account/state_manager/presonal_data_state_manager.dart'
    as _i94;
import '../module_account/ui/screen/about.dart' as _i3;
import '../module_account/ui/screen/account_screen.dart' as _i101;
import '../module_account/ui/screen/favourite_screen.dart' as _i104;
import '../module_account/ui/screen/presonal_data_screen.dart' as _i112;
import '../module_account/ui/screen/privecy_policy.dart' as _i16;
import '../module_account/ui/screen/terms_of_use.dart' as _i18;
import '../module_auth/authoriazation_module.dart' as _i84;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i29;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i23;
import '../module_auth/service/auth_service/auth_service.dart' as _i30;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i32;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i35;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i40;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i56;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i60;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i68;
import '../module_chat/chat_module.dart' as _i102;
import '../module_chat/manager/chat/chat_manager.dart' as _i52;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i31;
import '../module_chat/service/chat/char_service.dart' as _i53;
import '../module_chat/state_manager/chat_state_manager.dart' as _i54;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i85;
import '../module_home/home_module.dart' as _i105;
import '../module_home/manager/home_manager.dart' as _i57;
import '../module_home/repository/home_repository.dart' as _i33;
import '../module_home/service/home_service.dart' as _i58;
import '../module_home/state_manager/home_state_manager.dart' as _i59;
import '../module_home/ui/screen/home_screen.dart' as _i88;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i11;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i12;
import '../module_main/main_module.dart' as _i25;
import '../module_main/ui/screen/main_screen.dart' as _i14;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i61;
import '../module_my_notifications/my_notifications_module.dart' as _i106;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i36;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i62;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i63;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i89;
import '../module_network/http_client/http_client.dart' as _i21;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i15;
import '../module_notifications/repository/notification_repo.dart' as _i38;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i55;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i10;
import '../module_orders/manager/my_orders_manager.dart' as _i64;
import '../module_orders/orders_module.dart' as _i111;
import '../module_orders/repository/orders_repository.dart' as _i37;
import '../module_orders/service/orders_service.dart' as _i65;
import '../module_orders/state_manager/client_order_state_manager.dart' as _i86;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i90;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i91;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i92;
import '../module_orders/state_manager/order_status_state_manager.dart' as _i93;
import '../module_orders/ui/screen/client_order_screen.dart' as _i103;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i107;
import '../module_orders/ui/screen/order_details_screen.dart' as _i108;
import '../module_orders/ui/screen/order_logs_screen.dart' as _i109;
import '../module_orders/ui/screen/order_status_screen.dart' as _i110;
import '../module_our_services/manager/manager.dart' as _i72;
import '../module_our_services/repository/services_repository.dart' as _i45;
import '../module_our_services/service/services_service.dart' as _i73;
import '../module_our_services/services_module.dart' as _i116;
import '../module_our_services/state_manager/private_order_state_manager.dart'
    as _i95;
import '../module_our_services/state_manager/services_state_manager.dart'
    as _i74;
import '../module_our_services/ui/screen/private_order_screen.dart' as _i113;
import '../module_our_services/ui/screen/send_it_screen.dart' as _i98;
import '../module_products/manager/products_manager.dart' as _i66;
import '../module_products/products_module.dart' as _i115;
import '../module_products/repository/products_repository.dart' as _i39;
import '../module_products/service/products_service.dart' as _i67;
import '../module_products/state_manager/products_state_manager.dart' as _i96;
import '../module_products/ui/screen/cart_screen.dart' as _i5;
import '../module_products/ui/screen/products_details_screen.dart' as _i114;
import '../module_report/manager/report_manager.dart' as _i69;
import '../module_report/presistance/report_prefs_helper.dart' as _i17;
import '../module_report/repository/report_repository.dart' as _i41;
import '../module_report/service/report_service.dart' as _i70;
import '../module_search/manager/search_manager.dart' as _i42;
import '../module_search/repository/search_repository.dart' as _i26;
import '../module_search/search_module.dart' as _i97;
import '../module_search/service/search_service.dart' as _i43;
import '../module_search/state_manager/search_state_manager.dart' as _i44;
import '../module_search/ui/screen/search_screen.dart' as _i71;
import '../module_settings/settings_module.dart' as _i99;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i24;
import '../module_settings/ui/settings_page/settings_page.dart' as _i75;
import '../module_splash/splash_module.dart' as _i76;
import '../module_splash/ui/screen/splash_screen.dart' as _i46;
import '../module_stores/manager/store_list_manager.dart' as _i47;
import '../module_stores/manager/store_products.dart' as _i78;
import '../module_stores/repository/store_list_repository.dart' as _i27;
import '../module_stores/repository/store_products_repository.dart' as _i50;
import '../module_stores/service/store_list_service.dart' as _i48;
import '../module_stores/service/store_products_service.dart' as _i79;
import '../module_stores/state_manager/store_list_state_manager.dart' as _i49;
import '../module_stores/state_manager/store_products_state_manager.dart'
    as _i80;
import '../module_stores/store_module.dart' as _i117;
import '../module_stores/ui/screen/store_list_screen.dart' as _i77;
import '../module_stores/ui/screen/store_products_screen.dart' as _i100;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i19;
import '../module_theme/service/theme_service/theme_service.dart' as _i22;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i28;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i20;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i34;
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
  gh.factory<_i32.ForgotPassStateManager>(
      () => _i32.ForgotPassStateManager(get<_i30.AuthService>()));
  gh.factory<_i33.HomeRepository>(() =>
      _i33.HomeRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i34.ImageUploadService>(
      () => _i34.ImageUploadService(get<_i28.UploadManager>()));
  gh.factory<_i35.LoginStateManager>(
      () => _i35.LoginStateManager(get<_i30.AuthService>()));
  gh.factory<_i36.MyNotificationsRepository>(() =>
      _i36.MyNotificationsRepository(
          get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i37.MyOrdersRepository>(() =>
      _i37.MyOrdersRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i38.NotificationRepo>(() =>
      _i38.NotificationRepo(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i39.ProductsRepository>(() =>
      _i39.ProductsRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i40.RegisterStateManager>(
      () => _i40.RegisterStateManager(get<_i30.AuthService>()));
  gh.factory<_i41.ReportRepository>(() => _i41.ReportRepository(
      get<_i21.ApiClient>(),
      get<_i30.AuthService>(),
      get<_i17.ReportPrefsHelper>()));
  gh.factory<_i42.SearchManager>(
      () => _i42.SearchManager(get<_i26.SearchRepository>()));
  gh.factory<_i43.SearchService>(
      () => _i43.SearchService(get<_i42.SearchManager>()));
  gh.factory<_i44.SearchStateManager>(
      () => _i44.SearchStateManager(get<_i43.SearchService>()));
  gh.factory<_i45.ServicesRepository>(() =>
      _i45.ServicesRepository(get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i46.SplashScreen>(() => _i46.SplashScreen(
      get<_i30.AuthService>(), get<_i12.LocalizationService>()));
  gh.factory<_i47.StoreListManager>(
      () => _i47.StoreListManager(get<_i27.StoreListRepository>()));
  gh.factory<_i48.StoreListService>(
      () => _i48.StoreListService(get<_i47.StoreListManager>()));
  gh.factory<_i49.StoreListStateManager>(
      () => _i49.StoreListStateManager(get<_i48.StoreListService>()));
  gh.factory<_i50.StoreProductsRepository>(() => _i50.StoreProductsRepository(
      get<_i21.ApiClient>(), get<_i30.AuthService>()));
  gh.factory<_i51.AccountRepository>(() =>
      _i51.AccountRepository(get<_i30.AuthService>(), get<_i21.ApiClient>()));
  gh.factory<_i52.ChatManager>(
      () => _i52.ChatManager(get<_i31.ChatRepository>()));
  gh.factory<_i53.ChatService>(() => _i53.ChatService(get<_i52.ChatManager>()));
  gh.factory<_i54.ChatStateManager>(
      () => _i54.ChatStateManager(get<_i53.ChatService>()));
  gh.factory<_i55.FireNotificationService>(() => _i55.FireNotificationService(
      get<_i15.NotificationsPrefHelper>(), get<_i38.NotificationRepo>()));
  gh.factory<_i56.ForgotPassScreen>(
      () => _i56.ForgotPassScreen(get<_i32.ForgotPassStateManager>()));
  gh.factory<_i57.HomeManager>(
      () => _i57.HomeManager(get<_i33.HomeRepository>()));
  gh.factory<_i58.HomeService>(() => _i58.HomeService(get<_i57.HomeManager>()));
  gh.factory<_i59.HomeStateManager>(
      () => _i59.HomeStateManager(get<_i58.HomeService>()));
  gh.factory<_i60.LoginScreen>(
      () => _i60.LoginScreen(get<_i35.LoginStateManager>()));
  gh.factory<_i61.MyNotificationsManager>(
      () => _i61.MyNotificationsManager(get<_i36.MyNotificationsRepository>()));
  gh.factory<_i62.MyNotificationsService>(
      () => _i62.MyNotificationsService(get<_i61.MyNotificationsManager>()));
  gh.factory<_i63.MyNotificationsStateManager>(() =>
      _i63.MyNotificationsStateManager(
          get<_i62.MyNotificationsService>(), get<_i30.AuthService>()));
  gh.factory<_i64.MyOrdersManager>(
      () => _i64.MyOrdersManager(get<_i37.MyOrdersRepository>()));
  gh.factory<_i65.OrdersService>(() => _i65.OrdersService(
      get<_i64.MyOrdersManager>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i66.ProductsManager>(
      () => _i66.ProductsManager(get<_i39.ProductsRepository>()));
  gh.factory<_i67.ProductsService>(
      () => _i67.ProductsService(get<_i66.ProductsManager>()));
  gh.factory<_i68.RegisterScreen>(
      () => _i68.RegisterScreen(get<_i40.RegisterStateManager>()));
  gh.factory<_i69.ReportManager>(
      () => _i69.ReportManager(get<_i41.ReportRepository>()));
  gh.factory<_i70.ReportService>(
      () => _i70.ReportService(get<_i69.ReportManager>()));
  gh.factory<_i71.SearchScreen>(
      () => _i71.SearchScreen(get<_i44.SearchStateManager>()));
  gh.factory<_i72.ServicesManager>(
      () => _i72.ServicesManager(get<_i45.ServicesRepository>()));
  gh.factory<_i73.ServicesService>(() => _i73.ServicesService(
      get<_i72.ServicesManager>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i74.ServicesStateManager>(() => _i74.ServicesStateManager(
      get<_i73.ServicesService>(), get<_i30.AuthService>()));
  gh.factory<_i75.SettingsScreen>(() => _i75.SettingsScreen(
      get<_i30.AuthService>(),
      get<_i12.LocalizationService>(),
      get<_i22.AppThemeDataService>(),
      get<_i55.FireNotificationService>()));
  gh.factory<_i76.SplashModule>(
      () => _i76.SplashModule(get<_i46.SplashScreen>()));
  gh.factory<_i77.StoreListScreen>(
      () => _i77.StoreListScreen(get<_i49.StoreListStateManager>()));
  gh.factory<_i78.StoreProductsManager>(
      () => _i78.StoreProductsManager(get<_i50.StoreProductsRepository>()));
  gh.factory<_i79.StoreProductsService>(
      () => _i79.StoreProductsService(get<_i78.StoreProductsManager>()));
  gh.factory<_i80.StoreProductsStateManager>(
      () => _i80.StoreProductsStateManager(get<_i79.StoreProductsService>()));
  gh.factory<_i81.AccountManager>(
      () => _i81.AccountManager(get<_i51.AccountRepository>()));
  gh.factory<_i82.AccountService>(
      () => _i82.AccountService(get<_i81.AccountManager>()));
  gh.factory<_i83.AccountStateManager>(() => _i83.AccountStateManager(
      get<_i82.AccountService>(), get<_i30.AuthService>()));
  gh.factory<_i84.AuthorizationModule>(() => _i84.AuthorizationModule(
      get<_i60.LoginScreen>(),
      get<_i68.RegisterScreen>(),
      get<_i56.ForgotPassScreen>()));
  gh.factory<_i85.ChatPage>(() => _i85.ChatPage(
      get<_i54.ChatStateManager>(),
      get<_i34.ImageUploadService>(),
      get<_i30.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i86.ClientOrderStateManager>(() => _i86.ClientOrderStateManager(
      get<_i65.OrdersService>(), get<_i30.AuthService>()));
  gh.factory<_i87.FavouriteStateManager>(() => _i87.FavouriteStateManager(
      get<_i82.AccountService>(), get<_i58.HomeService>()));
  gh.factory<_i88.HomeScreen>(
      () => _i88.HomeScreen(get<_i59.HomeStateManager>()));
  gh.factory<_i89.MyNotificationsScreen>(() =>
      _i89.MyNotificationsScreen(get<_i63.MyNotificationsStateManager>()));
  gh.factory<_i90.MyOrdersStateManager>(() => _i90.MyOrdersStateManager(
      get<_i65.OrdersService>(),
      get<_i30.AuthService>(),
      get<_i8.FireStoreHelper>()));
  gh.factory<_i91.OrderDetailsStateManager>(() => _i91.OrderDetailsStateManager(
      get<_i65.OrdersService>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i92.OrderLogsStateManager>(
      () => _i92.OrderLogsStateManager(get<_i65.OrdersService>()));
  gh.factory<_i93.OrderStatusStateManager>(() => _i93.OrderStatusStateManager(
      get<_i65.OrdersService>(), get<_i8.FireStoreHelper>()));
  gh.factory<_i94.PersonalDataStateManager>(() => _i94.PersonalDataStateManager(
      get<_i82.AccountService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i95.PrivateOrderStateManager>(() => _i95.PrivateOrderStateManager(
      get<_i73.ServicesService>(), get<_i30.AuthService>()));
  gh.factory<_i96.ProductDetailsStateManager>(
      () => _i96.ProductDetailsStateManager(get<_i67.ProductsService>()));
  gh.factory<_i97.SearchModule>(
      () => _i97.SearchModule(get<_i71.SearchScreen>()));
  gh.factory<_i98.SendItScreen>(
      () => _i98.SendItScreen(get<_i74.ServicesStateManager>()));
  gh.factory<_i99.SettingsModule>(() => _i99.SettingsModule(
      get<_i75.SettingsScreen>(), get<_i24.ChooseLocalScreen>()));
  gh.factory<_i100.StoreProductsScreen>(() => _i100.StoreProductsScreen(
      get<_i80.StoreProductsStateManager>(), get<_i30.AuthService>()));
  gh.factory<_i101.AccountScreen>(
      () => _i101.AccountScreen(get<_i83.AccountStateManager>()));
  gh.factory<_i102.ChatModule>(
      () => _i102.ChatModule(get<_i85.ChatPage>(), get<_i30.AuthService>()));
  gh.factory<_i103.ClientOrderScreen>(
      () => _i103.ClientOrderScreen(get<_i86.ClientOrderStateManager>()));
  gh.factory<_i104.FavouritScreen>(
      () => _i104.FavouritScreen(get<_i87.FavouriteStateManager>()));
  gh.factory<_i105.HomeModule>(() => _i105.HomeModule(get<_i88.HomeScreen>()));
  gh.factory<_i106.MyNotificationsModule>(
      () => _i106.MyNotificationsModule(get<_i89.MyNotificationsScreen>()));
  gh.factory<_i107.MyOrdersScreen>(
      () => _i107.MyOrdersScreen(get<_i90.MyOrdersStateManager>()));
  gh.factory<_i108.OrderDetailsScreen>(
      () => _i108.OrderDetailsScreen(get<_i91.OrderDetailsStateManager>()));
  gh.factory<_i109.OrderLogsScreen>(
      () => _i109.OrderLogsScreen(get<_i92.OrderLogsStateManager>()));
  gh.factory<_i110.OrderStatusScreen>(
      () => _i110.OrderStatusScreen(get<_i93.OrderStatusStateManager>()));
  gh.factory<_i111.OrdersModule>(() => _i111.OrdersModule(
      get<_i107.MyOrdersScreen>(),
      get<_i108.OrderDetailsScreen>(),
      get<_i110.OrderStatusScreen>(),
      get<_i103.ClientOrderScreen>(),
      get<_i109.OrderLogsScreen>()));
  gh.factory<_i112.PersonalDataScreen>(
      () => _i112.PersonalDataScreen(get<_i94.PersonalDataStateManager>()));
  gh.factory<_i113.PrivateOrderScreen>(
      () => _i113.PrivateOrderScreen(get<_i95.PrivateOrderStateManager>()));
  gh.factory<_i114.ProductDetailsScreen>(
      () => _i114.ProductDetailsScreen(get<_i96.ProductDetailsStateManager>()));
  gh.factory<_i115.ProductsModule>(() => _i115.ProductsModule(
      get<_i114.ProductDetailsScreen>(), get<_i5.CartScreen>()));
  gh.factory<_i116.ServicesModule>(() => _i116.ServicesModule(
      get<_i98.SendItScreen>(), get<_i113.PrivateOrderScreen>()));
  gh.factory<_i117.StoreModule>(() => _i117.StoreModule(
      get<_i77.StoreListScreen>(), get<_i100.StoreProductsScreen>()));
  gh.factory<_i118.AccountModule>(() => _i118.AccountModule(
      get<_i101.AccountScreen>(),
      get<_i112.PersonalDataScreen>(),
      get<_i3.AboutScreen>(),
      get<_i16.PrivecyPolicy>(),
      get<_i18.TermsOfUse>()));
  gh.factory<_i119.MyApp>(() => _i119.MyApp(
      get<_i22.AppThemeDataService>(),
      get<_i12.LocalizationService>(),
      get<_i55.FireNotificationService>(),
      get<_i10.LocalNotificationService>(),
      get<_i76.SplashModule>(),
      get<_i84.AuthorizationModule>(),
      get<_i102.ChatModule>(),
      get<_i99.SettingsModule>(),
      get<_i25.MainModule>(),
      get<_i111.OrdersModule>(),
      get<_i97.SearchModule>(),
      get<_i118.AccountModule>(),
      get<_i116.ServicesModule>(),
      get<_i117.StoreModule>(),
      get<_i106.MyNotificationsModule>(),
      get<_i115.ProductsModule>()));
  return get;
}
