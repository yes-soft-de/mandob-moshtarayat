// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i154;
import '../module_auth/authoriazation_module.dart' as _i88;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i17;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i14;
import '../module_auth/service/auth_service/auth_service.dart' as _i18;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i33;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i62;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i76;
import '../module_captain/captains_module.dart' as _i152;
import '../module_captain/manager/captains_manager.dart' as _i40;
import '../module_captain/repository/captain_repository.dart' as _i19;
import '../module_captain/service/captains_service.dart' as _i42;
import '../module_captain/state_manager/captain_balance_state_manager.dart'
    as _i89;
import '../module_captain/state_manager/captain_captains_payment_list_state_manager.dart'
    as _i93;
import '../module_captain/state_manager/captain_list.dart' as _i43;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i92;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i61;
import '../module_captain/ui/screen/captain_balance_screen.dart' as _i129;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i132;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i95;
import '../module_captain/ui/screen/catpains_payment_screen.dart' as _i133;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i103;
import '../module_categories/categories_module.dart' as _i134;
import '../module_categories/manager/categories_manager.dart' as _i44;
import '../module_categories/repository/categories_repository.dart' as _i20;
import '../module_categories/service/store_categories_service.dart' as _i45;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i74;
import '../module_categories/state_manager/store_categories_state_manager.dart'
    as _i79;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i82;
import '../module_categories/state_manager/sub_categories_state_manager.dart'
    as _i87;
import '../module_categories/ui/screen/level_tow_categories_screen.dart'
    as _i104;
import '../module_categories/ui/screen/store_categories_screen.dart' as _i121;
import '../module_categories/ui/screen/store_products_screen.dart' as _i123;
import '../module_categories/ui/screen/sub_categories_screen.dart' as _i128;
import '../module_chat/chat_module.dart' as _i135;
import '../module_chat/manager/chat/chat_manager.dart' as _i46;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i21;
import '../module_chat/service/chat/char_service.dart' as _i47;
import '../module_chat/state_manager/chat_state_manager.dart' as _i48;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i96;
import '../module_clients/clients_module.dart' as _i137;
import '../module_clients/manager/clients_manager.dart' as _i49;
import '../module_clients/repository/clients_repository.dart' as _i22;
import '../module_clients/service/clients_service.dart' as _i51;
import '../module_clients/state_manager/captain_list.dart' as _i52;
import '../module_clients/state_manager/captain_profile_state_manager.dart'
    as _i97;
import '../module_clients/ui/screen/clients_list_screen.dart' as _i99;
import '../module_clients/ui/screen/clients_profile_screen.dart' as _i136;
import '../module_company/company_module.dart' as _i153;
import '../module_company/manager/company_manager.dart' as _i53;
import '../module_company/repository/company_repository.dart' as _i23;
import '../module_company/service/company_service.dart' as _i54;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i100;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i101;
import '../module_company/ui/screen/company_finance_screen.dart' as _i138;
import '../module_company/ui/screen/company_profile_screen.dart' as _i139;
import '../module_filters/filters_module.dart' as _i140;
import '../module_filters/manager/filters_manager.dart' as _i55;
import '../module_filters/repository/filters_repository.dart' as _i24;
import '../module_filters/service/filters_service.dart' as _i56;
import '../module_filters/state_manager/captain_filter_state_manager.dart'
    as _i90;
import '../module_filters/state_manager/store_filter_state_manager.dart'
    as _i83;
import '../module_filters/ui/screen/captain_filter_screen.dart' as _i130;
import '../module_filters/ui/screen/store_filter_screen.dart' as _i125;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_logs/logs_module.dart' as _i141;
import '../module_logs/manager/logs_manager.dart' as _i63;
import '../module_logs/repository/logs_repository.dart' as _i28;
import '../module_logs/service/logs_service.dart' as _i64;
import '../module_logs/state_manager/captain_logs_state_manager.dart' as _i91;
import '../module_logs/state_manager/store_logs_state_manager.dart' as _i80;
import '../module_logs/ui/screen/captain_logs_screen.dart' as _i131;
import '../module_logs/ui/screen/store_logs_screen.dart' as _i122;
import '../module_main/main_module.dart' as _i142;
import '../module_main/manager/home_manager.dart' as _i58;
import '../module_main/repository/home_repository.dart' as _i25;
import '../module_main/sceen/home_screen.dart' as _i102;
import '../module_main/sceen/main_screen.dart' as _i105;
import '../module_main/service/home_service.dart' as _i59;
import '../module_main/state_manager/home_state_manager.dart' as _i60;
import '../module_network/http_client/http_client.dart' as _i12;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i9;
import '../module_notifications/repository/notification_repo.dart' as _i30;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i57;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_orders/manager/my_orders_manager.dart' as _i65;
import '../module_orders/orders_module.dart' as _i146;
import '../module_orders/repository/orders_repository.dart' as _i29;
import '../module_orders/service/orders_service.dart' as _i67;
import '../module_orders/state_manager/captains_from_state_manager.dart'
    as _i66;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i106;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i107;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i108;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i109;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i110;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i112;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i143;
import '../module_orders/ui/screen/order_accounts_screen.dart' as _i111;
import '../module_orders/ui/screen/order_details_screen.dart' as _i144;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i145;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i113;
import '../module_payment_portal/manager/portals_manager.dart' as _i71;
import '../module_payment_portal/portals_module.dart' as _i117;
import '../module_payment_portal/repository/portals_repository.dart' as _i32;
import '../module_payment_portal/service/portals_service.dart' as _i72;
import '../module_payment_portal/state_manager/payments_from_state_manager.dart'
    as _i73;
import '../module_payment_portal/ui/screen/paymen_from_captain_screen.dart'
    as _i116;
import '../module_payments/manager/payments_manager.dart' as _i68;
import '../module_payments/payments_module.dart' as _i148;
import '../module_payments/repository/payments_repository.dart' as _i31;
import '../module_payments/service/payments_service.dart' as _i69;
import '../module_payments/state_manager/payments_from_state_manager.dart'
    as _i114;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i70;
import '../module_payments/ui/screen/paymen_from_captain_screen.dart' as _i147;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i115;
import '../module_reports/manager/reports_manager.dart' as _i35;
import '../module_reports/report_module.dart' as _i119;
import '../module_reports/repository/reports_repository.dart' as _i34;
import '../module_reports/service/reports_service.dart' as _i36;
import '../module_reports/state_manager/captains_report_state_manager.dart'
    as _i41;
import '../module_reports/state_manager/clients_report_state_manager.dart'
    as _i50;
import '../module_reports/state_manager/products_report_state_manager.dart'
    as _i75;
import '../module_reports/state_manager/stores_report_state_manager.dart'
    as _i38;
import '../module_reports/ui/screen/captains_reports_screen.dart' as _i94;
import '../module_reports/ui/screen/clients_reports_screen.dart' as _i98;
import '../module_reports/ui/screen/products_reports_screen.dart' as _i118;
import '../module_reports/ui/screen/stores_reports_screen.dart' as _i84;
import '../module_settings/settings_module.dart' as _i120;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i15;
import '../module_settings/ui/settings_page/settings_page.dart' as _i77;
import '../module_splash/splash_module.dart' as _i78;
import '../module_splash/ui/screen/splash_screen.dart' as _i37;
import '../module_stores/manager/stores_manager.dart' as _i81;
import '../module_stores/repository/stores_repository.dart' as _i39;
import '../module_stores/service/store_service.dart' as _i85;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i124;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i126;
import '../module_stores/state_manager/stores_state_manager.dart' as _i86;
import '../module_stores/stores_module.dart' as _i151;
import '../module_stores/ui/screen/store_info_screen.dart' as _i149;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i150;
import '../module_stores/ui/screen/stores_screen.dart' as _i127;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i10;
import '../module_theme/service/theme_service/theme_service.dart' as _i13;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i16;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i11;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i26;
import '../utils/global/global_state_manager.dart' as _i155;
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
  gh.factory<_i15.ChooseLocalScreen>(
      () => _i15.ChooseLocalScreen(get<_i7.LocalizationService>()));
  gh.factory<_i16.UploadManager>(
      () => _i16.UploadManager(get<_i11.UploadRepository>()));
  gh.factory<_i17.AuthManager>(
      () => _i17.AuthManager(get<_i14.AuthRepository>()));
  gh.factory<_i18.AuthService>(() =>
      _i18.AuthService(get<_i3.AuthPrefsHelper>(), get<_i17.AuthManager>()));
  gh.factory<_i19.CaptainRepository>(() =>
      _i19.CaptainRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i20.CategoriesRepository>(() => _i20.CategoriesRepository(
      get<_i12.ApiClient>(),
      get<_i18.AuthService>(),
      get<_i7.LocalizationService>()));
  gh.factory<_i21.ChatRepository>(() =>
      _i21.ChatRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i22.ClientsRepository>(() =>
      _i22.ClientsRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i23.CompanyRepository>(() =>
      _i23.CompanyRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i24.FiltersRepository>(() =>
      _i24.FiltersRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i25.HomeRepository>(() =>
      _i25.HomeRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i26.ImageUploadService>(
      () => _i26.ImageUploadService(get<_i16.UploadManager>()));
  gh.factory<_i27.LoginStateManager>(
      () => _i27.LoginStateManager(get<_i18.AuthService>()));
  gh.factory<_i28.LogsRepository>(() =>
      _i28.LogsRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i29.MyOrdersRepository>(() =>
      _i29.MyOrdersRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i30.NotificationRepo>(() =>
      _i30.NotificationRepo(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i31.PaymentsRepository>(() =>
      _i31.PaymentsRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i32.PortalsRepository>(() =>
      _i32.PortalsRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i33.RegisterStateManager>(
      () => _i33.RegisterStateManager(get<_i18.AuthService>()));
  gh.factory<_i34.ReportRepository>(() =>
      _i34.ReportRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i35.ReportsManager>(
      () => _i35.ReportsManager(get<_i34.ReportRepository>()));
  gh.factory<_i36.ReportsService>(
      () => _i36.ReportsService(get<_i35.ReportsManager>()));
  gh.factory<_i37.SplashScreen>(
      () => _i37.SplashScreen(get<_i18.AuthService>()));
  gh.factory<_i38.StoresReportStateManager>(
      () => _i38.StoresReportStateManager(get<_i36.ReportsService>()));
  gh.factory<_i39.StoresRepository>(() =>
      _i39.StoresRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i40.CaptainManager>(
      () => _i40.CaptainManager(get<_i19.CaptainRepository>()));
  gh.factory<_i41.CaptainsReportStateManager>(
      () => _i41.CaptainsReportStateManager(get<_i36.ReportsService>()));
  gh.factory<_i42.CaptainsService>(
      () => _i42.CaptainsService(get<_i40.CaptainManager>()));
  gh.factory<_i43.CaptainsStateManager>(
      () => _i43.CaptainsStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i44.CategoriesManager>(
      () => _i44.CategoriesManager(get<_i20.CategoriesRepository>()));
  gh.factory<_i45.CategoriesService>(
      () => _i45.CategoriesService(get<_i44.CategoriesManager>()));
  gh.factory<_i46.ChatManager>(
      () => _i46.ChatManager(get<_i21.ChatRepository>()));
  gh.factory<_i47.ChatService>(() => _i47.ChatService(get<_i46.ChatManager>()));
  gh.factory<_i48.ChatStateManager>(
      () => _i48.ChatStateManager(get<_i47.ChatService>()));
  gh.factory<_i49.ClientsManager>(
      () => _i49.ClientsManager(get<_i22.ClientsRepository>()));
  gh.factory<_i50.ClientsReportStateManager>(
      () => _i50.ClientsReportStateManager(get<_i36.ReportsService>()));
  gh.factory<_i51.ClientsService>(
      () => _i51.ClientsService(get<_i49.ClientsManager>()));
  gh.factory<_i52.ClientsStateManager>(
      () => _i52.ClientsStateManager(get<_i51.ClientsService>()));
  gh.factory<_i53.CompanyManager>(
      () => _i53.CompanyManager(get<_i23.CompanyRepository>()));
  gh.factory<_i54.CompanyService>(
      () => _i54.CompanyService(get<_i53.CompanyManager>()));
  gh.factory<_i55.FiltersManager>(
      () => _i55.FiltersManager(get<_i24.FiltersRepository>()));
  gh.factory<_i56.FiltersService>(
      () => _i56.FiltersService(get<_i55.FiltersManager>()));
  gh.factory<_i57.FireNotificationService>(() => _i57.FireNotificationService(
      get<_i9.NotificationsPrefsHelper>(), get<_i30.NotificationRepo>()));
  gh.factory<_i58.HomeManager>(
      () => _i58.HomeManager(get<_i25.HomeRepository>()));
  gh.factory<_i59.HomeService>(() => _i59.HomeService(get<_i58.HomeManager>()));
  gh.factory<_i60.HomeStateManager>(
      () => _i60.HomeStateManager(get<_i59.HomeService>()));
  gh.factory<_i61.InActiveCaptainsStateManager>(
      () => _i61.InActiveCaptainsStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i62.LoginScreen>(
      () => _i62.LoginScreen(get<_i27.LoginStateManager>()));
  gh.factory<_i63.LogsManager>(
      () => _i63.LogsManager(get<_i28.LogsRepository>()));
  gh.factory<_i64.LogsService>(() => _i64.LogsService(get<_i63.LogsManager>()));
  gh.factory<_i65.MyOrdersManager>(
      () => _i65.MyOrdersManager(get<_i29.MyOrdersRepository>()));
  gh.factory<_i66.OrdersAccountStateManager>(
      () => _i66.OrdersAccountStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i67.OrdersService>(
      () => _i67.OrdersService(get<_i65.MyOrdersManager>()));
  gh.factory<_i68.PaymentsManager>(
      () => _i68.PaymentsManager(get<_i31.PaymentsRepository>()));
  gh.factory<_i69.PaymentsService>(
      () => _i69.PaymentsService(get<_i68.PaymentsManager>()));
  gh.factory<_i70.PaymentsToCaptainStateManager>(() =>
      _i70.PaymentsToCaptainStateManager(
          get<_i42.CaptainsService>(), get<_i69.PaymentsService>()));
  gh.factory<_i71.PortalsManager>(
      () => _i71.PortalsManager(get<_i32.PortalsRepository>()));
  gh.factory<_i72.PortalsService>(
      () => _i72.PortalsService(get<_i71.PortalsManager>()));
  gh.factory<_i73.PortalsStateManager>(
      () => _i73.PortalsStateManager(get<_i72.PortalsService>()));
  gh.factory<_i74.ProductsCategoryStateManager>(() =>
      _i74.ProductsCategoryStateManager(
          get<_i45.CategoriesService>(),
          get<_i18.AuthService>(),
          get<_i26.ImageUploadService>(),
          get<_i7.LocalizationService>()));
  gh.factory<_i75.ProductsReportStateManager>(
      () => _i75.ProductsReportStateManager(get<_i36.ReportsService>()));
  gh.factory<_i76.RegisterScreen>(
      () => _i76.RegisterScreen(get<_i33.RegisterStateManager>()));
  gh.factory<_i77.SettingsScreen>(() => _i77.SettingsScreen(
      get<_i18.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i13.AppThemeDataService>(),
      get<_i57.FireNotificationService>()));
  gh.factory<_i78.SplashModule>(
      () => _i78.SplashModule(get<_i37.SplashScreen>()));
  gh.factory<_i79.StoreCategoriesStateManager>(() =>
      _i79.StoreCategoriesStateManager(get<_i45.CategoriesService>(),
          get<_i18.AuthService>(), get<_i26.ImageUploadService>()));
  gh.factory<_i80.StoreLogsStateManager>(
      () => _i80.StoreLogsStateManager(get<_i64.LogsService>()));
  gh.factory<_i81.StoreManager>(
      () => _i81.StoreManager(get<_i39.StoresRepository>()));
  gh.factory<_i82.StoreProductsStateManager>(() =>
      _i82.StoreProductsStateManager(get<_i45.CategoriesService>(),
          get<_i18.AuthService>(), get<_i26.ImageUploadService>()));
  gh.factory<_i83.StoresFilterStateManager>(
      () => _i83.StoresFilterStateManager(get<_i56.FiltersService>()));
  gh.factory<_i84.StoresReportScreen>(
      () => _i84.StoresReportScreen(get<_i38.StoresReportStateManager>()));
  gh.factory<_i85.StoresService>(
      () => _i85.StoresService(get<_i81.StoreManager>()));
  gh.factory<_i86.StoresStateManager>(() => _i86.StoresStateManager(
      get<_i85.StoresService>(),
      get<_i18.AuthService>(),
      get<_i26.ImageUploadService>(),
      get<_i45.CategoriesService>()));
  gh.factory<_i87.SubCategoriesStateManager>(() =>
      _i87.SubCategoriesStateManager(
          get<_i85.StoresService>(),
          get<_i18.AuthService>(),
          get<_i26.ImageUploadService>(),
          get<_i45.CategoriesService>()));
  gh.factory<_i88.AuthorizationModule>(() => _i88.AuthorizationModule(
      get<_i62.LoginScreen>(), get<_i76.RegisterScreen>()));
  gh.factory<_i89.CaptainBalanceStateManager>(
      () => _i89.CaptainBalanceStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i90.CaptainFilterStateManager>(
      () => _i90.CaptainFilterStateManager(get<_i56.FiltersService>()));
  gh.factory<_i91.CaptainLogsStateManager>(
      () => _i91.CaptainLogsStateManager(get<_i64.LogsService>()));
  gh.factory<_i92.CaptainProfileStateManager>(
      () => _i92.CaptainProfileStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i93.CaptainsPaymentsStateManager>(
      () => _i93.CaptainsPaymentsStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i94.CaptainsReportScreen>(
      () => _i94.CaptainsReportScreen(get<_i41.CaptainsReportStateManager>()));
  gh.factory<_i95.CaptainsScreen>(
      () => _i95.CaptainsScreen(get<_i43.CaptainsStateManager>()));
  gh.factory<_i96.ChatPage>(() => _i96.ChatPage(
      get<_i48.ChatStateManager>(),
      get<_i26.ImageUploadService>(),
      get<_i18.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i97.ClientProfileStateManager>(
      () => _i97.ClientProfileStateManager(get<_i51.ClientsService>()));
  gh.factory<_i98.ClientsReportScreen>(
      () => _i98.ClientsReportScreen(get<_i50.ClientsReportStateManager>()));
  gh.factory<_i99.ClientsScreen>(
      () => _i99.ClientsScreen(get<_i52.ClientsStateManager>()));
  gh.factory<_i100.CompanyFinanceStateManager>(() =>
      _i100.CompanyFinanceStateManager(
          get<_i18.AuthService>(), get<_i54.CompanyService>()));
  gh.factory<_i101.CompanyProfileStateManager>(() =>
      _i101.CompanyProfileStateManager(
          get<_i18.AuthService>(), get<_i54.CompanyService>()));
  gh.factory<_i102.HomeScreen>(
      () => _i102.HomeScreen(get<_i60.HomeStateManager>()));
  gh.factory<_i103.InActiveCaptainsScreen>(() =>
      _i103.InActiveCaptainsScreen(get<_i61.InActiveCaptainsStateManager>()));
  gh.factory<_i104.LevelTowCategoriesScreen>(() =>
      _i104.LevelTowCategoriesScreen(get<_i74.ProductsCategoryStateManager>(),
          get<_i7.LocalizationService>()));
  gh.factory<_i105.MainScreen>(() => _i105.MainScreen(get<_i102.HomeScreen>()));
  gh.factory<_i106.MyOrdersStateManager>(() => _i106.MyOrdersStateManager(
      get<_i67.OrdersService>(), get<_i18.AuthService>()));
  gh.factory<_i107.OnGoingOrdersStateManager>(() =>
      _i107.OnGoingOrdersStateManager(
          get<_i67.OrdersService>(), get<_i18.AuthService>()));
  gh.factory<_i108.OrderDetailsStateManager>(
      () => _i108.OrderDetailsStateManager(get<_i67.OrdersService>()));
  gh.factory<_i109.OrderTimeLineStateManager>(
      () => _i109.OrderTimeLineStateManager(get<_i67.OrdersService>()));
  gh.factory<_i110.OrderWithoutPendingStateManager>(() =>
      _i110.OrderWithoutPendingStateManager(
          get<_i67.OrdersService>(), get<_i18.AuthService>()));
  gh.factory<_i111.OrdersAccountScreen>(
      () => _i111.OrdersAccountScreen(get<_i66.OrdersAccountStateManager>()));
  gh.factory<_i112.OrdersScreen>(
      () => _i112.OrdersScreen(get<_i106.MyOrdersStateManager>()));
  gh.factory<_i113.OrdersWithoutPendingScreen>(() =>
      _i113.OrdersWithoutPendingScreen(
          get<_i110.OrderWithoutPendingStateManager>()));
  gh.factory<_i114.PaymentsFromCaptainStateManager>(() =>
      _i114.PaymentsFromCaptainStateManager(
          get<_i42.CaptainsService>(), get<_i69.PaymentsService>()));
  gh.factory<_i115.PaymentsToCaptainScreen>(() =>
      _i115.PaymentsToCaptainScreen(get<_i70.PaymentsToCaptainStateManager>()));
  gh.factory<_i116.PortalScreen>(
      () => _i116.PortalScreen(get<_i73.PortalsStateManager>()));
  gh.factory<_i117.PortalsModule>(
      () => _i117.PortalsModule(get<_i116.PortalScreen>()));
  gh.factory<_i118.ProductsReportScreen>(
      () => _i118.ProductsReportScreen(get<_i75.ProductsReportStateManager>()));
  gh.factory<_i119.ReportsModule>(() => _i119.ReportsModule(
      get<_i118.ProductsReportScreen>(),
      get<_i84.StoresReportScreen>(),
      get<_i94.CaptainsReportScreen>(),
      get<_i98.ClientsReportScreen>()));
  gh.factory<_i120.SettingsModule>(() => _i120.SettingsModule(
      get<_i77.SettingsScreen>(), get<_i15.ChooseLocalScreen>()));
  gh.factory<_i121.StoreCategoriesScreen>(() => _i121.StoreCategoriesScreen(
      get<_i79.StoreCategoriesStateManager>(), get<_i7.LocalizationService>()));
  gh.factory<_i122.StoreLogsScreen>(
      () => _i122.StoreLogsScreen(get<_i80.StoreLogsStateManager>()));
  gh.factory<_i123.StoreProductScreen>(
      () => _i123.StoreProductScreen(get<_i82.StoreProductsStateManager>()));
  gh.factory<_i124.StoreProfileStateManager>(
      () => _i124.StoreProfileStateManager(get<_i85.StoresService>()));
  gh.factory<_i125.StoresFilterScreen>(
      () => _i125.StoresFilterScreen(get<_i83.StoresFilterStateManager>()));
  gh.factory<_i126.StoresInActiveStateManager>(() =>
      _i126.StoresInActiveStateManager(
          get<_i85.StoresService>(),
          get<_i18.AuthService>(),
          get<_i26.ImageUploadService>(),
          get<_i45.CategoriesService>()));
  gh.factory<_i127.StoresScreen>(
      () => _i127.StoresScreen(get<_i86.StoresStateManager>()));
  gh.factory<_i128.SubCategoriesScreen>(() => _i128.SubCategoriesScreen(
      get<_i87.SubCategoriesStateManager>(), get<_i7.LocalizationService>()));
  gh.factory<_i129.CaptainBalanceScreen>(
      () => _i129.CaptainBalanceScreen(get<_i89.CaptainBalanceStateManager>()));
  gh.factory<_i130.CaptainFilterScreen>(
      () => _i130.CaptainFilterScreen(get<_i90.CaptainFilterStateManager>()));
  gh.factory<_i131.CaptainLogsScreen>(
      () => _i131.CaptainLogsScreen(get<_i91.CaptainLogsStateManager>()));
  gh.factory<_i132.CaptainProfileScreen>(
      () => _i132.CaptainProfileScreen(get<_i92.CaptainProfileStateManager>()));
  gh.factory<_i133.CaptainsPaymentsScreen>(() =>
      _i133.CaptainsPaymentsScreen(get<_i93.CaptainsPaymentsStateManager>()));
  gh.factory<_i134.CategoriesModule>(() => _i134.CategoriesModule(
      get<_i121.StoreCategoriesScreen>(),
      get<_i104.LevelTowCategoriesScreen>(),
      get<_i123.StoreProductScreen>(),
      get<_i128.SubCategoriesScreen>()));
  gh.factory<_i135.ChatModule>(
      () => _i135.ChatModule(get<_i96.ChatPage>(), get<_i18.AuthService>()));
  gh.factory<_i136.ClientProfileScreen>(
      () => _i136.ClientProfileScreen(get<_i97.ClientProfileStateManager>()));
  gh.factory<_i137.ClientsModule>(() => _i137.ClientsModule(
      get<_i136.ClientProfileScreen>(), get<_i99.ClientsScreen>()));
  gh.factory<_i138.CompanyFinanceScreen>(() =>
      _i138.CompanyFinanceScreen(get<_i100.CompanyFinanceStateManager>()));
  gh.factory<_i139.CompanyProfileScreen>(() =>
      _i139.CompanyProfileScreen(get<_i101.CompanyProfileStateManager>()));
  gh.factory<_i140.FiltersModule>(() => _i140.FiltersModule(
      get<_i130.CaptainFilterScreen>(), get<_i125.StoresFilterScreen>()));
  gh.factory<_i141.LogsModule>(() => _i141.LogsModule(
      get<_i131.CaptainLogsScreen>(), get<_i122.StoreLogsScreen>()));
  gh.factory<_i142.MainModule>(
      () => _i142.MainModule(get<_i105.MainScreen>(), get<_i102.HomeScreen>()));
  gh.factory<_i143.OnGoingOrdersScreen>(
      () => _i143.OnGoingOrdersScreen(get<_i107.OnGoingOrdersStateManager>()));
  gh.factory<_i144.OrderDetailsScreen>(
      () => _i144.OrderDetailsScreen(get<_i108.OrderDetailsStateManager>()));
  gh.factory<_i145.OrderTimLineScreen>(
      () => _i145.OrderTimLineScreen(get<_i109.OrderTimeLineStateManager>()));
  gh.factory<_i146.OrdersModule>(() => _i146.OrdersModule(
      get<_i112.OrdersScreen>(),
      get<_i144.OrderDetailsScreen>(),
      get<_i143.OnGoingOrdersScreen>(),
      get<_i145.OrderTimLineScreen>(),
      get<_i113.OrdersWithoutPendingScreen>(),
      get<_i111.OrdersAccountScreen>()));
  gh.factory<_i147.PaymentsFromCaptainScreen>(() =>
      _i147.PaymentsFromCaptainScreen(
          get<_i114.PaymentsFromCaptainStateManager>()));
  gh.factory<_i148.PaymentsModule>(() => _i148.PaymentsModule(
      get<_i147.PaymentsFromCaptainScreen>(),
      get<_i115.PaymentsToCaptainScreen>()));
  gh.factory<_i149.StoreInfoScreen>(
      () => _i149.StoreInfoScreen(get<_i124.StoreProfileStateManager>()));
  gh.factory<_i150.StoresInActiveScreen>(() =>
      _i150.StoresInActiveScreen(get<_i126.StoresInActiveStateManager>()));
  gh.factory<_i151.StoresModule>(() => _i151.StoresModule(
      get<_i127.StoresScreen>(),
      get<_i149.StoreInfoScreen>(),
      get<_i150.StoresInActiveScreen>()));
  gh.factory<_i152.CaptainsModule>(() => _i152.CaptainsModule(
      get<_i103.InActiveCaptainsScreen>(),
      get<_i132.CaptainProfileScreen>(),
      get<_i129.CaptainBalanceScreen>(),
      get<_i133.CaptainsPaymentsScreen>(),
      get<_i95.CaptainsScreen>()));
  gh.factory<_i153.CompanyModule>(() => _i153.CompanyModule(
      get<_i139.CompanyProfileScreen>(), get<_i138.CompanyFinanceScreen>()));
  gh.factory<_i154.MyApp>(() => _i154.MyApp(
      get<_i13.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i57.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i78.SplashModule>(),
      get<_i88.AuthorizationModule>(),
      get<_i135.ChatModule>(),
      get<_i120.SettingsModule>(),
      get<_i142.MainModule>(),
      get<_i134.CategoriesModule>(),
      get<_i151.StoresModule>(),
      get<_i152.CaptainsModule>(),
      get<_i153.CompanyModule>(),
      get<_i146.OrdersModule>(),
      get<_i148.PaymentsModule>(),
      get<_i140.FiltersModule>(),
      get<_i141.LogsModule>(),
      get<_i117.PortalsModule>()));
  gh.singleton<_i155.GlobalStateManager>(_i155.GlobalStateManager(
      get<_i61.InActiveCaptainsStateManager>(),
      get<_i43.CaptainsStateManager>()));
  return get;
}
