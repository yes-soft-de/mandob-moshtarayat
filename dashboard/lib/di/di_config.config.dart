// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i186;
import '../module_auth/authoriazation_module.dart' as _i99;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i17;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i14;
import '../module_auth/service/auth_service/auth_service.dart' as _i18;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i29;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i34;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i67;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i78;
import '../module_captain/captains_module.dart' as _i182;
import '../module_captain/manager/captains_manager.dart' as _i41;
import '../module_captain/repository/captain_repository.dart' as _i19;
import '../module_captain/service/captains_service.dart' as _i43;
import '../module_captain/state_manager/captain_balance_state_manager.dart'
    as _i100;
import '../module_captain/state_manager/captain_captains_payment_list_state_manager.dart'
    as _i106;
import '../module_captain/state_manager/captain_list.dart' as _i44;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i105;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i64;
import '../module_captain/ui/screen/captain_balance_screen.dart' as _i153;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i156;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i109;
import '../module_captain/ui/screen/catpains_payment_screen.dart' as _i158;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i122;
import '../module_categories/categories_module.dart' as _i160;
import '../module_categories/manager/categories_manager.dart' as _i45;
import '../module_categories/repository/categories_repository.dart' as _i20;
import '../module_categories/service/store_categories_service.dart' as _i46;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i76;
import '../module_categories/state_manager/store_categories_state_manager.dart'
    as _i82;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i85;
import '../module_categories/state_manager/sub_categories_state_manager.dart'
    as _i92;
import '../module_categories/state_manager/update_categories_state_manager/update_level_two_category_state_manager.dart'
    as _i93;
import '../module_categories/state_manager/update_categories_state_manager/update_store_category_state_manager.dart'
    as _i95;
import '../module_categories/state_manager/update_categories_state_manager/update_sub_category_state_manager.dart'
    as _i97;
import '../module_categories/ui/screen/level_tow_categories_screen.dart'
    as _i125;
import '../module_categories/ui/screen/store_categories_screen.dart' as _i142;
import '../module_categories/ui/screen/store_products_screen.dart' as _i144;
import '../module_categories/ui/screen/sub_categories_screen.dart' as _i151;
import '../module_categories/ui/screen/update_categories_screen/update_level_two_category_screen.dart'
    as _i94;
import '../module_categories/ui/screen/update_categories_screen/update_store_category_screen.dart'
    as _i96;
import '../module_categories/ui/screen/update_categories_screen/update_sub_category_screen.dart'
    as _i98;
import '../module_categories_linking/linking_module.dart' as _i169;
import '../module_categories_linking/manager/linking_manager.dart' as _i65;
import '../module_categories_linking/repository/linking_repository.dart'
    as _i28;
import '../module_categories_linking/service/linking_service.dart' as _i66;
import '../module_categories_linking/state_manager/categories_level2_state_manager.dart'
    as _i110;
import '../module_categories_linking/state_manager/store_categories_linking_state_manager.dart'
    as _i81;
import '../module_categories_linking/state_manager/sub_categories_linking_state_manager.dart'
    as _i90;
import '../module_categories_linking/state_manager/sub_categories_list_state_manager.dart'
    as _i91;
import '../module_categories_linking/ui/screen/level_tow_categories_list_screen.dart'
    as _i124;
import '../module_categories_linking/ui/screen/store_categories_linking_screen.dart'
    as _i141;
import '../module_categories_linking/ui/screen/sub_categories_linking_screen.dart'
    as _i149;
import '../module_categories_linking/ui/screen/sub_categories_list_screen.dart'
    as _i150;
import '../module_chat/chat_module.dart' as _i161;
import '../module_chat/manager/chat/chat_manager.dart' as _i47;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i21;
import '../module_chat/service/chat/char_service.dart' as _i48;
import '../module_chat/state_manager/chat_state_manager.dart' as _i49;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i111;
import '../module_clients/clients_module.dart' as _i183;
import '../module_clients/manager/clients_manager.dart' as _i50;
import '../module_clients/repository/clients_repository.dart' as _i22;
import '../module_clients/service/clients_service.dart' as _i52;
import '../module_clients/state_manager/client_list.dart' as _i53;
import '../module_clients/state_manager/client_profile_state_manager.dart'
    as _i112;
import '../module_clients/state_manager/clients_need_support_state_manager.dart'
    as _i113;
import '../module_clients/ui/screen/clients_list_screen.dart' as _i115;
import '../module_clients/ui/screen/clients_needs_support_screen.dart' as _i163;
import '../module_clients/ui/screen/clients_profile_screen.dart' as _i162;
import '../module_company/company_module.dart' as _i184;
import '../module_company/manager/company_manager.dart' as _i54;
import '../module_company/repository/company_repository.dart' as _i23;
import '../module_company/service/company_service.dart' as _i55;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i116;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i117;
import '../module_company/ui/screen/company_finance_screen.dart' as _i164;
import '../module_company/ui/screen/company_profile_screen.dart' as _i165;
import '../module_distributor/distros_module.dart' as _i185;
import '../module_distributor/manager/distributors_manager.dart' as _i57;
import '../module_distributor/repository/distributor_repository.dart' as _i24;
import '../module_distributor/service/distributer_service.dart' as _i119;
import '../module_distributor/state_manager/captain_balance_state_manager.dart'
    as _i101;
import '../module_distributor/state_manager/captain_captains_payment_list_state_manager.dart'
    as _i107;
import '../module_distributor/state_manager/captain_profile_state_manager.dart'
    as _i104;
import '../module_distributor/state_manager/distros_list.dart' as _i120;
import '../module_distributor/state_manager/in_active_distro_state_manager.dart'
    as _i123;
import '../module_distributor/ui/screen/captain_balance_screen.dart' as _i152;
import '../module_distributor/ui/screen/captain_profile_screen.dart' as _i157;
import '../module_distributor/ui/screen/catpains_payment_screen.dart' as _i159;
import '../module_distributor/ui/screen/distors_list_screen.dart' as _i166;
import '../module_distributor/ui/screen/in_active_distros_screen.dart' as _i168;
import '../module_filters/filters_module.dart' as _i167;
import '../module_filters/manager/filters_manager.dart' as _i58;
import '../module_filters/repository/filters_repository.dart' as _i25;
import '../module_filters/service/filters_service.dart' as _i59;
import '../module_filters/state_manager/captain_filter_state_manager.dart'
    as _i102;
import '../module_filters/state_manager/store_filter_state_manager.dart'
    as _i86;
import '../module_filters/ui/screen/captain_filter_screen.dart' as _i154;
import '../module_filters/ui/screen/store_filter_screen.dart' as _i146;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i6;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i7;
import '../module_logs/logs_module.dart' as _i170;
import '../module_logs/manager/logs_manager.dart' as _i68;
import '../module_logs/repository/logs_repository.dart' as _i30;
import '../module_logs/service/logs_service.dart' as _i69;
import '../module_logs/state_manager/captain_logs_state_manager.dart' as _i103;
import '../module_logs/state_manager/store_logs_state_manager.dart' as _i83;
import '../module_logs/ui/screen/captain_logs_screen.dart' as _i155;
import '../module_logs/ui/screen/store_logs_screen.dart' as _i143;
import '../module_main/main_module.dart' as _i171;
import '../module_main/manager/home_manager.dart' as _i61;
import '../module_main/repository/home_repository.dart' as _i26;
import '../module_main/sceen/home_screen.dart' as _i121;
import '../module_main/sceen/main_screen.dart' as _i126;
import '../module_main/service/home_service.dart' as _i62;
import '../module_main/state_manager/home_state_manager.dart' as _i63;
import '../module_network/http_client/http_client.dart' as _i12;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i9;
import '../module_notifications/repository/notification_repo.dart' as _i32;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i60;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i5;
import '../module_orders/manager/my_orders_manager.dart' as _i70;
import '../module_orders/orders_module.dart' as _i175;
import '../module_orders/repository/orders_repository.dart' as _i31;
import '../module_orders/service/orders_service.dart' as _i72;
import '../module_orders/state_manager/captains_from_state_manager.dart'
    as _i71;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i127;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i128;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i129;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i130;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i131;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i133;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i172;
import '../module_orders/ui/screen/order_accounts_screen.dart' as _i132;
import '../module_orders/ui/screen/order_details_screen.dart' as _i173;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i174;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i134;
import '../module_payments/manager/payments_manager.dart' as _i73;
import '../module_payments/payments_module.dart' as _i177;
import '../module_payments/repository/payments_repository.dart' as _i33;
import '../module_payments/service/payments_service.dart' as _i74;
import '../module_payments/state_manager/payments_from_state_manager.dart'
    as _i135;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i75;
import '../module_payments/ui/screen/paymen_from_captain_screen.dart' as _i176;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i136;
import '../module_reports/manager/reports_manager.dart' as _i36;
import '../module_reports/report_module.dart' as _i138;
import '../module_reports/repository/reports_repository.dart' as _i35;
import '../module_reports/service/reports_service.dart' as _i37;
import '../module_reports/state_manager/captains_report_state_manager.dart'
    as _i42;
import '../module_reports/state_manager/clients_report_state_manager.dart'
    as _i51;
import '../module_reports/state_manager/custom_products_state_manager.dart'
    as _i56;
import '../module_reports/state_manager/products_report_state_manager.dart'
    as _i77;
import '../module_reports/state_manager/stores_report_state_manager.dart'
    as _i39;
import '../module_reports/ui/screen/captains_reports_screen.dart' as _i108;
import '../module_reports/ui/screen/clients_reports_screen.dart' as _i114;
import '../module_reports/ui/screen/custom_product_screen.dart' as _i118;
import '../module_reports/ui/screen/products_reports_screen.dart' as _i137;
import '../module_reports/ui/screen/stores_reports_screen.dart' as _i87;
import '../module_settings/settings_module.dart' as _i139;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i15;
import '../module_settings/ui/settings_page/settings_page.dart' as _i79;
import '../module_splash/splash_module.dart' as _i80;
import '../module_splash/ui/screen/splash_screen.dart' as _i38;
import '../module_stores/manager/stores_manager.dart' as _i84;
import '../module_stores/repository/stores_repository.dart' as _i40;
import '../module_stores/service/store_service.dart' as _i88;
import '../module_stores/state_manager/store_balance_state_manager.dart'
    as _i140;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i145;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i147;
import '../module_stores/state_manager/stores_state_manager.dart' as _i89;
import '../module_stores/stores_module.dart' as _i181;
import '../module_stores/ui/screen/store_balance_screen.dart' as _i178;
import '../module_stores/ui/screen/store_info_screen.dart' as _i179;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i180;
import '../module_stores/ui/screen/stores_screen.dart' as _i148;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i10;
import '../module_theme/service/theme_service/theme_service.dart' as _i13;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i16;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i11;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i27;
import '../utils/global/global_state_manager.dart' as _i187;
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
  gh.factory<_i28.LinkingRepository>(() => _i28.LinkingRepository(
      get<_i12.ApiClient>(),
      get<_i18.AuthService>(),
      get<_i7.LocalizationService>()));
  gh.factory<_i29.LoginStateManager>(
      () => _i29.LoginStateManager(get<_i18.AuthService>()));
  gh.factory<_i30.LogsRepository>(() =>
      _i30.LogsRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i31.MyOrdersRepository>(() =>
      _i31.MyOrdersRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i32.NotificationRepo>(() =>
      _i32.NotificationRepo(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i33.PaymentsRepository>(() =>
      _i33.PaymentsRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i34.RegisterStateManager>(
      () => _i34.RegisterStateManager(get<_i18.AuthService>()));
  gh.factory<_i35.ReportRepository>(() =>
      _i35.ReportRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i36.ReportsManager>(
      () => _i36.ReportsManager(get<_i35.ReportRepository>()));
  gh.factory<_i37.ReportsService>(
      () => _i37.ReportsService(get<_i36.ReportsManager>()));
  gh.factory<_i38.SplashScreen>(
      () => _i38.SplashScreen(get<_i18.AuthService>()));
  gh.factory<_i39.StoresReportStateManager>(
      () => _i39.StoresReportStateManager(get<_i37.ReportsService>()));
  gh.factory<_i40.StoresRepository>(() =>
      _i40.StoresRepository(get<_i12.ApiClient>(), get<_i18.AuthService>()));
  gh.factory<_i41.CaptainManager>(
      () => _i41.CaptainManager(get<_i19.CaptainRepository>()));
  gh.factory<_i42.CaptainsReportStateManager>(
      () => _i42.CaptainsReportStateManager(get<_i37.ReportsService>()));
  gh.factory<_i43.CaptainsService>(
      () => _i43.CaptainsService(get<_i41.CaptainManager>()));
  gh.factory<_i44.CaptainsStateManager>(
      () => _i44.CaptainsStateManager(get<_i43.CaptainsService>()));
  gh.factory<_i45.CategoriesManager>(
      () => _i45.CategoriesManager(get<_i20.CategoriesRepository>()));
  gh.factory<_i46.CategoriesService>(
      () => _i46.CategoriesService(get<_i45.CategoriesManager>()));
  gh.factory<_i47.ChatManager>(
      () => _i47.ChatManager(get<_i21.ChatRepository>()));
  gh.factory<_i48.ChatService>(() => _i48.ChatService(get<_i47.ChatManager>()));
  gh.factory<_i49.ChatStateManager>(
      () => _i49.ChatStateManager(get<_i48.ChatService>()));
  gh.factory<_i50.ClientsManager>(
      () => _i50.ClientsManager(get<_i22.ClientsRepository>()));
  gh.factory<_i51.ClientsReportStateManager>(
      () => _i51.ClientsReportStateManager(get<_i37.ReportsService>()));
  gh.factory<_i52.ClientsService>(
      () => _i52.ClientsService(get<_i50.ClientsManager>()));
  gh.factory<_i53.ClientsStateManager>(
      () => _i53.ClientsStateManager(get<_i52.ClientsService>()));
  gh.factory<_i54.CompanyManager>(
      () => _i54.CompanyManager(get<_i23.CompanyRepository>()));
  gh.factory<_i55.CompanyService>(
      () => _i55.CompanyService(get<_i54.CompanyManager>()));
  gh.factory<_i56.CustomProductStateManager>(
      () => _i56.CustomProductStateManager(get<_i37.ReportsService>()));
  gh.factory<_i57.DistributorManager>(
      () => _i57.DistributorManager(get<_i24.DistributorRepository>()));
  gh.factory<_i58.FiltersManager>(
      () => _i58.FiltersManager(get<_i25.FiltersRepository>()));
  gh.factory<_i59.FiltersService>(
      () => _i59.FiltersService(get<_i58.FiltersManager>()));
  gh.factory<_i60.FireNotificationService>(() => _i60.FireNotificationService(
      get<_i9.NotificationsPrefsHelper>(), get<_i32.NotificationRepo>()));
  gh.factory<_i61.HomeManager>(
      () => _i61.HomeManager(get<_i26.HomeRepository>()));
  gh.factory<_i62.HomeService>(() => _i62.HomeService(get<_i61.HomeManager>()));
  gh.factory<_i63.HomeStateManager>(
      () => _i63.HomeStateManager(get<_i62.HomeService>()));
  gh.factory<_i64.InActiveCaptainsStateManager>(
      () => _i64.InActiveCaptainsStateManager(get<_i43.CaptainsService>()));
  gh.factory<_i65.LinkingManager>(
      () => _i65.LinkingManager(get<_i28.LinkingRepository>()));
  gh.factory<_i66.LinkingService>(
      () => _i66.LinkingService(get<_i65.LinkingManager>()));
  gh.factory<_i67.LoginScreen>(
      () => _i67.LoginScreen(get<_i29.LoginStateManager>()));
  gh.factory<_i68.LogsManager>(
      () => _i68.LogsManager(get<_i30.LogsRepository>()));
  gh.factory<_i69.LogsService>(() => _i69.LogsService(get<_i68.LogsManager>()));
  gh.factory<_i70.MyOrdersManager>(
      () => _i70.MyOrdersManager(get<_i31.MyOrdersRepository>()));
  gh.factory<_i71.OrdersAccountStateManager>(
      () => _i71.OrdersAccountStateManager(get<_i43.CaptainsService>()));
  gh.factory<_i72.OrdersService>(
      () => _i72.OrdersService(get<_i70.MyOrdersManager>()));
  gh.factory<_i73.PaymentsManager>(
      () => _i73.PaymentsManager(get<_i33.PaymentsRepository>()));
  gh.factory<_i74.PaymentsService>(
      () => _i74.PaymentsService(get<_i73.PaymentsManager>()));
  gh.factory<_i75.PaymentsToCaptainStateManager>(() =>
      _i75.PaymentsToCaptainStateManager(
          get<_i43.CaptainsService>(), get<_i74.PaymentsService>()));
  gh.factory<_i76.ProductsCategoryStateManager>(() =>
      _i76.ProductsCategoryStateManager(
          get<_i46.CategoriesService>(),
          get<_i18.AuthService>(),
          get<_i27.ImageUploadService>(),
          get<_i7.LocalizationService>()));
  gh.factory<_i77.ProductsReportStateManager>(
      () => _i77.ProductsReportStateManager(get<_i37.ReportsService>()));
  gh.factory<_i78.RegisterScreen>(
      () => _i78.RegisterScreen(get<_i34.RegisterStateManager>()));
  gh.factory<_i79.SettingsScreen>(() => _i79.SettingsScreen(
      get<_i18.AuthService>(),
      get<_i7.LocalizationService>(),
      get<_i13.AppThemeDataService>(),
      get<_i60.FireNotificationService>()));
  gh.factory<_i80.SplashModule>(
      () => _i80.SplashModule(get<_i38.SplashScreen>()));
  gh.factory<_i81.StoreCategoriesLinkingStateManager>(() =>
      _i81.StoreCategoriesLinkingStateManager(get<_i66.LinkingService>(),
          get<_i18.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i82.StoreCategoriesStateManager>(() =>
      _i82.StoreCategoriesStateManager(get<_i46.CategoriesService>(),
          get<_i18.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i83.StoreLogsStateManager>(
      () => _i83.StoreLogsStateManager(get<_i69.LogsService>()));
  gh.factory<_i84.StoreManager>(
      () => _i84.StoreManager(get<_i40.StoresRepository>()));
  gh.factory<_i85.StoreProductsStateManager>(() =>
      _i85.StoreProductsStateManager(get<_i46.CategoriesService>(),
          get<_i18.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i86.StoresFilterStateManager>(
      () => _i86.StoresFilterStateManager(get<_i59.FiltersService>()));
  gh.factory<_i87.StoresReportScreen>(
      () => _i87.StoresReportScreen(get<_i39.StoresReportStateManager>()));
  gh.factory<_i88.StoresService>(
      () => _i88.StoresService(get<_i84.StoreManager>()));
  gh.factory<_i89.StoresStateManager>(() => _i89.StoresStateManager(
      get<_i88.StoresService>(),
      get<_i18.AuthService>(),
      get<_i27.ImageUploadService>(),
      get<_i46.CategoriesService>()));
  gh.factory<_i90.SubCategoriesLinkingStateManager>(() =>
      _i90.SubCategoriesLinkingStateManager(get<_i66.LinkingService>(),
          get<_i18.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i91.SubCategoriesListStateManager>(() =>
      _i91.SubCategoriesListStateManager(
          get<_i88.StoresService>(),
          get<_i18.AuthService>(),
          get<_i27.ImageUploadService>(),
          get<_i66.LinkingService>()));
  gh.factory<_i92.SubCategoriesStateManager>(() =>
      _i92.SubCategoriesStateManager(
          get<_i88.StoresService>(),
          get<_i18.AuthService>(),
          get<_i27.ImageUploadService>(),
          get<_i46.CategoriesService>()));
  gh.factory<_i93.UpdateLevelTwoCategoriesStateManager>(() =>
      _i93.UpdateLevelTwoCategoriesStateManager(get<_i46.CategoriesService>(),
          get<_i18.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i94.UpdateLevelTwoCategoryScreen>(() =>
      _i94.UpdateLevelTwoCategoryScreen(
          get<_i93.UpdateLevelTwoCategoriesStateManager>()));
  gh.factory<_i95.UpdateStoreCategoriesStateManager>(() =>
      _i95.UpdateStoreCategoriesStateManager(get<_i46.CategoriesService>(),
          get<_i18.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i96.UpdateStoreCategoryScreen>(() =>
      _i96.UpdateStoreCategoryScreen(
          get<_i95.UpdateStoreCategoriesStateManager>()));
  gh.factory<_i97.UpdateSubCategoriesStateManager>(() =>
      _i97.UpdateSubCategoriesStateManager(get<_i46.CategoriesService>(),
          get<_i18.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i98.UpdateSubCategoryScreen>(() => _i98.UpdateSubCategoryScreen(
      get<_i97.UpdateSubCategoriesStateManager>()));
  gh.factory<_i99.AuthorizationModule>(() => _i99.AuthorizationModule(
      get<_i67.LoginScreen>(), get<_i78.RegisterScreen>()));
  gh.factory<_i100.CaptainBalanceStateManager>(
      () => _i100.CaptainBalanceStateManager(get<_i43.CaptainsService>()));
  gh.factory<_i101.CaptainBalanceStateManager>(
      () => _i101.CaptainBalanceStateManager(get<_i43.CaptainsService>()));
  gh.factory<_i102.CaptainFilterStateManager>(
      () => _i102.CaptainFilterStateManager(get<_i59.FiltersService>()));
  gh.factory<_i103.CaptainLogsStateManager>(
      () => _i103.CaptainLogsStateManager(get<_i69.LogsService>()));
  gh.factory<_i104.CaptainProfileStateManager>(
      () => _i104.CaptainProfileStateManager(get<_i43.CaptainsService>()));
  gh.factory<_i105.CaptainProfileStateManager>(
      () => _i105.CaptainProfileStateManager(get<_i43.CaptainsService>()));
  gh.factory<_i106.CaptainsPaymentsStateManager>(
      () => _i106.CaptainsPaymentsStateManager(get<_i43.CaptainsService>()));
  gh.factory<_i107.CaptainsPaymentsStateManager>(
      () => _i107.CaptainsPaymentsStateManager(get<_i43.CaptainsService>()));
  gh.factory<_i108.CaptainsReportScreen>(
      () => _i108.CaptainsReportScreen(get<_i42.CaptainsReportStateManager>()));
  gh.factory<_i109.CaptainsScreen>(
      () => _i109.CaptainsScreen(get<_i44.CaptainsStateManager>()));
  gh.factory<_i110.CategoriesLevel2ListStateManager>(() =>
      _i110.CategoriesLevel2ListStateManager(
          get<_i66.LinkingService>(),
          get<_i18.AuthService>(),
          get<_i27.ImageUploadService>(),
          get<_i7.LocalizationService>()));
  gh.factory<_i111.ChatPage>(() => _i111.ChatPage(
      get<_i49.ChatStateManager>(),
      get<_i27.ImageUploadService>(),
      get<_i18.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i112.ClientProfileStateManager>(
      () => _i112.ClientProfileStateManager(get<_i52.ClientsService>()));
  gh.factory<_i113.ClientsNeedsSupportStateManager>(
      () => _i113.ClientsNeedsSupportStateManager(get<_i52.ClientsService>()));
  gh.factory<_i114.ClientsReportScreen>(
      () => _i114.ClientsReportScreen(get<_i51.ClientsReportStateManager>()));
  gh.factory<_i115.ClientsScreen>(
      () => _i115.ClientsScreen(get<_i53.ClientsStateManager>()));
  gh.factory<_i116.CompanyFinanceStateManager>(() =>
      _i116.CompanyFinanceStateManager(
          get<_i18.AuthService>(), get<_i55.CompanyService>()));
  gh.factory<_i117.CompanyProfileStateManager>(() =>
      _i117.CompanyProfileStateManager(
          get<_i18.AuthService>(), get<_i55.CompanyService>()));
  gh.factory<_i118.CustomProductScreen>(
      () => _i118.CustomProductScreen(get<_i56.CustomProductStateManager>()));
  gh.factory<_i119.DistributerService>(
      () => _i119.DistributerService(get<_i57.DistributorManager>()));
  gh.factory<_i120.DistrosStateManager>(
      () => _i120.DistrosStateManager(get<_i119.DistributerService>()));
  gh.factory<_i121.HomeScreen>(
      () => _i121.HomeScreen(get<_i63.HomeStateManager>()));
  gh.factory<_i122.InActiveCaptainsScreen>(() =>
      _i122.InActiveCaptainsScreen(get<_i64.InActiveCaptainsStateManager>()));
  gh.factory<_i123.InActiveDistributorsStateManager>(() =>
      _i123.InActiveDistributorsStateManager(get<_i119.DistributerService>()));
  gh.factory<_i124.LevelTowCategoriesListScreen>(() =>
      _i124.LevelTowCategoriesListScreen(
          get<_i110.CategoriesLevel2ListStateManager>(),
          get<_i7.LocalizationService>()));
  gh.factory<_i125.LevelTowCategoriesScreen>(() =>
      _i125.LevelTowCategoriesScreen(get<_i76.ProductsCategoryStateManager>(),
          get<_i7.LocalizationService>()));
  gh.factory<_i126.MainScreen>(() => _i126.MainScreen(get<_i121.HomeScreen>()));
  gh.factory<_i127.MyOrdersStateManager>(() => _i127.MyOrdersStateManager(
      get<_i72.OrdersService>(), get<_i18.AuthService>()));
  gh.factory<_i128.OnGoingOrdersStateManager>(() =>
      _i128.OnGoingOrdersStateManager(
          get<_i72.OrdersService>(), get<_i18.AuthService>()));
  gh.factory<_i129.OrderDetailsStateManager>(
      () => _i129.OrderDetailsStateManager(get<_i72.OrdersService>()));
  gh.factory<_i130.OrderTimeLineStateManager>(
      () => _i130.OrderTimeLineStateManager(get<_i72.OrdersService>()));
  gh.factory<_i131.OrderWithoutPendingStateManager>(() =>
      _i131.OrderWithoutPendingStateManager(
          get<_i72.OrdersService>(), get<_i18.AuthService>()));
  gh.factory<_i132.OrdersAccountScreen>(
      () => _i132.OrdersAccountScreen(get<_i71.OrdersAccountStateManager>()));
  gh.factory<_i133.OrdersScreen>(
      () => _i133.OrdersScreen(get<_i127.MyOrdersStateManager>()));
  gh.factory<_i134.OrdersWithoutPendingScreen>(() =>
      _i134.OrdersWithoutPendingScreen(
          get<_i131.OrderWithoutPendingStateManager>()));
  gh.factory<_i135.PaymentsFromCaptainStateManager>(() =>
      _i135.PaymentsFromCaptainStateManager(
          get<_i43.CaptainsService>(), get<_i74.PaymentsService>()));
  gh.factory<_i136.PaymentsToCaptainScreen>(() =>
      _i136.PaymentsToCaptainScreen(get<_i75.PaymentsToCaptainStateManager>()));
  gh.factory<_i137.ProductsReportScreen>(
      () => _i137.ProductsReportScreen(get<_i77.ProductsReportStateManager>()));
  gh.factory<_i138.ReportsModule>(() => _i138.ReportsModule(
      get<_i137.ProductsReportScreen>(),
      get<_i87.StoresReportScreen>(),
      get<_i108.CaptainsReportScreen>(),
      get<_i114.ClientsReportScreen>(),
      get<_i118.CustomProductScreen>()));
  gh.factory<_i139.SettingsModule>(() => _i139.SettingsModule(
      get<_i79.SettingsScreen>(), get<_i15.ChooseLocalScreen>()));
  gh.factory<_i140.StoreBalanceStateManager>(
      () => _i140.StoreBalanceStateManager(get<_i88.StoresService>()));
  gh.factory<_i141.StoreCategoriesLinkingScreen>(() =>
      _i141.StoreCategoriesLinkingScreen(
          get<_i81.StoreCategoriesLinkingStateManager>(),
          get<_i7.LocalizationService>()));
  gh.factory<_i142.StoreCategoriesScreen>(() => _i142.StoreCategoriesScreen(
      get<_i82.StoreCategoriesStateManager>(), get<_i7.LocalizationService>()));
  gh.factory<_i143.StoreLogsScreen>(
      () => _i143.StoreLogsScreen(get<_i83.StoreLogsStateManager>()));
  gh.factory<_i144.StoreProductScreen>(
      () => _i144.StoreProductScreen(get<_i85.StoreProductsStateManager>()));
  gh.factory<_i145.StoreProfileStateManager>(
      () => _i145.StoreProfileStateManager(get<_i88.StoresService>()));
  gh.factory<_i146.StoresFilterScreen>(
      () => _i146.StoresFilterScreen(get<_i86.StoresFilterStateManager>()));
  gh.factory<_i147.StoresInActiveStateManager>(() =>
      _i147.StoresInActiveStateManager(
          get<_i88.StoresService>(),
          get<_i18.AuthService>(),
          get<_i27.ImageUploadService>(),
          get<_i46.CategoriesService>()));
  gh.factory<_i148.StoresScreen>(
      () => _i148.StoresScreen(get<_i89.StoresStateManager>()));
  gh.factory<_i149.SubCategoriesLinkingScreen>(() =>
      _i149.SubCategoriesLinkingScreen(
          get<_i90.SubCategoriesLinkingStateManager>()));
  gh.factory<_i150.SubCategoriesListScreen>(() => _i150.SubCategoriesListScreen(
      get<_i91.SubCategoriesListStateManager>(),
      get<_i7.LocalizationService>()));
  gh.factory<_i151.SubCategoriesScreen>(() => _i151.SubCategoriesScreen(
      get<_i92.SubCategoriesStateManager>(), get<_i7.LocalizationService>()));
  gh.factory<_i152.CaptainBalanceScreen>(() =>
      _i152.CaptainBalanceScreen(get<_i100.CaptainBalanceStateManager>()));
  gh.factory<_i153.CaptainBalanceScreen>(() =>
      _i153.CaptainBalanceScreen(get<_i100.CaptainBalanceStateManager>()));
  gh.factory<_i154.CaptainFilterScreen>(
      () => _i154.CaptainFilterScreen(get<_i102.CaptainFilterStateManager>()));
  gh.factory<_i155.CaptainLogsScreen>(
      () => _i155.CaptainLogsScreen(get<_i103.CaptainLogsStateManager>()));
  gh.factory<_i156.CaptainProfileScreen>(() =>
      _i156.CaptainProfileScreen(get<_i105.CaptainProfileStateManager>()));
  gh.factory<_i157.CaptainProfileScreen>(() =>
      _i157.CaptainProfileScreen(get<_i105.CaptainProfileStateManager>()));
  gh.factory<_i158.CaptainsPaymentsScreen>(() =>
      _i158.CaptainsPaymentsScreen(get<_i106.CaptainsPaymentsStateManager>()));
  gh.factory<_i159.CaptainsPaymentsScreen>(() =>
      _i159.CaptainsPaymentsScreen(get<_i106.CaptainsPaymentsStateManager>()));
  gh.factory<_i160.CategoriesModule>(() => _i160.CategoriesModule(
      get<_i142.StoreCategoriesScreen>(),
      get<_i125.LevelTowCategoriesScreen>(),
      get<_i144.StoreProductScreen>(),
      get<_i151.SubCategoriesScreen>(),
      get<_i96.UpdateStoreCategoryScreen>(),
      get<_i98.UpdateSubCategoryScreen>(),
      get<_i94.UpdateLevelTwoCategoryScreen>()));
  gh.factory<_i161.ChatModule>(
      () => _i161.ChatModule(get<_i111.ChatPage>(), get<_i18.AuthService>()));
  gh.factory<_i162.ClientProfileScreen>(
      () => _i162.ClientProfileScreen(get<_i112.ClientProfileStateManager>()));
  gh.factory<_i163.ClientsNeedsSupportScreen>(() =>
      _i163.ClientsNeedsSupportScreen(
          get<_i113.ClientsNeedsSupportStateManager>()));
  gh.factory<_i164.CompanyFinanceScreen>(() =>
      _i164.CompanyFinanceScreen(get<_i116.CompanyFinanceStateManager>()));
  gh.factory<_i165.CompanyProfileScreen>(() =>
      _i165.CompanyProfileScreen(get<_i117.CompanyProfileStateManager>()));
  gh.factory<_i166.DistrosScreen>(
      () => _i166.DistrosScreen(get<_i120.DistrosStateManager>()));
  gh.factory<_i167.FiltersModule>(() => _i167.FiltersModule(
      get<_i154.CaptainFilterScreen>(), get<_i146.StoresFilterScreen>()));
  gh.factory<_i168.InActiveDistributorsScreen>(() =>
      _i168.InActiveDistributorsScreen(
          get<_i123.InActiveDistributorsStateManager>()));
  gh.factory<_i169.LinkingModule>(() => _i169.LinkingModule(
      get<_i124.LevelTowCategoriesListScreen>(),
      get<_i141.StoreCategoriesLinkingScreen>(),
      get<_i149.SubCategoriesLinkingScreen>(),
      get<_i150.SubCategoriesListScreen>()));
  gh.factory<_i170.LogsModule>(() => _i170.LogsModule(
      get<_i155.CaptainLogsScreen>(), get<_i143.StoreLogsScreen>()));
  gh.factory<_i171.MainModule>(
      () => _i171.MainModule(get<_i126.MainScreen>(), get<_i121.HomeScreen>()));
  gh.factory<_i172.OnGoingOrdersScreen>(
      () => _i172.OnGoingOrdersScreen(get<_i128.OnGoingOrdersStateManager>()));
  gh.factory<_i173.OrderDetailsScreen>(
      () => _i173.OrderDetailsScreen(get<_i129.OrderDetailsStateManager>()));
  gh.factory<_i174.OrderTimLineScreen>(
      () => _i174.OrderTimLineScreen(get<_i130.OrderTimeLineStateManager>()));
  gh.factory<_i175.OrdersModule>(() => _i175.OrdersModule(
      get<_i133.OrdersScreen>(),
      get<_i173.OrderDetailsScreen>(),
      get<_i172.OnGoingOrdersScreen>(),
      get<_i174.OrderTimLineScreen>(),
      get<_i134.OrdersWithoutPendingScreen>(),
      get<_i132.OrdersAccountScreen>()));
  gh.factory<_i176.PaymentsFromCaptainScreen>(() =>
      _i176.PaymentsFromCaptainScreen(
          get<_i135.PaymentsFromCaptainStateManager>()));
  gh.factory<_i177.PaymentsModule>(() => _i177.PaymentsModule(
      get<_i176.PaymentsFromCaptainScreen>(),
      get<_i136.PaymentsToCaptainScreen>()));
  gh.factory<_i178.StoreBalanceScreen>(
      () => _i178.StoreBalanceScreen(get<_i140.StoreBalanceStateManager>()));
  gh.factory<_i179.StoreInfoScreen>(
      () => _i179.StoreInfoScreen(get<_i145.StoreProfileStateManager>()));
  gh.factory<_i180.StoresInActiveScreen>(() =>
      _i180.StoresInActiveScreen(get<_i147.StoresInActiveStateManager>()));
  gh.factory<_i181.StoresModule>(() => _i181.StoresModule(
      get<_i148.StoresScreen>(),
      get<_i179.StoreInfoScreen>(),
      get<_i180.StoresInActiveScreen>(),
      get<_i178.StoreBalanceScreen>()));
  gh.factory<_i182.CaptainsModule>(() => _i182.CaptainsModule(
      get<_i122.InActiveCaptainsScreen>(),
      get<_i156.CaptainProfileScreen>(),
      get<_i153.CaptainBalanceScreen>(),
      get<_i158.CaptainsPaymentsScreen>(),
      get<_i109.CaptainsScreen>()));
  gh.factory<_i183.ClientsModule>(() => _i183.ClientsModule(
      get<_i162.ClientProfileScreen>(),
      get<_i115.ClientsScreen>(),
      get<_i163.ClientsNeedsSupportScreen>()));
  gh.factory<_i184.CompanyModule>(() => _i184.CompanyModule(
      get<_i165.CompanyProfileScreen>(), get<_i164.CompanyFinanceScreen>()));
  gh.factory<_i185.DistributorsModule>(() => _i185.DistributorsModule(
      get<_i166.DistrosScreen>(),
      get<_i156.CaptainProfileScreen>(),
      get<_i153.CaptainBalanceScreen>(),
      get<_i158.CaptainsPaymentsScreen>(),
      get<_i168.InActiveDistributorsScreen>()));
  gh.factory<_i186.MyApp>(() => _i186.MyApp(
      get<_i13.AppThemeDataService>(),
      get<_i7.LocalizationService>(),
      get<_i60.FireNotificationService>(),
      get<_i5.LocalNotificationService>(),
      get<_i80.SplashModule>(),
      get<_i99.AuthorizationModule>(),
      get<_i161.ChatModule>(),
      get<_i139.SettingsModule>(),
      get<_i171.MainModule>(),
      get<_i160.CategoriesModule>(),
      get<_i181.StoresModule>(),
      get<_i182.CaptainsModule>(),
      get<_i184.CompanyModule>(),
      get<_i175.OrdersModule>(),
      get<_i177.PaymentsModule>(),
      get<_i167.FiltersModule>(),
      get<_i170.LogsModule>(),
      get<_i169.LinkingModule>()));
  gh.singleton<_i187.GlobalStateManager>(_i187.GlobalStateManager(
      get<_i64.InActiveCaptainsStateManager>(),
      get<_i44.CaptainsStateManager>()));
  return get;
}
