// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i164;
import '../module_auth/authoriazation_module.dart' as _i86;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i17;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i14;
import '../module_auth/service/auth_service/auth_service.dart' as _i18;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i28;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i33;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i63;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i74;
import '../module_captain/captains_module.dart' as _i161;
import '../module_captain/manager/captains_manager.dart' as _i40;
import '../module_captain/repository/captain_repository.dart' as _i19;
import '../module_captain/service/captains_service.dart' as _i42;
import '../module_captain/state_manager/captain_balance_state_manager.dart'
    as _i88;
import '../module_captain/state_manager/captain_captains_payment_list_state_manager.dart'
    as _i93;
import '../module_captain/state_manager/captain_list.dart' as _i43;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i92;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i62;
import '../module_captain/ui/screen/captain_balance_screen.dart' as _i132;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i136;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i96;
import '../module_captain/ui/screen/catpains_payment_screen.dart' as _i138;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i106;
import '../module_categories/categories_module.dart' as _i140;
import '../module_categories/manager/categories_manager.dart' as _i44;
import '../module_categories/repository/categories_repository.dart' as _i20;
import '../module_categories/service/store_categories_service.dart' as _i45;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i72;
import '../module_categories/state_manager/store_categories_state_manager.dart'
    as _i77;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i80;
import '../module_categories/state_manager/sub_categories_state_manager.dart'
    as _i85;
import '../module_categories/ui/screen/level_tow_categories_screen.dart'
    as _i108;
import '../module_categories/ui/screen/store_categories_screen.dart' as _i124;
import '../module_categories/ui/screen/store_products_screen.dart' as _i126;
import '../module_categories/ui/screen/sub_categories_screen.dart' as _i131;
import '../module_chat/chat_module.dart' as _i141;
import '../module_chat/manager/chat/chat_manager.dart' as _i46;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i21;
import '../module_chat/service/chat/char_service.dart' as _i47;
import '../module_chat/state_manager/chat_state_manager.dart' as _i48;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i97;
import '../module_clients/clients_module.dart' as _i143;
import '../module_clients/manager/clients_manager.dart' as _i49;
import '../module_clients/repository/clients_repository.dart' as _i22;
import '../module_clients/service/clients_service.dart' as _i51;
import '../module_clients/state_manager/captain_list.dart' as _i52;
import '../module_clients/state_manager/captain_profile_state_manager.dart'
    as _i98;
import '../module_clients/ui/screen/clients_list_screen.dart' as _i100;
import '../module_clients/ui/screen/clients_profile_screen.dart' as _i142;
import '../module_company/company_module.dart' as _i162;
import '../module_company/manager/company_manager.dart' as _i53;
import '../module_company/repository/company_repository.dart' as _i23;
import '../module_company/service/company_service.dart' as _i54;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i101;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i102;
import '../module_company/ui/screen/company_finance_screen.dart' as _i144;
import '../module_company/ui/screen/company_profile_screen.dart' as _i145;
import '../module_distributor/distros_module.dart' as _i163;
import '../module_distributor/manager/distributors_manager.dart' as _i55;
import '../module_distributor/repository/distributor_repository.dart' as _i24;
import '../module_distributor/service/distributer_service.dart' as _i103;
import '../module_distributor/state_manager/captain_balance_state_manager.dart'
    as _i87;
import '../module_distributor/state_manager/captain_captains_payment_list_state_manager.dart'
    as _i94;
import '../module_distributor/state_manager/captain_profile_state_manager.dart'
    as _i91;
import '../module_distributor/state_manager/distros_list.dart' as _i104;
import '../module_distributor/state_manager/in_active_distro_state_manager.dart'
    as _i107;
import '../module_distributor/ui/screen/captain_balance_screen.dart' as _i133;
import '../module_distributor/ui/screen/captain_profile_screen.dart' as _i137;
import '../module_distributor/ui/screen/catpains_payment_screen.dart' as _i139;
import '../module_distributor/ui/screen/distors_list_screen.dart' as _i146;
import '../module_distributor/ui/screen/in_active_distros_screen.dart' as _i148;
import '../module_filters/filters_module.dart' as _i147;
import '../module_filters/manager/filters_manager.dart' as _i56;
import '../module_filters/repository/filters_repository.dart' as _i25;
import '../module_filters/service/filters_service.dart' as _i57;
import '../module_filters/state_manager/captain_filter_state_manager.dart'
    as _i89;
import '../module_filters/state_manager/store_filter_state_manager.dart'
    as _i81;
import '../module_filters/ui/screen/captain_filter_screen.dart' as _i134;
import '../module_filters/ui/screen/store_filter_screen.dart' as _i128;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_logs/logs_module.dart' as _i149;
import '../module_logs/manager/logs_manager.dart' as _i64;
import '../module_logs/repository/logs_repository.dart' as _i29;
import '../module_logs/service/logs_service.dart' as _i65;
import '../module_logs/state_manager/captain_logs_state_manager.dart' as _i90;
import '../module_logs/state_manager/store_logs_state_manager.dart' as _i78;
import '../module_logs/ui/screen/captain_logs_screen.dart' as _i135;
import '../module_logs/ui/screen/store_logs_screen.dart' as _i125;
import '../module_main/main_module.dart' as _i150;
import '../module_main/manager/home_manager.dart' as _i59;
import '../module_main/repository/home_repository.dart' as _i26;
import '../module_main/sceen/home_screen.dart' as _i105;
import '../module_main/sceen/main_screen.dart' as _i109;
import '../module_main/service/home_service.dart' as _i60;
import '../module_main/state_manager/home_state_manager.dart' as _i61;
import '../module_network/http_client/http_client.dart' as _i12;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i9;
import '../module_notifications/repository/notification_repo.dart' as _i31;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i58;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_orders/manager/my_orders_manager.dart' as _i66;
import '../module_orders/orders_module.dart' as _i154;
import '../module_orders/repository/orders_repository.dart' as _i30;
import '../module_orders/service/orders_service.dart' as _i68;
import '../module_orders/state_manager/captains_from_state_manager.dart'
    as _i67;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i110;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i111;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i112;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i113;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i114;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i116;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i151;
import '../module_orders/ui/screen/order_accounts_screen.dart' as _i115;
import '../module_orders/ui/screen/order_details_screen.dart' as _i152;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i153;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i117;
import '../module_payments/manager/payments_manager.dart' as _i69;
import '../module_payments/payments_module.dart' as _i156;
import '../module_payments/repository/payments_repository.dart' as _i32;
import '../module_payments/service/payments_service.dart' as _i70;
import '../module_payments/state_manager/payments_from_state_manager.dart'
    as _i118;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i71;
import '../module_payments/ui/screen/paymen_from_captain_screen.dart' as _i155;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i119;
import '../module_reports/manager/reports_manager.dart' as _i35;
import '../module_reports/report_module.dart' as _i121;
import '../module_reports/repository/reports_repository.dart' as _i34;
import '../module_reports/service/reports_service.dart' as _i36;
import '../module_reports/state_manager/captains_report_state_manager.dart'
    as _i41;
import '../module_reports/state_manager/clients_report_state_manager.dart'
    as _i50;
import '../module_reports/state_manager/products_report_state_manager.dart'
    as _i73;
import '../module_reports/state_manager/stores_report_state_manager.dart'
    as _i38;
import '../module_reports/ui/screen/captains_reports_screen.dart' as _i95;
import '../module_reports/ui/screen/clients_reports_screen.dart' as _i99;
import '../module_reports/ui/screen/products_reports_screen.dart' as _i120;
import '../module_reports/ui/screen/stores_reports_screen.dart' as _i82;
import '../module_settings/settings_module.dart' as _i122;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i15;
import '../module_settings/ui/settings_page/settings_page.dart' as _i75;
import '../module_splash/splash_module.dart' as _i76;
import '../module_splash/ui/screen/splash_screen.dart' as _i37;
import '../module_stores/manager/stores_manager.dart' as _i79;
import '../module_stores/repository/stores_repository.dart' as _i39;
import '../module_stores/service/store_service.dart' as _i83;
import '../module_stores/state_manager/store_balance_state_manager.dart'
    as _i123;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i127;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i129;
import '../module_stores/state_manager/stores_state_manager.dart' as _i84;
import '../module_stores/stores_module.dart' as _i160;
import '../module_stores/ui/screen/store_balance_screen.dart' as _i157;
import '../module_stores/ui/screen/store_info_screen.dart' as _i158;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i159;
import '../module_stores/ui/screen/stores_screen.dart' as _i130;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i10;
import '../module_theme/service/theme_service/theme_service.dart' as _i13;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i16;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i11;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i27;
import '../utils/global/global_state_manager.dart' as _i165;
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
  gh.factory<_i24.DistributorRepository>(() => _i24.DistributorRepository(
      get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i25.FiltersRepository>(() =>
      _i25.FiltersRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i26.HomeRepository>(() =>
      _i26.HomeRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i27.ImageUploadService>(
      () => _i27.ImageUploadService(get<_i16.UploadManager>()));
  gh.factory<_i28.LoginStateManager>(
      () => _i28.LoginStateManager(get<_i18.AuthService>()));
  gh.factory<_i29.LogsRepository>(() =>
      _i29.LogsRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i30.MyOrdersRepository>(() =>
      _i30.MyOrdersRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i31.NotificationRepo>(() =>
      _i31.NotificationRepo(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i32.PaymentsRepository>(() =>
      _i32.PaymentsRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
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
  gh.factory<_i55.DistributorManager>(
      () => _i55.DistributorManager(get<_i24.DistributorRepository>()));
  gh.factory<_i56.FiltersManager>(
      () => _i56.FiltersManager(get<_i25.FiltersRepository>()));
  gh.factory<_i57.FiltersService>(
      () => _i57.FiltersService(get<_i56.FiltersManager>()));
  gh.factory<_i58.FireNotificationService>(() => _i58.FireNotificationService(
      get<_i9.NotificationsPrefsHelper>(), get<_i31.NotificationRepo>()));
  gh.factory<_i59.HomeManager>(
      () => _i59.HomeManager(get<_i26.HomeRepository>()));
  gh.factory<_i60.HomeService>(() => _i60.HomeService(get<_i59.HomeManager>()));
  gh.factory<_i61.HomeStateManager>(
      () => _i61.HomeStateManager(get<_i60.HomeService>()));
  gh.factory<_i62.InActiveCaptainsStateManager>(
      () => _i62.InActiveCaptainsStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i63.LoginScreen>(
      () => _i63.LoginScreen(get<_i28.LoginStateManager>()));
  gh.factory<_i64.LogsManager>(
      () => _i64.LogsManager(get<_i29.LogsRepository>()));
  gh.factory<_i65.LogsService>(() => _i65.LogsService(get<_i64.LogsManager>()));
  gh.factory<_i66.MyOrdersManager>(
      () => _i66.MyOrdersManager(get<_i30.MyOrdersRepository>()));
  gh.factory<_i67.OrdersAccountStateManager>(
      () => _i67.OrdersAccountStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i68.OrdersService>(
      () => _i68.OrdersService(get<_i66.MyOrdersManager>()));
  gh.factory<_i69.PaymentsManager>(
      () => _i69.PaymentsManager(get<_i32.PaymentsRepository>()));
  gh.factory<_i70.PaymentsService>(
      () => _i70.PaymentsService(get<_i69.PaymentsManager>()));
  gh.factory<_i71.PaymentsToCaptainStateManager>(() =>
      _i71.PaymentsToCaptainStateManager(
          get<_i42.CaptainsService>(), get<_i70.PaymentsService>()));
  gh.factory<_i72.ProductsCategoryStateManager>(() =>
      _i72.ProductsCategoryStateManager(
          get<_i45.CategoriesService>(),
          get<_i18.AuthService>(),
          get<_i27.ImageUploadService>(),
          get<_i7.LocalizationService>()));
  gh.factory<_i73.ProductsReportStateManager>(
      () => _i73.ProductsReportStateManager(get<_i36.ReportsService>()));
  gh.factory<_i74.RegisterScreen>(
      () => _i74.RegisterScreen(get<_i33.RegisterStateManager>()));
  gh.factory<_i75.SettingsScreen>(() => _i75.SettingsScreen(
      get<_i18.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i13.AppThemeDataService>(),
      get<_i58.FireNotificationService>()));
  gh.factory<_i76.SplashModule>(
      () => _i76.SplashModule(get<_i37.SplashScreen>()));
  gh.factory<_i77.StoreCategoriesStateManager>(() =>
      _i77.StoreCategoriesStateManager(get<_i45.CategoriesService>(),
          get<_i18.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i78.StoreLogsStateManager>(
      () => _i78.StoreLogsStateManager(get<_i65.LogsService>()));
  gh.factory<_i79.StoreManager>(
      () => _i79.StoreManager(get<_i39.StoresRepository>()));
  gh.factory<_i80.StoreProductsStateManager>(() =>
      _i80.StoreProductsStateManager(get<_i45.CategoriesService>(),
          get<_i18.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i81.StoresFilterStateManager>(
      () => _i81.StoresFilterStateManager(get<_i57.FiltersService>()));
  gh.factory<_i82.StoresReportScreen>(
      () => _i82.StoresReportScreen(get<_i38.StoresReportStateManager>()));
  gh.factory<_i83.StoresService>(
      () => _i83.StoresService(get<_i79.StoreManager>()));
  gh.factory<_i84.StoresStateManager>(() => _i84.StoresStateManager(
      get<_i83.StoresService>(),
      get<_i18.AuthService>(),
      get<_i27.ImageUploadService>(),
      get<_i45.CategoriesService>()));
  gh.factory<_i85.SubCategoriesStateManager>(() =>
      _i85.SubCategoriesStateManager(
          get<_i83.StoresService>(),
          get<_i18.AuthService>(),
          get<_i27.ImageUploadService>(),
          get<_i45.CategoriesService>()));
  gh.factory<_i86.AuthorizationModule>(() => _i86.AuthorizationModule(
      get<_i63.LoginScreen>(), get<_i74.RegisterScreen>()));
  gh.factory<_i87.CaptainBalanceStateManager>(
      () => _i87.CaptainBalanceStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i88.CaptainBalanceStateManager>(
      () => _i88.CaptainBalanceStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i89.CaptainFilterStateManager>(
      () => _i89.CaptainFilterStateManager(get<_i57.FiltersService>()));
  gh.factory<_i90.CaptainLogsStateManager>(
      () => _i90.CaptainLogsStateManager(get<_i65.LogsService>()));
  gh.factory<_i91.CaptainProfileStateManager>(
      () => _i91.CaptainProfileStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i92.CaptainProfileStateManager>(
      () => _i92.CaptainProfileStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i93.CaptainsPaymentsStateManager>(
      () => _i93.CaptainsPaymentsStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i94.CaptainsPaymentsStateManager>(
      () => _i94.CaptainsPaymentsStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i95.CaptainsReportScreen>(
      () => _i95.CaptainsReportScreen(get<_i41.CaptainsReportStateManager>()));
  gh.factory<_i96.CaptainsScreen>(
      () => _i96.CaptainsScreen(get<_i43.CaptainsStateManager>()));
  gh.factory<_i97.ChatPage>(() => _i97.ChatPage(
      get<_i48.ChatStateManager>(),
      get<_i27.ImageUploadService>(),
      get<_i18.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i98.ClientProfileStateManager>(
      () => _i98.ClientProfileStateManager(get<_i51.ClientsService>()));
  gh.factory<_i99.ClientsReportScreen>(
      () => _i99.ClientsReportScreen(get<_i50.ClientsReportStateManager>()));
  gh.factory<_i100.ClientsScreen>(
      () => _i100.ClientsScreen(get<_i52.ClientsStateManager>()));
  gh.factory<_i101.CompanyFinanceStateManager>(() =>
      _i101.CompanyFinanceStateManager(
          get<_i18.AuthService>(), get<_i54.CompanyService>()));
  gh.factory<_i102.CompanyProfileStateManager>(() =>
      _i102.CompanyProfileStateManager(
          get<_i18.AuthService>(), get<_i54.CompanyService>()));
  gh.factory<_i103.DistributerService>(
      () => _i103.DistributerService(get<_i55.DistributorManager>()));
  gh.factory<_i104.DistrosStateManager>(
      () => _i104.DistrosStateManager(get<_i103.DistributerService>()));
  gh.factory<_i105.HomeScreen>(
      () => _i105.HomeScreen(get<_i61.HomeStateManager>()));
  gh.factory<_i106.InActiveCaptainsScreen>(() =>
      _i106.InActiveCaptainsScreen(get<_i62.InActiveCaptainsStateManager>()));
  gh.factory<_i107.InActiveDistributorsStateManager>(() =>
      _i107.InActiveDistributorsStateManager(get<_i103.DistributerService>()));
  gh.factory<_i108.LevelTowCategoriesScreen>(() =>
      _i108.LevelTowCategoriesScreen(get<_i72.ProductsCategoryStateManager>(),
          get<_i7.LocalizationService>()));
  gh.factory<_i109.MainScreen>(() => _i109.MainScreen(get<_i105.HomeScreen>()));
  gh.factory<_i110.MyOrdersStateManager>(() => _i110.MyOrdersStateManager(
      get<_i68.OrdersService>(), get<_i18.AuthService>()));
  gh.factory<_i111.OnGoingOrdersStateManager>(() =>
      _i111.OnGoingOrdersStateManager(
          get<_i68.OrdersService>(), get<_i18.AuthService>()));
  gh.factory<_i112.OrderDetailsStateManager>(
      () => _i112.OrderDetailsStateManager(get<_i68.OrdersService>()));
  gh.factory<_i113.OrderTimeLineStateManager>(
      () => _i113.OrderTimeLineStateManager(get<_i68.OrdersService>()));
  gh.factory<_i114.OrderWithoutPendingStateManager>(() =>
      _i114.OrderWithoutPendingStateManager(
          get<_i68.OrdersService>(), get<_i18.AuthService>()));
  gh.factory<_i115.OrdersAccountScreen>(
      () => _i115.OrdersAccountScreen(get<_i67.OrdersAccountStateManager>()));
  gh.factory<_i116.OrdersScreen>(
      () => _i116.OrdersScreen(get<_i110.MyOrdersStateManager>()));
  gh.factory<_i117.OrdersWithoutPendingScreen>(() =>
      _i117.OrdersWithoutPendingScreen(
          get<_i114.OrderWithoutPendingStateManager>()));
  gh.factory<_i118.PaymentsFromCaptainStateManager>(() =>
      _i118.PaymentsFromCaptainStateManager(
          get<_i42.CaptainsService>(), get<_i70.PaymentsService>()));
  gh.factory<_i119.PaymentsToCaptainScreen>(() =>
      _i119.PaymentsToCaptainScreen(get<_i71.PaymentsToCaptainStateManager>()));
  gh.factory<_i120.ProductsReportScreen>(
      () => _i120.ProductsReportScreen(get<_i73.ProductsReportStateManager>()));
  gh.factory<_i121.ReportsModule>(() => _i121.ReportsModule(
      get<_i120.ProductsReportScreen>(),
      get<_i82.StoresReportScreen>(),
      get<_i95.CaptainsReportScreen>(),
      get<_i99.ClientsReportScreen>()));
  gh.factory<_i122.SettingsModule>(() => _i122.SettingsModule(
      get<_i75.SettingsScreen>(), get<_i15.ChooseLocalScreen>()));
  gh.factory<_i123.StoreBalanceStateManager>(
      () => _i123.StoreBalanceStateManager(get<_i83.StoresService>()));
  gh.factory<_i124.StoreCategoriesScreen>(() => _i124.StoreCategoriesScreen(
      get<_i77.StoreCategoriesStateManager>(), get<_i7.LocalizationService>()));
  gh.factory<_i125.StoreLogsScreen>(
      () => _i125.StoreLogsScreen(get<_i78.StoreLogsStateManager>()));
  gh.factory<_i126.StoreProductScreen>(
      () => _i126.StoreProductScreen(get<_i80.StoreProductsStateManager>()));
  gh.factory<_i127.StoreProfileStateManager>(
      () => _i127.StoreProfileStateManager(get<_i83.StoresService>()));
  gh.factory<_i128.StoresFilterScreen>(
      () => _i128.StoresFilterScreen(get<_i81.StoresFilterStateManager>()));
  gh.factory<_i129.StoresInActiveStateManager>(() =>
      _i129.StoresInActiveStateManager(
          get<_i83.StoresService>(),
          get<_i18.AuthService>(),
          get<_i27.ImageUploadService>(),
          get<_i45.CategoriesService>()));
  gh.factory<_i130.StoresScreen>(
      () => _i130.StoresScreen(get<_i84.StoresStateManager>()));
  gh.factory<_i131.SubCategoriesScreen>(() => _i131.SubCategoriesScreen(
      get<_i85.SubCategoriesStateManager>(), get<_i7.LocalizationService>()));
  gh.factory<_i132.CaptainBalanceScreen>(
      () => _i132.CaptainBalanceScreen(get<_i88.CaptainBalanceStateManager>()));
  gh.factory<_i133.CaptainBalanceScreen>(
      () => _i133.CaptainBalanceScreen(get<_i88.CaptainBalanceStateManager>()));
  gh.factory<_i134.CaptainFilterScreen>(
      () => _i134.CaptainFilterScreen(get<_i89.CaptainFilterStateManager>()));
  gh.factory<_i135.CaptainLogsScreen>(
      () => _i135.CaptainLogsScreen(get<_i90.CaptainLogsStateManager>()));
  gh.factory<_i136.CaptainProfileScreen>(
      () => _i136.CaptainProfileScreen(get<_i92.CaptainProfileStateManager>()));
  gh.factory<_i137.CaptainProfileScreen>(
      () => _i137.CaptainProfileScreen(get<_i92.CaptainProfileStateManager>()));
  gh.factory<_i138.CaptainsPaymentsScreen>(() =>
      _i138.CaptainsPaymentsScreen(get<_i93.CaptainsPaymentsStateManager>()));
  gh.factory<_i139.CaptainsPaymentsScreen>(() =>
      _i139.CaptainsPaymentsScreen(get<_i93.CaptainsPaymentsStateManager>()));
  gh.factory<_i140.CategoriesModule>(() => _i140.CategoriesModule(
      get<_i124.StoreCategoriesScreen>(),
      get<_i108.LevelTowCategoriesScreen>(),
      get<_i126.StoreProductScreen>(),
      get<_i131.SubCategoriesScreen>()));
  gh.factory<_i141.ChatModule>(
      () => _i141.ChatModule(get<_i97.ChatPage>(), get<_i18.AuthService>()));
  gh.factory<_i142.ClientProfileScreen>(
      () => _i142.ClientProfileScreen(get<_i98.ClientProfileStateManager>()));
  gh.factory<_i143.ClientsModule>(() => _i143.ClientsModule(
      get<_i142.ClientProfileScreen>(), get<_i100.ClientsScreen>()));
  gh.factory<_i144.CompanyFinanceScreen>(() =>
      _i144.CompanyFinanceScreen(get<_i101.CompanyFinanceStateManager>()));
  gh.factory<_i145.CompanyProfileScreen>(() =>
      _i145.CompanyProfileScreen(get<_i102.CompanyProfileStateManager>()));
  gh.factory<_i146.DistrosScreen>(
      () => _i146.DistrosScreen(get<_i104.DistrosStateManager>()));
  gh.factory<_i147.FiltersModule>(() => _i147.FiltersModule(
      get<_i134.CaptainFilterScreen>(), get<_i128.StoresFilterScreen>()));
  gh.factory<_i148.InActiveDistributorsScreen>(() =>
      _i148.InActiveDistributorsScreen(
          get<_i107.InActiveDistributorsStateManager>()));
  gh.factory<_i149.LogsModule>(() => _i149.LogsModule(
      get<_i135.CaptainLogsScreen>(), get<_i125.StoreLogsScreen>()));
  gh.factory<_i150.MainModule>(
      () => _i150.MainModule(get<_i109.MainScreen>(), get<_i105.HomeScreen>()));
  gh.factory<_i151.OnGoingOrdersScreen>(
      () => _i151.OnGoingOrdersScreen(get<_i111.OnGoingOrdersStateManager>()));
  gh.factory<_i152.OrderDetailsScreen>(
      () => _i152.OrderDetailsScreen(get<_i112.OrderDetailsStateManager>()));
  gh.factory<_i153.OrderTimLineScreen>(
      () => _i153.OrderTimLineScreen(get<_i113.OrderTimeLineStateManager>()));
  gh.factory<_i154.OrdersModule>(() => _i154.OrdersModule(
      get<_i116.OrdersScreen>(),
      get<_i152.OrderDetailsScreen>(),
      get<_i151.OnGoingOrdersScreen>(),
      get<_i153.OrderTimLineScreen>(),
      get<_i117.OrdersWithoutPendingScreen>(),
      get<_i115.OrdersAccountScreen>()));
  gh.factory<_i155.PaymentsFromCaptainScreen>(() =>
      _i155.PaymentsFromCaptainScreen(
          get<_i118.PaymentsFromCaptainStateManager>()));
  gh.factory<_i156.PaymentsModule>(() => _i156.PaymentsModule(
      get<_i155.PaymentsFromCaptainScreen>(),
      get<_i119.PaymentsToCaptainScreen>()));
  gh.factory<_i157.StoreBalanceScreen>(
      () => _i157.StoreBalanceScreen(get<_i123.StoreBalanceStateManager>()));
  gh.factory<_i158.StoreInfoScreen>(
      () => _i158.StoreInfoScreen(get<_i127.StoreProfileStateManager>()));
  gh.factory<_i159.StoresInActiveScreen>(() =>
      _i159.StoresInActiveScreen(get<_i129.StoresInActiveStateManager>()));
  gh.factory<_i160.StoresModule>(() => _i160.StoresModule(
      get<_i130.StoresScreen>(),
      get<_i158.StoreInfoScreen>(),
      get<_i159.StoresInActiveScreen>(),
      get<_i157.StoreBalanceScreen>()));
  gh.factory<_i161.CaptainsModule>(() => _i161.CaptainsModule(
      get<_i106.InActiveCaptainsScreen>(),
      get<_i136.CaptainProfileScreen>(),
      get<_i132.CaptainBalanceScreen>(),
      get<_i138.CaptainsPaymentsScreen>(),
      get<_i96.CaptainsScreen>()));
  gh.factory<_i162.CompanyModule>(() => _i162.CompanyModule(
      get<_i145.CompanyProfileScreen>(), get<_i144.CompanyFinanceScreen>()));
  gh.factory<_i163.DistributorsModule>(() => _i163.DistributorsModule(
      get<_i146.DistrosScreen>(),
      get<_i136.CaptainProfileScreen>(),
      get<_i132.CaptainBalanceScreen>(),
      get<_i138.CaptainsPaymentsScreen>(),
      get<_i148.InActiveDistributorsScreen>()));
  gh.factory<_i164.MyApp>(() => _i164.MyApp(
      get<_i13.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i58.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i76.SplashModule>(),
      get<_i86.AuthorizationModule>(),
      get<_i141.ChatModule>(),
      get<_i122.SettingsModule>(),
      get<_i150.MainModule>(),
      get<_i140.CategoriesModule>(),
      get<_i160.StoresModule>(),
      get<_i161.CaptainsModule>(),
      get<_i162.CompanyModule>(),
      get<_i154.OrdersModule>(),
      get<_i156.PaymentsModule>(),
      get<_i147.FiltersModule>(),
      get<_i149.LogsModule>()));
  gh.singleton<_i165.GlobalStateManager>(_i165.GlobalStateManager(
      get<_i62.InActiveCaptainsStateManager>(),
      get<_i43.CaptainsStateManager>()));
  return get;
}
