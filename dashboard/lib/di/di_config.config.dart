// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i151;
import '../module_auth/authoriazation_module.dart' as _i86;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i16;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i14;
import '../module_auth/service/auth_service/auth_service.dart' as _i17;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i32;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i61;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i75;
import '../module_captain/captains_module.dart' as _i149;
import '../module_captain/manager/captains_manager.dart' as _i39;
import '../module_captain/repository/captain_repository.dart' as _i18;
import '../module_captain/service/captains_service.dart' as _i41;
import '../module_captain/state_manager/captain_balance_state_manager.dart'
    as _i87;
import '../module_captain/state_manager/captain_captains_payment_list_state_manager.dart'
    as _i91;
import '../module_captain/state_manager/captain_list.dart' as _i42;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i90;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i60;
import '../module_captain/ui/screen/captain_balance_screen.dart' as _i126;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i129;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i93;
import '../module_captain/ui/screen/catpains_payment_screen.dart' as _i130;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i101;
import '../module_categories/categories_module.dart' as _i131;
import '../module_categories/manager/categories_manager.dart' as _i43;
import '../module_categories/repository/categories_repository.dart' as _i19;
import '../module_categories/service/store_categories_service.dart' as _i44;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i73;
import '../module_categories/state_manager/store_categories_state_manager.dart'
    as _i78;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i81;
import '../module_categories/ui/screen/product_categories_screen.dart' as _i115;
import '../module_categories/ui/screen/store_categories_screen.dart' as _i119;
import '../module_categories/ui/screen/store_products_screen.dart' as _i121;
import '../module_chat/chat_module.dart' as _i132;
import '../module_chat/manager/chat/chat_manager.dart' as _i45;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i20;
import '../module_chat/service/chat/char_service.dart' as _i46;
import '../module_chat/state_manager/chat_state_manager.dart' as _i47;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i94;
import '../module_clients/clients_module.dart' as _i134;
import '../module_clients/manager/clients_manager.dart' as _i48;
import '../module_clients/repository/clients_repository.dart' as _i21;
import '../module_clients/service/clients_service.dart' as _i50;
import '../module_clients/state_manager/captain_list.dart' as _i51;
import '../module_clients/state_manager/captain_profile_state_manager.dart'
    as _i95;
import '../module_clients/ui/screen/clients_list_screen.dart' as _i97;
import '../module_clients/ui/screen/clients_profile_screen.dart' as _i133;
import '../module_company/company_module.dart' as _i150;
import '../module_company/manager/company_manager.dart' as _i52;
import '../module_company/repository/company_repository.dart' as _i22;
import '../module_company/service/company_service.dart' as _i53;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i98;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i99;
import '../module_company/ui/screen/company_finance_screen.dart' as _i135;
import '../module_company/ui/screen/company_profile_screen.dart' as _i136;
import '../module_filters/filters_module.dart' as _i137;
import '../module_filters/manager/filters_manager.dart' as _i54;
import '../module_filters/repository/filters_repository.dart' as _i23;
import '../module_filters/service/filters_service.dart' as _i55;
import '../module_filters/state_manager/captain_filter_state_manager.dart'
    as _i88;
import '../module_filters/state_manager/store_filter_state_manager.dart'
    as _i82;
import '../module_filters/ui/screen/captain_filter_screen.dart' as _i127;
import '../module_filters/ui/screen/store_filter_screen.dart' as _i123;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_logs/logs_module.dart' as _i138;
import '../module_logs/manager/logs_manager.dart' as _i62;
import '../module_logs/repository/logs_repository.dart' as _i27;
import '../module_logs/service/logs_service.dart' as _i63;
import '../module_logs/state_manager/captain_logs_state_manager.dart' as _i89;
import '../module_logs/state_manager/store_logs_state_manager.dart' as _i79;
import '../module_logs/ui/screen/captain_logs_screen.dart' as _i128;
import '../module_logs/ui/screen/store_logs_screen.dart' as _i120;
import '../module_main/main_module.dart' as _i139;
import '../module_main/manager/home_manager.dart' as _i57;
import '../module_main/repository/home_repository.dart' as _i24;
import '../module_main/sceen/home_screen.dart' as _i100;
import '../module_main/sceen/main_screen.dart' as _i102;
import '../module_main/service/home_service.dart' as _i58;
import '../module_main/state_manager/home_state_manager.dart' as _i59;
import '../module_network/http_client/http_client.dart' as _i12;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i9;
import '../module_notifications/repository/notification_repo.dart' as _i29;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i56;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_orders/manager/my_orders_manager.dart' as _i64;
import '../module_orders/orders_module.dart' as _i143;
import '../module_orders/repository/orders_repository.dart' as _i28;
import '../module_orders/service/orders_service.dart' as _i66;
import '../module_orders/state_manager/captains_from_state_manager.dart'
    as _i65;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i103;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i104;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i105;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i106;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i107;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i109;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i140;
import '../module_orders/ui/screen/order_accounts_screen.dart' as _i108;
import '../module_orders/ui/screen/order_details_screen.dart' as _i141;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i142;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i110;
import '../module_payment_portal/manager/portals_manager.dart' as _i70;
import '../module_payment_portal/portals_module.dart' as _i114;
import '../module_payment_portal/repository/portals_repository.dart' as _i31;
import '../module_payment_portal/service/portals_service.dart' as _i71;
import '../module_payment_portal/state_manager/payments_from_state_manager.dart'
    as _i72;
import '../module_payment_portal/ui/screen/paymen_from_captain_screen.dart'
    as _i113;
import '../module_payments/manager/payments_manager.dart' as _i67;
import '../module_payments/payments_module.dart' as _i145;
import '../module_payments/repository/payments_repository.dart' as _i30;
import '../module_payments/service/payments_service.dart' as _i68;
import '../module_payments/state_manager/payments_from_state_manager.dart'
    as _i111;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i69;
import '../module_payments/ui/screen/paymen_from_captain_screen.dart' as _i144;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i112;
import '../module_reports/manager/reports_manager.dart' as _i34;
import '../module_reports/report_module.dart' as _i117;
import '../module_reports/repository/reports_repository.dart' as _i33;
import '../module_reports/service/reports_service.dart' as _i35;
import '../module_reports/state_manager/captains_report_state_manager.dart'
    as _i40;
import '../module_reports/state_manager/clients_report_state_manager.dart'
    as _i49;
import '../module_reports/state_manager/products_report_state_manager.dart'
    as _i74;
import '../module_reports/state_manager/stores_report_state_manager.dart'
    as _i37;
import '../module_reports/ui/screen/captains_reports_screen.dart' as _i92;
import '../module_reports/ui/screen/clients_reports_screen.dart' as _i96;
import '../module_reports/ui/screen/products_reports_screen.dart' as _i116;
import '../module_reports/ui/screen/stores_reports_screen.dart' as _i83;
import '../module_settings/settings_module.dart' as _i118;
import '../module_settings/ui/settings_page/settings_page.dart' as _i76;
import '../module_splash/splash_module.dart' as _i77;
import '../module_splash/ui/screen/splash_screen.dart' as _i36;
import '../module_stores/manager/stores_manager.dart' as _i80;
import '../module_stores/repository/stores_repository.dart' as _i38;
import '../module_stores/service/store_service.dart' as _i84;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i122;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i124;
import '../module_stores/state_manager/stores_state_manager.dart' as _i85;
import '../module_stores/stores_module.dart' as _i148;
import '../module_stores/ui/screen/store_info_screen.dart' as _i146;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i147;
import '../module_stores/ui/screen/stores_screen.dart' as _i125;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i10;
import '../module_theme/service/theme_service/theme_service.dart' as _i13;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i15;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i11;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i25;
import '../utils/global/global_state_manager.dart' as _i152;
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
  gh.factory<_i9.NotificationsPrefsHelper>(
      () => _i9.NotificationsPrefsHelper());
  gh.factory<_i10.ThemePreferencesHelper>(() => _i10.ThemePreferencesHelper());
  gh.factory<_i11.UploadRepository>(() => _i11.UploadRepository());
  gh.factory<_i12.ApiClient>(() => _i12.ApiClient(get<_i8.Logger>()));
  gh.factory<_i13.AppThemeDataService>(
      () => _i13.AppThemeDataService(get<_i10.ThemePreferencesHelper>()));
  gh.factory<_i14.AuthRepository>(
      () => _i14.AuthRepository(get<_i12.ApiClient>(), get<_i8.Logger>()));
  gh.factory<_i15.UploadManager>(
      () => _i15.UploadManager(get<_i11.UploadRepository>()));
  gh.factory<_i16.AuthManager>(
      () => _i16.AuthManager(get<_i14.AuthRepository>()));
  gh.factory<_i17.AuthService>(() =>
      _i17.AuthService(get<_i3.AuthPrefsHelper>(), get<_i16.AuthManager>()));
  gh.factory<_i18.CaptainRepository>(() =>
      _i18.CaptainRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i19.CategoriesRepository>(() => _i19.CategoriesRepository(
      get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i20.ChatRepository>(() =>
      _i20.ChatRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i21.ClientsRepository>(() =>
      _i21.ClientsRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i22.CompanyRepository>(() =>
      _i22.CompanyRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i23.FiltersRepository>(() =>
      _i23.FiltersRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i24.HomeRepository>(() =>
      _i24.HomeRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i25.ImageUploadService>(
      () => _i25.ImageUploadService(get<_i15.UploadManager>()));
  gh.factory<_i26.LoginStateManager>(
      () => _i26.LoginStateManager(get<_i17.AuthService>()));
  gh.factory<_i27.LogsRepository>(() =>
      _i27.LogsRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i28.MyOrdersRepository>(() =>
      _i28.MyOrdersRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i29.NotificationRepo>(() =>
      _i29.NotificationRepo(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i30.PaymentsRepository>(() =>
      _i30.PaymentsRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i31.PortalsRepository>(() =>
      _i31.PortalsRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i32.RegisterStateManager>(
      () => _i32.RegisterStateManager(get<_i17.AuthService>()));
  gh.factory<_i33.ReportRepository>(() =>
      _i33.ReportRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i34.ReportsManager>(
      () => _i34.ReportsManager(get<_i33.ReportRepository>()));
  gh.factory<_i35.ReportsService>(
      () => _i35.ReportsService(get<_i34.ReportsManager>()));
  gh.factory<_i36.SplashScreen>(
      () => _i36.SplashScreen(get<_i17.AuthService>()));
  gh.factory<_i37.StoresReportStateManager>(
      () => _i37.StoresReportStateManager(get<_i35.ReportsService>()));
  gh.factory<_i38.StoresRepository>(() =>
      _i38.StoresRepository(get<_i12.ApiClient>(), get<_i17.AuthService>()));
  gh.factory<_i39.CaptainManager>(
      () => _i39.CaptainManager(get<_i18.CaptainRepository>()));
  gh.factory<_i40.CaptainsReportStateManager>(
      () => _i40.CaptainsReportStateManager(get<_i35.ReportsService>()));
  gh.factory<_i41.CaptainsService>(
      () => _i41.CaptainsService(get<_i39.CaptainManager>()));
  gh.factory<_i42.CaptainsStateManager>(
      () => _i42.CaptainsStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i43.CategoriesManager>(
      () => _i43.CategoriesManager(get<_i19.CategoriesRepository>()));
  gh.factory<_i44.CategoriesService>(
      () => _i44.CategoriesService(get<_i43.CategoriesManager>()));
  gh.factory<_i45.ChatManager>(
      () => _i45.ChatManager(get<_i20.ChatRepository>()));
  gh.factory<_i46.ChatService>(() => _i46.ChatService(get<_i45.ChatManager>()));
  gh.factory<_i47.ChatStateManager>(
      () => _i47.ChatStateManager(get<_i46.ChatService>()));
  gh.factory<_i48.ClientsManager>(
      () => _i48.ClientsManager(get<_i21.ClientsRepository>()));
  gh.factory<_i49.ClientsReportStateManager>(
      () => _i49.ClientsReportStateManager(get<_i35.ReportsService>()));
  gh.factory<_i50.ClientsService>(
      () => _i50.ClientsService(get<_i48.ClientsManager>()));
  gh.factory<_i51.ClientsStateManager>(
      () => _i51.ClientsStateManager(get<_i50.ClientsService>()));
  gh.factory<_i52.CompanyManager>(
      () => _i52.CompanyManager(get<_i22.CompanyRepository>()));
  gh.factory<_i53.CompanyService>(
      () => _i53.CompanyService(get<_i52.CompanyManager>()));
  gh.factory<_i54.FiltersManager>(
      () => _i54.FiltersManager(get<_i23.FiltersRepository>()));
  gh.factory<_i55.FiltersService>(
      () => _i55.FiltersService(get<_i54.FiltersManager>()));
  gh.factory<_i56.FireNotificationService>(() => _i56.FireNotificationService(
      get<_i9.NotificationsPrefsHelper>(), get<_i29.NotificationRepo>()));
  gh.factory<_i57.HomeManager>(
      () => _i57.HomeManager(get<_i24.HomeRepository>()));
  gh.factory<_i58.HomeService>(() => _i58.HomeService(get<_i57.HomeManager>()));
  gh.factory<_i59.HomeStateManager>(
      () => _i59.HomeStateManager(get<_i58.HomeService>()));
  gh.factory<_i60.InActiveCaptainsStateManager>(
      () => _i60.InActiveCaptainsStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i61.LoginScreen>(
      () => _i61.LoginScreen(get<_i26.LoginStateManager>()));
  gh.factory<_i62.LogsManager>(
      () => _i62.LogsManager(get<_i27.LogsRepository>()));
  gh.factory<_i63.LogsService>(() => _i63.LogsService(get<_i62.LogsManager>()));
  gh.factory<_i64.MyOrdersManager>(
      () => _i64.MyOrdersManager(get<_i28.MyOrdersRepository>()));
  gh.factory<_i65.OrdersAccountStateManager>(
      () => _i65.OrdersAccountStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i66.OrdersService>(
      () => _i66.OrdersService(get<_i64.MyOrdersManager>()));
  gh.factory<_i67.PaymentsManager>(
      () => _i67.PaymentsManager(get<_i30.PaymentsRepository>()));
  gh.factory<_i68.PaymentsService>(
      () => _i68.PaymentsService(get<_i67.PaymentsManager>()));
  gh.factory<_i69.PaymentsToCaptainStateManager>(() =>
      _i69.PaymentsToCaptainStateManager(
          get<_i41.CaptainsService>(), get<_i68.PaymentsService>()));
  gh.factory<_i70.PortalsManager>(
      () => _i70.PortalsManager(get<_i31.PortalsRepository>()));
  gh.factory<_i71.PortalsService>(
      () => _i71.PortalsService(get<_i70.PortalsManager>()));
  gh.factory<_i72.PortalsStateManager>(
      () => _i72.PortalsStateManager(get<_i71.PortalsService>()));
  gh.factory<_i73.ProductsCategoryStateManager>(() =>
      _i73.ProductsCategoryStateManager(get<_i44.CategoriesService>(),
          get<_i17.AuthService>(), get<_i25.ImageUploadService>()));
  gh.factory<_i74.ProductsReportStateManager>(
      () => _i74.ProductsReportStateManager(get<_i35.ReportsService>()));
  gh.factory<_i75.RegisterScreen>(
      () => _i75.RegisterScreen(get<_i32.RegisterStateManager>()));
  gh.factory<_i76.SettingsScreen>(() => _i76.SettingsScreen(
      get<_i17.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i13.AppThemeDataService>(),
      get<_i56.FireNotificationService>()));
  gh.factory<_i77.SplashModule>(
      () => _i77.SplashModule(get<_i36.SplashScreen>()));
  gh.factory<_i78.StoreCategoriesStateManager>(() =>
      _i78.StoreCategoriesStateManager(get<_i44.CategoriesService>(),
          get<_i17.AuthService>(), get<_i25.ImageUploadService>()));
  gh.factory<_i79.StoreLogsStateManager>(
      () => _i79.StoreLogsStateManager(get<_i63.LogsService>()));
  gh.factory<_i80.StoreManager>(
      () => _i80.StoreManager(get<_i38.StoresRepository>()));
  gh.factory<_i81.StoreProductsStateManager>(() =>
      _i81.StoreProductsStateManager(get<_i44.CategoriesService>(),
          get<_i17.AuthService>(), get<_i25.ImageUploadService>()));
  gh.factory<_i82.StoresFilterStateManager>(
      () => _i82.StoresFilterStateManager(get<_i55.FiltersService>()));
  gh.factory<_i83.StoresReportScreen>(
      () => _i83.StoresReportScreen(get<_i37.StoresReportStateManager>()));
  gh.factory<_i84.StoresService>(
      () => _i84.StoresService(get<_i80.StoreManager>()));
  gh.factory<_i85.StoresStateManager>(() => _i85.StoresStateManager(
      get<_i84.StoresService>(),
      get<_i17.AuthService>(),
      get<_i25.ImageUploadService>(),
      get<_i44.CategoriesService>()));
  gh.factory<_i86.AuthorizationModule>(() => _i86.AuthorizationModule(
      get<_i61.LoginScreen>(), get<_i75.RegisterScreen>()));
  gh.factory<_i87.CaptainBalanceStateManager>(
      () => _i87.CaptainBalanceStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i88.CaptainFilterStateManager>(
      () => _i88.CaptainFilterStateManager(get<_i55.FiltersService>()));
  gh.factory<_i89.CaptainLogsStateManager>(
      () => _i89.CaptainLogsStateManager(get<_i63.LogsService>()));
  gh.factory<_i90.CaptainProfileStateManager>(
      () => _i90.CaptainProfileStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i91.CaptainsPaymentsStateManager>(
      () => _i91.CaptainsPaymentsStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i92.CaptainsReportScreen>(
      () => _i92.CaptainsReportScreen(get<_i40.CaptainsReportStateManager>()));
  gh.factory<_i93.CaptainsScreen>(
      () => _i93.CaptainsScreen(get<_i42.CaptainsStateManager>()));
  gh.factory<_i94.ChatPage>(() => _i94.ChatPage(
      get<_i47.ChatStateManager>(),
      get<_i25.ImageUploadService>(),
      get<_i17.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i95.ClientProfileStateManager>(
      () => _i95.ClientProfileStateManager(get<_i50.ClientsService>()));
  gh.factory<_i96.ClientsReportScreen>(
      () => _i96.ClientsReportScreen(get<_i49.ClientsReportStateManager>()));
  gh.factory<_i97.ClientsScreen>(
      () => _i97.ClientsScreen(get<_i51.ClientsStateManager>()));
  gh.factory<_i98.CompanyFinanceStateManager>(() =>
      _i98.CompanyFinanceStateManager(
          get<_i17.AuthService>(), get<_i53.CompanyService>()));
  gh.factory<_i99.CompanyProfileStateManager>(() =>
      _i99.CompanyProfileStateManager(
          get<_i17.AuthService>(), get<_i53.CompanyService>()));
  gh.factory<_i100.HomeScreen>(
      () => _i100.HomeScreen(get<_i59.HomeStateManager>()));
  gh.factory<_i101.InActiveCaptainsScreen>(() =>
      _i101.InActiveCaptainsScreen(get<_i60.InActiveCaptainsStateManager>()));
  gh.factory<_i102.MainScreen>(() => _i102.MainScreen(get<_i100.HomeScreen>()));
  gh.factory<_i103.MyOrdersStateManager>(() => _i103.MyOrdersStateManager(
      get<_i66.OrdersService>(), get<_i17.AuthService>()));
  gh.factory<_i104.OnGoingOrdersStateManager>(() =>
      _i104.OnGoingOrdersStateManager(
          get<_i66.OrdersService>(), get<_i17.AuthService>()));
  gh.factory<_i105.OrderDetailsStateManager>(
      () => _i105.OrderDetailsStateManager(get<_i66.OrdersService>()));
  gh.factory<_i106.OrderTimeLineStateManager>(
      () => _i106.OrderTimeLineStateManager(get<_i66.OrdersService>()));
  gh.factory<_i107.OrderWithoutPendingStateManager>(() =>
      _i107.OrderWithoutPendingStateManager(
          get<_i66.OrdersService>(), get<_i17.AuthService>()));
  gh.factory<_i108.OrdersAccountScreen>(
      () => _i108.OrdersAccountScreen(get<_i65.OrdersAccountStateManager>()));
  gh.factory<_i109.OrdersScreen>(
      () => _i109.OrdersScreen(get<_i103.MyOrdersStateManager>()));
  gh.factory<_i110.OrdersWithoutPendingScreen>(() =>
      _i110.OrdersWithoutPendingScreen(
          get<_i107.OrderWithoutPendingStateManager>()));
  gh.factory<_i111.PaymentsFromCaptainStateManager>(() =>
      _i111.PaymentsFromCaptainStateManager(
          get<_i41.CaptainsService>(), get<_i68.PaymentsService>()));
  gh.factory<_i112.PaymentsToCaptainScreen>(() =>
      _i112.PaymentsToCaptainScreen(get<_i69.PaymentsToCaptainStateManager>()));
  gh.factory<_i113.PortalScreen>(
      () => _i113.PortalScreen(get<_i72.PortalsStateManager>()));
  gh.factory<_i114.PortalsModule>(
      () => _i114.PortalsModule(get<_i113.PortalScreen>()));
  gh.factory<_i115.ProductCategoriesScreen>(() =>
      _i115.ProductCategoriesScreen(get<_i73.ProductsCategoryStateManager>()));
  gh.factory<_i116.ProductsReportScreen>(
      () => _i116.ProductsReportScreen(get<_i74.ProductsReportStateManager>()));
  gh.factory<_i117.ReportsModule>(() => _i117.ReportsModule(
      get<_i116.ProductsReportScreen>(),
      get<_i83.StoresReportScreen>(),
      get<_i92.CaptainsReportScreen>(),
      get<_i96.ClientsReportScreen>()));
  gh.factory<_i118.SettingsModule>(
      () => _i118.SettingsModule(get<_i76.SettingsScreen>()));
  gh.factory<_i119.StoreCategoriesScreen>(() =>
      _i119.StoreCategoriesScreen(get<_i78.StoreCategoriesStateManager>()));
  gh.factory<_i120.StoreLogsScreen>(
      () => _i120.StoreLogsScreen(get<_i79.StoreLogsStateManager>()));
  gh.factory<_i121.StoreProductScreen>(
      () => _i121.StoreProductScreen(get<_i81.StoreProductsStateManager>()));
  gh.factory<_i122.StoreProfileStateManager>(
      () => _i122.StoreProfileStateManager(get<_i84.StoresService>()));
  gh.factory<_i123.StoresFilterScreen>(
      () => _i123.StoresFilterScreen(get<_i82.StoresFilterStateManager>()));
  gh.factory<_i124.StoresInActiveStateManager>(() =>
      _i124.StoresInActiveStateManager(
          get<_i84.StoresService>(),
          get<_i17.AuthService>(),
          get<_i25.ImageUploadService>(),
          get<_i44.CategoriesService>()));
  gh.factory<_i125.StoresScreen>(
      () => _i125.StoresScreen(get<_i85.StoresStateManager>()));
  gh.factory<_i126.CaptainBalanceScreen>(
      () => _i126.CaptainBalanceScreen(get<_i87.CaptainBalanceStateManager>()));
  gh.factory<_i127.CaptainFilterScreen>(
      () => _i127.CaptainFilterScreen(get<_i88.CaptainFilterStateManager>()));
  gh.factory<_i128.CaptainLogsScreen>(
      () => _i128.CaptainLogsScreen(get<_i89.CaptainLogsStateManager>()));
  gh.factory<_i129.CaptainProfileScreen>(
      () => _i129.CaptainProfileScreen(get<_i90.CaptainProfileStateManager>()));
  gh.factory<_i130.CaptainsPaymentsScreen>(() =>
      _i130.CaptainsPaymentsScreen(get<_i91.CaptainsPaymentsStateManager>()));
  gh.factory<_i131.CategoriesModule>(() => _i131.CategoriesModule(
      get<_i119.StoreCategoriesScreen>(),
      get<_i115.ProductCategoriesScreen>(),
      get<_i121.StoreProductScreen>()));
  gh.factory<_i132.ChatModule>(
      () => _i132.ChatModule(get<_i94.ChatPage>(), get<_i17.AuthService>()));
  gh.factory<_i133.ClientProfileScreen>(
      () => _i133.ClientProfileScreen(get<_i95.ClientProfileStateManager>()));
  gh.factory<_i134.ClientsModule>(() => _i134.ClientsModule(
      get<_i133.ClientProfileScreen>(), get<_i97.ClientsScreen>()));
  gh.factory<_i135.CompanyFinanceScreen>(
      () => _i135.CompanyFinanceScreen(get<_i98.CompanyFinanceStateManager>()));
  gh.factory<_i136.CompanyProfileScreen>(
      () => _i136.CompanyProfileScreen(get<_i99.CompanyProfileStateManager>()));
  gh.factory<_i137.FiltersModule>(() => _i137.FiltersModule(
      get<_i127.CaptainFilterScreen>(), get<_i123.StoresFilterScreen>()));
  gh.factory<_i138.LogsModule>(() => _i138.LogsModule(
      get<_i128.CaptainLogsScreen>(), get<_i120.StoreLogsScreen>()));
  gh.factory<_i139.MainModule>(
      () => _i139.MainModule(get<_i102.MainScreen>(), get<_i100.HomeScreen>()));
  gh.factory<_i140.OnGoingOrdersScreen>(
      () => _i140.OnGoingOrdersScreen(get<_i104.OnGoingOrdersStateManager>()));
  gh.factory<_i141.OrderDetailsScreen>(
      () => _i141.OrderDetailsScreen(get<_i105.OrderDetailsStateManager>()));
  gh.factory<_i142.OrderTimLineScreen>(
      () => _i142.OrderTimLineScreen(get<_i106.OrderTimeLineStateManager>()));
  gh.factory<_i143.OrdersModule>(() => _i143.OrdersModule(
      get<_i109.OrdersScreen>(),
      get<_i141.OrderDetailsScreen>(),
      get<_i140.OnGoingOrdersScreen>(),
      get<_i142.OrderTimLineScreen>(),
      get<_i110.OrdersWithoutPendingScreen>(),
      get<_i108.OrdersAccountScreen>()));
  gh.factory<_i144.PaymentsFromCaptainScreen>(() =>
      _i144.PaymentsFromCaptainScreen(
          get<_i111.PaymentsFromCaptainStateManager>()));
  gh.factory<_i145.PaymentsModule>(() => _i145.PaymentsModule(
      get<_i144.PaymentsFromCaptainScreen>(),
      get<_i112.PaymentsToCaptainScreen>()));
  gh.factory<_i146.StoreInfoScreen>(
      () => _i146.StoreInfoScreen(get<_i122.StoreProfileStateManager>()));
  gh.factory<_i147.StoresInActiveScreen>(() =>
      _i147.StoresInActiveScreen(get<_i124.StoresInActiveStateManager>()));
  gh.factory<_i148.StoresModule>(() => _i148.StoresModule(
      get<_i125.StoresScreen>(),
      get<_i146.StoreInfoScreen>(),
      get<_i147.StoresInActiveScreen>()));
  gh.factory<_i149.CaptainsModule>(() => _i149.CaptainsModule(
      get<_i101.InActiveCaptainsScreen>(),
      get<_i129.CaptainProfileScreen>(),
      get<_i126.CaptainBalanceScreen>(),
      get<_i130.CaptainsPaymentsScreen>(),
      get<_i93.CaptainsScreen>()));
  gh.factory<_i150.CompanyModule>(() => _i150.CompanyModule(
      get<_i136.CompanyProfileScreen>(), get<_i135.CompanyFinanceScreen>()));
  gh.factory<_i151.MyApp>(() => _i151.MyApp(
      get<_i13.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i56.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i77.SplashModule>(),
      get<_i86.AuthorizationModule>(),
      get<_i132.ChatModule>(),
      get<_i118.SettingsModule>(),
      get<_i139.MainModule>(),
      get<_i131.CategoriesModule>(),
      get<_i148.StoresModule>(),
      get<_i149.CaptainsModule>(),
      get<_i150.CompanyModule>(),
      get<_i143.OrdersModule>(),
      get<_i145.PaymentsModule>(),
      get<_i137.FiltersModule>(),
      get<_i138.LogsModule>(),
      get<_i114.PortalsModule>()));
  gh.singleton<_i152.GlobalStateManager>(_i152.GlobalStateManager(
      get<_i60.InActiveCaptainsStateManager>(),
      get<_i42.CaptainsStateManager>()));
  return get;
}
