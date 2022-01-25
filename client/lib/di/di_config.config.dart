// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i120;
import '../module_account/account_module.dart' as _i119;
import '../module_account/hive/favorite_store_category.dart' as _i8;
import '../module_account/manager/account_manager.dart' as _i82;
import '../module_account/repository/account_repository.dart' as _i52;
import '../module_account/service/account_service.dart' as _i83;
import '../module_account/state_manager/account_state_manager.dart' as _i84;
import '../module_account/state_manager/favorite_state_manager.dart' as _i88;
import '../module_account/state_manager/presonal_data_state_manager.dart'
    as _i95;
import '../module_account/ui/screen/about.dart' as _i3;
import '../module_account/ui/screen/account_screen.dart' as _i102;
import '../module_account/ui/screen/favourite_screen.dart' as _i105;
import '../module_account/ui/screen/presonal_data_screen.dart' as _i113;
import '../module_account/ui/screen/privecy_policy.dart' as _i17;
import '../module_account/ui/screen/terms_of_use.dart' as _i19;
import '../module_auth/authoriazation_module.dart' as _i85;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i30;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i24;
import '../module_auth/service/auth_service/auth_service.dart' as _i31;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i33;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i36;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i41;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i57;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i61;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i69;
import '../module_chat/chat_module.dart' as _i103;
import '../module_chat/manager/chat/chat_manager.dart' as _i53;
import '../module_chat/presistance/chat_hive_helper.dart' as _i7;
import '../module_chat/repository/chat/chat_repository.dart' as _i32;
import '../module_chat/service/chat/char_service.dart' as _i54;
import '../module_chat/state_manager/chat_state_manager.dart' as _i55;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i86;
import '../module_home/home_module.dart' as _i106;
import '../module_home/manager/home_manager.dart' as _i58;
import '../module_home/repository/home_repository.dart' as _i34;
import '../module_home/service/home_service.dart' as _i59;
import '../module_home/state_manager/home_state_manager.dart' as _i60;
import '../module_home/ui/screen/home_screen.dart' as _i89;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i12;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i13;
import '../module_main/main_module.dart' as _i26;
import '../module_main/ui/screen/main_screen.dart' as _i15;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i62;
import '../module_my_notifications/my_notifications_module.dart' as _i107;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i37;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i63;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i64;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i90;
import '../module_network/http_client/http_client.dart' as _i22;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i16;
import '../module_notifications/repository/notification_repo.dart' as _i39;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i56;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i11;
import '../module_orders/manager/my_orders_manager.dart' as _i65;
import '../module_orders/orders_module.dart' as _i112;
import '../module_orders/repository/orders_repository.dart' as _i38;
import '../module_orders/service/orders_service.dart' as _i66;
import '../module_orders/state_manager/client_order_state_manager.dart' as _i87;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i91;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i92;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i93;
import '../module_orders/state_manager/order_status_state_manager.dart' as _i94;
import '../module_orders/ui/screen/client_order_screen.dart' as _i104;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i108;
import '../module_orders/ui/screen/order_details_screen.dart' as _i109;
import '../module_orders/ui/screen/order_logs_screen.dart' as _i110;
import '../module_orders/ui/screen/order_status_screen.dart' as _i111;
import '../module_our_services/manager/manager.dart' as _i73;
import '../module_our_services/repository/services_repository.dart' as _i46;
import '../module_our_services/service/services_service.dart' as _i74;
import '../module_our_services/services_module.dart' as _i117;
import '../module_our_services/state_manager/private_order_state_manager.dart'
    as _i96;
import '../module_our_services/state_manager/services_state_manager.dart'
    as _i75;
import '../module_our_services/ui/screen/private_order_screen.dart' as _i114;
import '../module_our_services/ui/screen/send_it_screen.dart' as _i99;
import '../module_products/manager/products_manager.dart' as _i67;
import '../module_products/products_module.dart' as _i116;
import '../module_products/repository/products_repository.dart' as _i40;
import '../module_products/service/products_service.dart' as _i68;
import '../module_products/state_manager/products_state_manager.dart' as _i97;
import '../module_products/ui/screen/cart_screen.dart' as _i6;
import '../module_products/ui/screen/products_details_screen.dart' as _i115;
import '../module_report/manager/report_manager.dart' as _i70;
import '../module_report/presistance/report_prefs_helper.dart' as _i18;
import '../module_report/repository/report_repository.dart' as _i42;
import '../module_report/service/report_service.dart' as _i71;
import '../module_search/manager/search_manager.dart' as _i43;
import '../module_search/repository/search_repository.dart' as _i27;
import '../module_search/search_module.dart' as _i98;
import '../module_search/service/search_service.dart' as _i44;
import '../module_search/state_manager/search_state_manager.dart' as _i45;
import '../module_search/ui/screen/search_screen.dart' as _i72;
import '../module_settings/settings_module.dart' as _i100;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i25;
import '../module_settings/ui/settings_page/settings_page.dart' as _i76;
import '../module_splash/splash_module.dart' as _i77;
import '../module_splash/ui/screen/splash_screen.dart' as _i47;
import '../module_stores/manager/store_list_manager.dart' as _i48;
import '../module_stores/manager/store_products.dart' as _i79;
import '../module_stores/presistance/cart_hive_box_helper.dart' as _i5;
import '../module_stores/repository/store_list_repository.dart' as _i28;
import '../module_stores/repository/store_products_repository.dart' as _i51;
import '../module_stores/service/store_list_service.dart' as _i49;
import '../module_stores/service/store_products_service.dart' as _i80;
import '../module_stores/state_manager/store_list_state_manager.dart' as _i50;
import '../module_stores/state_manager/store_products_state_manager.dart'
    as _i81;
import '../module_stores/store_module.dart' as _i118;
import '../module_stores/ui/screen/store_list_screen.dart' as _i78;
import '../module_stores/ui/screen/store_products_screen.dart' as _i101;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i20;
import '../module_theme/service/theme_service/theme_service.dart' as _i23;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i29;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i21;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i35;
import '../utils/global/global_state_manager.dart' as _i10;
import '../utils/helpers/fire_store_helper.dart' as _i9;
import '../utils/logger/logger.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutScreen>(() => _i3.AboutScreen());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.CartHiveHelper>(() => _i5.CartHiveHelper());
  gh.factory<_i6.CartScreen>(() => _i6.CartScreen());
  gh.factory<_i7.ChatHiveHelper>(() => _i7.ChatHiveHelper());
  gh.factory<_i8.FavoriteHiveHelper>(() => _i8.FavoriteHiveHelper());
  gh.factory<_i9.FireStoreHelper>(() => _i9.FireStoreHelper());
  gh.singleton<_i10.GlobalStateManager>(_i10.GlobalStateManager());
  gh.factory<_i11.LocalNotificationService>(
      () => _i11.LocalNotificationService());
  gh.factory<_i12.LocalizationPreferencesHelper>(
      () => _i12.LocalizationPreferencesHelper());
  gh.factory<_i13.LocalizationService>(() =>
      _i13.LocalizationService(get<_i12.LocalizationPreferencesHelper>()));
  gh.factory<_i14.Logger>(() => _i14.Logger());
  gh.factory<_i15.MainScreen>(() => _i15.MainScreen());
  gh.factory<_i16.NotificationsPrefHelper>(
      () => _i16.NotificationsPrefHelper());
  gh.factory<_i17.PrivecyPolicy>(() => _i17.PrivecyPolicy());
  gh.factory<_i18.ReportPrefsHelper>(() => _i18.ReportPrefsHelper());
  gh.factory<_i19.TermsOfUse>(() => _i19.TermsOfUse());
  gh.factory<_i20.ThemePreferencesHelper>(() => _i20.ThemePreferencesHelper());
  gh.factory<_i21.UploadRepository>(() => _i21.UploadRepository());
  gh.factory<_i22.ApiClient>(() => _i22.ApiClient(get<_i14.Logger>()));
  gh.factory<_i23.AppThemeDataService>(
      () => _i23.AppThemeDataService(get<_i20.ThemePreferencesHelper>()));
  gh.factory<_i24.AuthRepository>(
      () => _i24.AuthRepository(get<_i22.ApiClient>(), get<_i14.Logger>()));
  gh.factory<_i25.ChooseLocalScreen>(
      () => _i25.ChooseLocalScreen(get<_i13.LocalizationService>()));
  gh.factory<_i26.MainModule>(() => _i26.MainModule(get<_i15.MainScreen>()));
  gh.factory<_i27.SearchRepository>(
      () => _i27.SearchRepository(get<_i22.ApiClient>()));
  gh.factory<_i28.StoreListRepository>(
      () => _i28.StoreListRepository(get<_i22.ApiClient>()));
  gh.factory<_i29.UploadManager>(
      () => _i29.UploadManager(get<_i21.UploadRepository>()));
  gh.factory<_i30.AuthManager>(
      () => _i30.AuthManager(get<_i24.AuthRepository>()));
  gh.factory<_i31.AuthService>(() =>
      _i31.AuthService(get<_i4.AuthPrefsHelper>(), get<_i30.AuthManager>()));
  gh.factory<_i32.ChatRepository>(() =>
      _i32.ChatRepository(get<_i22.ApiClient>(), get<_i31.AuthService>()));
  gh.factory<_i33.ForgotPassStateManager>(
      () => _i33.ForgotPassStateManager(get<_i31.AuthService>()));
  gh.factory<_i34.HomeRepository>(() =>
      _i34.HomeRepository(get<_i22.ApiClient>(), get<_i31.AuthService>()));
  gh.factory<_i35.ImageUploadService>(
      () => _i35.ImageUploadService(get<_i29.UploadManager>()));
  gh.factory<_i36.LoginStateManager>(
      () => _i36.LoginStateManager(get<_i31.AuthService>()));
  gh.factory<_i37.MyNotificationsRepository>(() =>
      _i37.MyNotificationsRepository(
          get<_i22.ApiClient>(), get<_i31.AuthService>()));
  gh.factory<_i38.MyOrdersRepository>(() =>
      _i38.MyOrdersRepository(get<_i22.ApiClient>(), get<_i31.AuthService>()));
  gh.factory<_i39.NotificationRepo>(() =>
      _i39.NotificationRepo(get<_i22.ApiClient>(), get<_i31.AuthService>()));
  gh.factory<_i40.ProductsRepository>(() =>
      _i40.ProductsRepository(get<_i22.ApiClient>(), get<_i31.AuthService>()));
  gh.factory<_i41.RegisterStateManager>(
      () => _i41.RegisterStateManager(get<_i31.AuthService>()));
  gh.factory<_i42.ReportRepository>(() => _i42.ReportRepository(
      get<_i22.ApiClient>(),
      get<_i31.AuthService>(),
      get<_i18.ReportPrefsHelper>()));
  gh.factory<_i43.SearchManager>(
      () => _i43.SearchManager(get<_i27.SearchRepository>()));
  gh.factory<_i44.SearchService>(
      () => _i44.SearchService(get<_i43.SearchManager>()));
  gh.factory<_i45.SearchStateManager>(
      () => _i45.SearchStateManager(get<_i44.SearchService>()));
  gh.factory<_i46.ServicesRepository>(() =>
      _i46.ServicesRepository(get<_i22.ApiClient>(), get<_i31.AuthService>()));
  gh.factory<_i47.SplashScreen>(() => _i47.SplashScreen(
      get<_i31.AuthService>(), get<_i13.LocalizationService>()));
  gh.factory<_i48.StoreListManager>(
      () => _i48.StoreListManager(get<_i28.StoreListRepository>()));
  gh.factory<_i49.StoreListService>(
      () => _i49.StoreListService(get<_i48.StoreListManager>()));
  gh.factory<_i50.StoreListStateManager>(
      () => _i50.StoreListStateManager(get<_i49.StoreListService>()));
  gh.factory<_i51.StoreProductsRepository>(() => _i51.StoreProductsRepository(
      get<_i22.ApiClient>(), get<_i31.AuthService>()));
  gh.factory<_i52.AccountRepository>(() =>
      _i52.AccountRepository(get<_i31.AuthService>(), get<_i22.ApiClient>()));
  gh.factory<_i53.ChatManager>(
      () => _i53.ChatManager(get<_i32.ChatRepository>()));
  gh.factory<_i54.ChatService>(() => _i54.ChatService(get<_i53.ChatManager>()));
  gh.factory<_i55.ChatStateManager>(
      () => _i55.ChatStateManager(get<_i54.ChatService>()));
  gh.factory<_i56.FireNotificationService>(() => _i56.FireNotificationService(
      get<_i16.NotificationsPrefHelper>(), get<_i39.NotificationRepo>()));
  gh.factory<_i57.ForgotPassScreen>(
      () => _i57.ForgotPassScreen(get<_i33.ForgotPassStateManager>()));
  gh.factory<_i58.HomeManager>(
      () => _i58.HomeManager(get<_i34.HomeRepository>()));
  gh.factory<_i59.HomeService>(() => _i59.HomeService(get<_i58.HomeManager>()));
  gh.factory<_i60.HomeStateManager>(
      () => _i60.HomeStateManager(get<_i59.HomeService>()));
  gh.factory<_i61.LoginScreen>(
      () => _i61.LoginScreen(get<_i36.LoginStateManager>()));
  gh.factory<_i62.MyNotificationsManager>(
      () => _i62.MyNotificationsManager(get<_i37.MyNotificationsRepository>()));
  gh.factory<_i63.MyNotificationsService>(
      () => _i63.MyNotificationsService(get<_i62.MyNotificationsManager>()));
  gh.factory<_i64.MyNotificationsStateManager>(() =>
      _i64.MyNotificationsStateManager(
          get<_i63.MyNotificationsService>(), get<_i31.AuthService>()));
  gh.factory<_i65.MyOrdersManager>(
      () => _i65.MyOrdersManager(get<_i38.MyOrdersRepository>()));
  gh.factory<_i66.OrdersService>(() => _i66.OrdersService(
      get<_i65.MyOrdersManager>(), get<_i9.FireStoreHelper>()));
  gh.factory<_i67.ProductsManager>(
      () => _i67.ProductsManager(get<_i40.ProductsRepository>()));
  gh.factory<_i68.ProductsService>(
      () => _i68.ProductsService(get<_i67.ProductsManager>()));
  gh.factory<_i69.RegisterScreen>(
      () => _i69.RegisterScreen(get<_i41.RegisterStateManager>()));
  gh.factory<_i70.ReportManager>(
      () => _i70.ReportManager(get<_i42.ReportRepository>()));
  gh.factory<_i71.ReportService>(
      () => _i71.ReportService(get<_i70.ReportManager>()));
  gh.factory<_i72.SearchScreen>(
      () => _i72.SearchScreen(get<_i45.SearchStateManager>()));
  gh.factory<_i73.ServicesManager>(
      () => _i73.ServicesManager(get<_i46.ServicesRepository>()));
  gh.factory<_i74.ServicesService>(() => _i74.ServicesService(
      get<_i73.ServicesManager>(), get<_i9.FireStoreHelper>()));
  gh.factory<_i75.ServicesStateManager>(() => _i75.ServicesStateManager(
      get<_i74.ServicesService>(), get<_i31.AuthService>()));
  gh.factory<_i76.SettingsScreen>(() => _i76.SettingsScreen(
      get<_i31.AuthService>(),
      get<_i13.LocalizationService>(),
      get<_i23.AppThemeDataService>(),
      get<_i56.FireNotificationService>()));
  gh.factory<_i77.SplashModule>(
      () => _i77.SplashModule(get<_i47.SplashScreen>()));
  gh.factory<_i78.StoreListScreen>(
      () => _i78.StoreListScreen(get<_i50.StoreListStateManager>()));
  gh.factory<_i79.StoreProductsManager>(
      () => _i79.StoreProductsManager(get<_i51.StoreProductsRepository>()));
  gh.factory<_i80.StoreProductsService>(
      () => _i80.StoreProductsService(get<_i79.StoreProductsManager>()));
  gh.factory<_i81.StoreProductsStateManager>(
      () => _i81.StoreProductsStateManager(get<_i80.StoreProductsService>()));
  gh.factory<_i82.AccountManager>(
      () => _i82.AccountManager(get<_i52.AccountRepository>()));
  gh.factory<_i83.AccountService>(
      () => _i83.AccountService(get<_i82.AccountManager>()));
  gh.factory<_i84.AccountStateManager>(() => _i84.AccountStateManager(
      get<_i83.AccountService>(), get<_i31.AuthService>()));
  gh.factory<_i85.AuthorizationModule>(() => _i85.AuthorizationModule(
      get<_i61.LoginScreen>(),
      get<_i69.RegisterScreen>(),
      get<_i57.ForgotPassScreen>()));
  gh.factory<_i86.ChatPage>(() => _i86.ChatPage(
      get<_i55.ChatStateManager>(),
      get<_i35.ImageUploadService>(),
      get<_i31.AuthService>(),
      get<_i7.ChatHiveHelper>()));
  gh.factory<_i87.ClientOrderStateManager>(() => _i87.ClientOrderStateManager(
      get<_i66.OrdersService>(), get<_i31.AuthService>()));
  gh.factory<_i88.FavouriteStateManager>(() => _i88.FavouriteStateManager(
      get<_i83.AccountService>(), get<_i59.HomeService>()));
  gh.factory<_i89.HomeScreen>(
      () => _i89.HomeScreen(get<_i60.HomeStateManager>()));
  gh.factory<_i90.MyNotificationsScreen>(() =>
      _i90.MyNotificationsScreen(get<_i64.MyNotificationsStateManager>()));
  gh.factory<_i91.MyOrdersStateManager>(() => _i91.MyOrdersStateManager(
      get<_i66.OrdersService>(),
      get<_i31.AuthService>(),
      get<_i9.FireStoreHelper>()));
  gh.factory<_i92.OrderDetailsStateManager>(() => _i92.OrderDetailsStateManager(
      get<_i66.OrdersService>(), get<_i9.FireStoreHelper>()));
  gh.factory<_i93.OrderLogsStateManager>(
      () => _i93.OrderLogsStateManager(get<_i66.OrdersService>()));
  gh.factory<_i94.OrderStatusStateManager>(() => _i94.OrderStatusStateManager(
      get<_i66.OrdersService>(), get<_i9.FireStoreHelper>()));
  gh.factory<_i95.PersonalDataStateManager>(() => _i95.PersonalDataStateManager(
      get<_i83.AccountService>(), get<_i35.ImageUploadService>()));
  gh.factory<_i96.PrivateOrderStateManager>(() => _i96.PrivateOrderStateManager(
      get<_i74.ServicesService>(), get<_i31.AuthService>()));
  gh.factory<_i97.ProductDetailsStateManager>(
      () => _i97.ProductDetailsStateManager(get<_i68.ProductsService>()));
  gh.factory<_i98.SearchModule>(
      () => _i98.SearchModule(get<_i72.SearchScreen>()));
  gh.factory<_i99.SendItScreen>(
      () => _i99.SendItScreen(get<_i75.ServicesStateManager>()));
  gh.factory<_i100.SettingsModule>(() => _i100.SettingsModule(
      get<_i76.SettingsScreen>(), get<_i25.ChooseLocalScreen>()));
  gh.factory<_i101.StoreProductsScreen>(() => _i101.StoreProductsScreen(
      get<_i81.StoreProductsStateManager>(), get<_i31.AuthService>()));
  gh.factory<_i102.AccountScreen>(
      () => _i102.AccountScreen(get<_i84.AccountStateManager>()));
  gh.factory<_i103.ChatModule>(
      () => _i103.ChatModule(get<_i86.ChatPage>(), get<_i31.AuthService>()));
  gh.factory<_i104.ClientOrderScreen>(
      () => _i104.ClientOrderScreen(get<_i87.ClientOrderStateManager>()));
  gh.factory<_i105.FavouritScreen>(
      () => _i105.FavouritScreen(get<_i88.FavouriteStateManager>()));
  gh.factory<_i106.HomeModule>(() => _i106.HomeModule(get<_i89.HomeScreen>()));
  gh.factory<_i107.MyNotificationsModule>(
      () => _i107.MyNotificationsModule(get<_i90.MyNotificationsScreen>()));
  gh.factory<_i108.MyOrdersScreen>(
      () => _i108.MyOrdersScreen(get<_i91.MyOrdersStateManager>()));
  gh.factory<_i109.OrderDetailsScreen>(
      () => _i109.OrderDetailsScreen(get<_i92.OrderDetailsStateManager>()));
  gh.factory<_i110.OrderLogsScreen>(
      () => _i110.OrderLogsScreen(get<_i93.OrderLogsStateManager>()));
  gh.factory<_i111.OrderStatusScreen>(
      () => _i111.OrderStatusScreen(get<_i94.OrderStatusStateManager>()));
  gh.factory<_i112.OrdersModule>(() => _i112.OrdersModule(
      get<_i108.MyOrdersScreen>(),
      get<_i109.OrderDetailsScreen>(),
      get<_i111.OrderStatusScreen>(),
      get<_i104.ClientOrderScreen>(),
      get<_i110.OrderLogsScreen>()));
  gh.factory<_i113.PersonalDataScreen>(
      () => _i113.PersonalDataScreen(get<_i95.PersonalDataStateManager>()));
  gh.factory<_i114.PrivateOrderScreen>(
      () => _i114.PrivateOrderScreen(get<_i96.PrivateOrderStateManager>()));
  gh.factory<_i115.ProductDetailsScreen>(
      () => _i115.ProductDetailsScreen(get<_i97.ProductDetailsStateManager>()));
  gh.factory<_i116.ProductsModule>(() => _i116.ProductsModule(
      get<_i115.ProductDetailsScreen>(), get<_i6.CartScreen>()));
  gh.factory<_i117.ServicesModule>(() => _i117.ServicesModule(
      get<_i99.SendItScreen>(), get<_i114.PrivateOrderScreen>()));
  gh.factory<_i118.StoreModule>(() => _i118.StoreModule(
      get<_i78.StoreListScreen>(), get<_i101.StoreProductsScreen>()));
  gh.factory<_i119.AccountModule>(() => _i119.AccountModule(
      get<_i102.AccountScreen>(),
      get<_i113.PersonalDataScreen>(),
      get<_i3.AboutScreen>(),
      get<_i17.PrivecyPolicy>(),
      get<_i19.TermsOfUse>()));
  gh.factory<_i120.MyApp>(() => _i120.MyApp(
      get<_i23.AppThemeDataService>(),
      get<_i13.LocalizationService>(),
      get<_i56.FireNotificationService>(),
      get<_i11.LocalNotificationService>(),
      get<_i77.SplashModule>(),
      get<_i85.AuthorizationModule>(),
      get<_i103.ChatModule>(),
      get<_i100.SettingsModule>(),
      get<_i26.MainModule>(),
      get<_i112.OrdersModule>(),
      get<_i98.SearchModule>(),
      get<_i119.AccountModule>(),
      get<_i117.ServicesModule>(),
      get<_i118.StoreModule>(),
      get<_i107.MyNotificationsModule>(),
      get<_i116.ProductsModule>()));
  return get;
}
