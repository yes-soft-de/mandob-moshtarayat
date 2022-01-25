// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i190;
import '../module_auth/authoriazation_module.dart' as _i105;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i18;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i19;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i30;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i35;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i72;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i83;
import '../module_captain/captains_module.dart' as _i187;
import '../module_captain/manager/captains_manager.dart' as _i42;
import '../module_captain/repository/captain_repository.dart' as _i20;
import '../module_captain/service/captains_service.dart' as _i44;
import '../module_captain/state_manager/captain_balance_state_manager.dart'
    as _i107;
import '../module_captain/state_manager/captain_captains_payment_list_state_manager.dart'
    as _i111;
import '../module_captain/state_manager/captain_list.dart' as _i45;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i110;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i68;
import '../module_captain/ui/screen/captain_balance_screen.dart' as _i158;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i162;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i114;
import '../module_captain/ui/screen/catpains_payment_screen.dart' as _i163;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i127;
import '../module_categories/categories_module.dart' as _i165;
import '../module_categories/manager/categories_manager.dart' as _i46;
import '../module_categories/repository/categories_repository.dart' as _i21;
import '../module_categories/service/store_categories_service.dart' as _i47;
import '../module_categories/state_manager/products_category_state_manager.dart'
    as _i81;
import '../module_categories/state_manager/store_categories_state_manager.dart'
    as _i87;
import '../module_categories/state_manager/store_products_state_manager.dart'
    as _i91;
import '../module_categories/state_manager/sub_categories_state_manager.dart'
    as _i98;
import '../module_categories/state_manager/update_categories_state_manager/update_level_two_category_state_manager.dart'
    as _i99;
import '../module_categories/state_manager/update_categories_state_manager/update_store_category_state_manager.dart'
    as _i101;
import '../module_categories/state_manager/update_categories_state_manager/update_sub_category_state_manager.dart'
    as _i103;
import '../module_categories/ui/screen/level_tow_categories_screen.dart'
    as _i130;
import '../module_categories/ui/screen/store_categories_screen.dart' as _i148;
import '../module_categories/ui/screen/store_products_screen.dart' as _i150;
import '../module_categories/ui/screen/sub_categories_screen.dart' as _i157;
import '../module_categories/ui/screen/update_categories_screen/update_level_two_category_screen.dart'
    as _i100;
import '../module_categories/ui/screen/update_categories_screen/update_store_category_screen.dart'
    as _i102;
import '../module_categories/ui/screen/update_categories_screen/update_sub_category_screen.dart'
    as _i104;
import '../module_categories_linking/linking_module.dart' as _i173;
import '../module_categories_linking/manager/linking_manager.dart' as _i70;
import '../module_categories_linking/repository/linking_repository.dart'
    as _i29;
import '../module_categories_linking/service/linking_service.dart' as _i71;
import '../module_categories_linking/state_manager/categories_level2_state_manager.dart'
    as _i115;
import '../module_categories_linking/state_manager/store_categories_linking_state_manager.dart'
    as _i86;
import '../module_categories_linking/state_manager/sub_categories_linking_state_manager.dart'
    as _i96;
import '../module_categories_linking/state_manager/sub_categories_list_state_manager.dart'
    as _i97;
import '../module_categories_linking/ui/screen/level_tow_categories_list_screen.dart'
    as _i129;
import '../module_categories_linking/ui/screen/store_categories_linking_screen.dart'
    as _i147;
import '../module_categories_linking/ui/screen/sub_categories_linking_screen.dart'
    as _i155;
import '../module_categories_linking/ui/screen/sub_categories_list_screen.dart'
    as _i156;
import '../module_chat/chat_module.dart' as _i166;
import '../module_chat/manager/chat/chat_manager.dart' as _i48;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i22;
import '../module_chat/service/chat/char_service.dart' as _i49;
import '../module_chat/state_manager/chat_state_manager.dart' as _i50;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i116;
import '../module_clients/clients_module.dart' as _i188;
import '../module_clients/manager/clients_manager.dart' as _i51;
import '../module_clients/repository/clients_repository.dart' as _i23;
import '../module_clients/service/clients_service.dart' as _i53;
import '../module_clients/state_manager/client_list.dart' as _i54;
import '../module_clients/state_manager/client_profile_state_manager.dart'
    as _i117;
import '../module_clients/state_manager/clients_need_support_state_manager.dart'
    as _i118;
import '../module_clients/ui/screen/clients_list_screen.dart' as _i120;
import '../module_clients/ui/screen/clients_needs_support_screen.dart' as _i168;
import '../module_clients/ui/screen/clients_profile_screen.dart' as _i167;
import '../module_company/company_module.dart' as _i189;
import '../module_company/manager/company_manager.dart' as _i55;
import '../module_company/repository/company_repository.dart' as _i24;
import '../module_company/service/company_service.dart' as _i56;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i121;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i122;
import '../module_company/ui/screen/company_finance_screen.dart' as _i169;
import '../module_company/ui/screen/company_profile_screen.dart' as _i170;
import '../module_distributor/distros_module.dart' as _i171;
import '../module_distributor/manager/distributors_manager.dart' as _i58;
import '../module_distributor/repository/distributor_repository.dart' as _i25;
import '../module_distributor/service/distributer_service.dart' as _i59;
import '../module_distributor/state_manager/captain_balance_state_manager.dart'
    as _i106;
import '../module_distributor/state_manager/captain_captains_payment_list_state_manager.dart'
    as _i112;
import '../module_distributor/state_manager/distros_list.dart' as _i61;
import '../module_distributor/state_manager/distros_profile_state_manager.dart'
    as _i60;
import '../module_distributor/state_manager/in_active_distro_state_manager.dart'
    as _i69;
import '../module_distributor/ui/screen/captain_balance_screen.dart' as _i159;
import '../module_distributor/ui/screen/catpains_payment_screen.dart' as _i164;
import '../module_distributor/ui/screen/distors_list_screen.dart' as _i125;
import '../module_distributor/ui/screen/distros_profile_screen.dart' as _i124;
import '../module_distributor/ui/screen/in_active_distros_screen.dart' as _i128;
import '../module_filters/filters_module.dart' as _i172;
import '../module_filters/manager/filters_manager.dart' as _i62;
import '../module_filters/repository/filters_repository.dart' as _i26;
import '../module_filters/service/filters_service.dart' as _i63;
import '../module_filters/state_manager/captain_filter_state_manager.dart'
    as _i108;
import '../module_filters/state_manager/store_filter_state_manager.dart'
    as _i92;
import '../module_filters/ui/screen/captain_filter_screen.dart' as _i160;
import '../module_filters/ui/screen/store_filter_screen.dart' as _i152;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_logs/logs_module.dart' as _i174;
import '../module_logs/manager/logs_manager.dart' as _i73;
import '../module_logs/repository/logs_repository.dart' as _i31;
import '../module_logs/service/logs_service.dart' as _i74;
import '../module_logs/state_manager/captain_logs_state_manager.dart' as _i109;
import '../module_logs/state_manager/store_logs_state_manager.dart' as _i88;
import '../module_logs/ui/screen/captain_logs_screen.dart' as _i161;
import '../module_logs/ui/screen/store_logs_screen.dart' as _i149;
import '../module_main/main_module.dart' as _i175;
import '../module_main/manager/home_manager.dart' as _i65;
import '../module_main/repository/home_repository.dart' as _i27;
import '../module_main/sceen/home_screen.dart' as _i126;
import '../module_main/sceen/main_screen.dart' as _i131;
import '../module_main/service/home_service.dart' as _i66;
import '../module_main/state_manager/home_state_manager.dart' as _i67;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i33;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i64;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_orders/manager/my_orders_manager.dart' as _i75;
import '../module_orders/orders_module.dart' as _i179;
import '../module_orders/repository/orders_repository.dart' as _i32;
import '../module_orders/service/orders_service.dart' as _i77;
import '../module_orders/state_manager/captains_from_state_manager.dart'
    as _i76;
import '../module_orders/state_manager/my_orders_state_manager.dart' as _i132;
import '../module_orders/state_manager/ongoing_orders_state_manager.dart'
    as _i133;
import '../module_orders/state_manager/order_details_state_manager.dart'
    as _i134;
import '../module_orders/state_manager/order_tim_line_state_manager.dart'
    as _i135;
import '../module_orders/state_manager/orders_without_pending_state_manager.dart'
    as _i136;
import '../module_orders/ui/screen/my_orders_screen.dart' as _i138;
import '../module_orders/ui/screen/OngoingOrdersScreen.dart' as _i176;
import '../module_orders/ui/screen/order_accounts_screen.dart' as _i137;
import '../module_orders/ui/screen/order_details_screen.dart' as _i177;
import '../module_orders/ui/screen/order_timeline_screen.dart' as _i178;
import '../module_orders/ui/screen/orders_without_pending_screen.dart' as _i139;
import '../module_payments/manager/payments_manager.dart' as _i78;
import '../module_payments/payments_module.dart' as _i182;
import '../module_payments/repository/payments_repository.dart' as _i34;
import '../module_payments/service/payments_service.dart' as _i79;
import '../module_payments/state_manager/payments_from_state_manager.dart'
    as _i140;
import '../module_payments/state_manager/payments_list_state_manager.dart'
    as _i141;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i80;
import '../module_payments/ui/screen/paymen_from_captain_screen.dart' as _i180;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i142;
import '../module_payments/ui/screen/payments_list_screen.dart' as _i181;
import '../module_reports/manager/reports_manager.dart' as _i37;
import '../module_reports/report_module.dart' as _i144;
import '../module_reports/repository/reports_repository.dart' as _i36;
import '../module_reports/service/reports_service.dart' as _i38;
import '../module_reports/state_manager/captains_report_state_manager.dart'
    as _i43;
import '../module_reports/state_manager/clients_report_state_manager.dart'
    as _i52;
import '../module_reports/state_manager/custom_products_state_manager.dart'
    as _i57;
import '../module_reports/state_manager/products_report_state_manager.dart'
    as _i82;
import '../module_reports/state_manager/stores_report_state_manager.dart'
    as _i40;
import '../module_reports/ui/screen/captains_reports_screen.dart' as _i113;
import '../module_reports/ui/screen/clients_reports_screen.dart' as _i119;
import '../module_reports/ui/screen/custom_product_screen.dart' as _i123;
import '../module_reports/ui/screen/products_reports_screen.dart' as _i143;
import '../module_reports/ui/screen/stores_reports_screen.dart' as _i93;
import '../module_settings/settings_module.dart' as _i145;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i84;
import '../module_splash/splash_module.dart' as _i85;
import '../module_splash/ui/screen/splash_screen.dart' as _i39;
import '../module_stores/manager/stores_manager.dart' as _i89;
import '../module_stores/repository/stores_repository.dart' as _i41;
import '../module_stores/service/store_payment.dart' as _i90;
import '../module_stores/service/store_service.dart' as _i94;
import '../module_stores/state_manager/store_balance_state_manager.dart'
    as _i146;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i151;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i153;
import '../module_stores/state_manager/stores_state_manager.dart' as _i95;
import '../module_stores/stores_module.dart' as _i186;
import '../module_stores/ui/screen/store_balance_screen.dart' as _i183;
import '../module_stores/ui/screen/store_info_screen.dart' as _i184;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i185;
import '../module_stores/ui/screen/stores_screen.dart' as _i154;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i28;
import '../utils/global/global_state_manager.dart' as _i191;
import '../utils/helpers/firestore_helper.dart' as _i5;
import '../utils/logger/logger.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.ChatHiveHelper>(() => _i4.ChatHiveHelper());
  gh.factory<_i5.FireStoreHelper>(() => _i5.FireStoreHelper());
  gh.factory<_i6.LocalNotificationService>(
      () => _i6.LocalNotificationService());
  gh.factory<_i7.LocalizationPreferencesHelper>(
      () => _i7.LocalizationPreferencesHelper());
  gh.factory<_i8.LocalizationService>(
      () => _i8.LocalizationService(get<_i7.LocalizationPreferencesHelper>()));
  gh.factory<_i9.Logger>(() => _i9.Logger());
  gh.factory<_i10.NotificationsPrefHelper>(
      () => _i10.NotificationsPrefHelper());
  gh.factory<_i11.ThemePreferencesHelper>(() => _i11.ThemePreferencesHelper());
  gh.factory<_i12.UploadRepository>(() => _i12.UploadRepository());
  gh.factory<_i13.ApiClient>(() => _i13.ApiClient(get<_i9.Logger>()));
  gh.factory<_i14.AppThemeDataService>(
      () => _i14.AppThemeDataService(get<_i11.ThemePreferencesHelper>()));
  gh.factory<_i15.AuthRepository>(
      () => _i15.AuthRepository(get<_i13.ApiClient>(), get<_i9.Logger>()));
  gh.factory<_i16.ChooseLocalScreen>(
      () => _i16.ChooseLocalScreen(get<_i8.LocalizationService>()));
  gh.factory<_i17.UploadManager>(
      () => _i17.UploadManager(get<_i12.UploadRepository>()));
  gh.factory<_i18.AuthManager>(
      () => _i18.AuthManager(get<_i15.AuthRepository>()));
  gh.factory<_i19.AuthService>(() =>
      _i19.AuthService(get<_i3.AuthPrefsHelper>(), get<_i18.AuthManager>()));
  gh.factory<_i20.CaptainRepository>(() =>
      _i20.CaptainRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i21.CategoriesRepository>(() => _i21.CategoriesRepository(
      get<_i13.ApiClient>(),
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>()));
  gh.factory<_i22.ChatRepository>(() =>
      _i22.ChatRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i23.ClientsRepository>(() =>
      _i23.ClientsRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i24.CompanyRepository>(() =>
      _i24.CompanyRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i25.DistributorRepository>(() => _i25.DistributorRepository(
      get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i26.FiltersRepository>(() =>
      _i26.FiltersRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i27.HomeRepository>(() =>
      _i27.HomeRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i28.ImageUploadService>(
      () => _i28.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i29.LinkingRepository>(() => _i29.LinkingRepository(
      get<_i13.ApiClient>(),
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>()));
  gh.factory<_i30.LoginStateManager>(
      () => _i30.LoginStateManager(get<_i19.AuthService>()));
  gh.factory<_i31.LogsRepository>(() =>
      _i31.LogsRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i32.MyOrdersRepository>(() =>
      _i32.MyOrdersRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i33.NotificationRepo>(() =>
      _i33.NotificationRepo(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i34.PaymentsRepository>(() =>
      _i34.PaymentsRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i35.RegisterStateManager>(
      () => _i35.RegisterStateManager(get<_i19.AuthService>()));
  gh.factory<_i36.ReportRepository>(() =>
      _i36.ReportRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i37.ReportsManager>(
      () => _i37.ReportsManager(get<_i36.ReportRepository>()));
  gh.factory<_i38.ReportsService>(
      () => _i38.ReportsService(get<_i37.ReportsManager>()));
  gh.factory<_i39.SplashScreen>(
      () => _i39.SplashScreen(get<_i19.AuthService>()));
  gh.factory<_i40.StoresReportStateManager>(
      () => _i40.StoresReportStateManager(get<_i38.ReportsService>()));
  gh.factory<_i41.StoresRepository>(() =>
      _i41.StoresRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i42.CaptainManager>(
      () => _i42.CaptainManager(get<_i20.CaptainRepository>()));
  gh.factory<_i43.CaptainsReportStateManager>(
      () => _i43.CaptainsReportStateManager(get<_i38.ReportsService>()));
  gh.factory<_i44.CaptainsService>(
      () => _i44.CaptainsService(get<_i42.CaptainManager>()));
  gh.factory<_i45.CaptainsStateManager>(
      () => _i45.CaptainsStateManager(get<_i44.CaptainsService>()));
  gh.factory<_i46.CategoriesManager>(
      () => _i46.CategoriesManager(get<_i21.CategoriesRepository>()));
  gh.factory<_i47.CategoriesService>(
      () => _i47.CategoriesService(get<_i46.CategoriesManager>()));
  gh.factory<_i48.ChatManager>(
      () => _i48.ChatManager(get<_i22.ChatRepository>()));
  gh.factory<_i49.ChatService>(() => _i49.ChatService(get<_i48.ChatManager>()));
  gh.factory<_i50.ChatStateManager>(
      () => _i50.ChatStateManager(get<_i49.ChatService>()));
  gh.factory<_i51.ClientsManager>(
      () => _i51.ClientsManager(get<_i23.ClientsRepository>()));
  gh.factory<_i52.ClientsReportStateManager>(
      () => _i52.ClientsReportStateManager(get<_i38.ReportsService>()));
  gh.factory<_i53.ClientsService>(
      () => _i53.ClientsService(get<_i51.ClientsManager>()));
  gh.factory<_i54.ClientsStateManager>(
      () => _i54.ClientsStateManager(get<_i53.ClientsService>()));
  gh.factory<_i55.CompanyManager>(
      () => _i55.CompanyManager(get<_i24.CompanyRepository>()));
  gh.factory<_i56.CompanyService>(
      () => _i56.CompanyService(get<_i55.CompanyManager>()));
  gh.factory<_i57.CustomProductStateManager>(
      () => _i57.CustomProductStateManager(get<_i38.ReportsService>()));
  gh.factory<_i58.DistributorManager>(
      () => _i58.DistributorManager(get<_i25.DistributorRepository>()));
  gh.factory<_i59.DistributorService>(
      () => _i59.DistributorService(get<_i58.DistributorManager>()));
  gh.factory<_i60.DistrosProfileStateManager>(
      () => _i60.DistrosProfileStateManager(get<_i59.DistributorService>()));
  gh.factory<_i61.DistrosStateManager>(
      () => _i61.DistrosStateManager(get<_i59.DistributorService>()));
  gh.factory<_i62.FiltersManager>(
      () => _i62.FiltersManager(get<_i26.FiltersRepository>()));
  gh.factory<_i63.FiltersService>(
      () => _i63.FiltersService(get<_i62.FiltersManager>()));
  gh.factory<_i64.FireNotificationService>(() => _i64.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i33.NotificationRepo>()));
  gh.factory<_i65.HomeManager>(
      () => _i65.HomeManager(get<_i27.HomeRepository>()));
  gh.factory<_i66.HomeService>(() => _i66.HomeService(get<_i65.HomeManager>()));
  gh.factory<_i67.HomeStateManager>(
      () => _i67.HomeStateManager(get<_i66.HomeService>()));
  gh.factory<_i68.InActiveCaptainsStateManager>(
      () => _i68.InActiveCaptainsStateManager(get<_i44.CaptainsService>()));
  gh.factory<_i69.InActiveDistributorsStateManager>(() =>
      _i69.InActiveDistributorsStateManager(get<_i59.DistributorService>()));
  gh.factory<_i70.LinkingManager>(
      () => _i70.LinkingManager(get<_i29.LinkingRepository>()));
  gh.factory<_i71.LinkingService>(
      () => _i71.LinkingService(get<_i70.LinkingManager>()));
  gh.factory<_i72.LoginScreen>(
      () => _i72.LoginScreen(get<_i30.LoginStateManager>()));
  gh.factory<_i73.LogsManager>(
      () => _i73.LogsManager(get<_i31.LogsRepository>()));
  gh.factory<_i74.LogsService>(() => _i74.LogsService(get<_i73.LogsManager>()));
  gh.factory<_i75.MyOrdersManager>(
      () => _i75.MyOrdersManager(get<_i32.MyOrdersRepository>()));
  gh.factory<_i76.OrdersAccountStateManager>(
      () => _i76.OrdersAccountStateManager(get<_i44.CaptainsService>()));
  gh.factory<_i77.OrdersService>(
      () => _i77.OrdersService(get<_i75.MyOrdersManager>()));
  gh.factory<_i78.PaymentsManager>(
      () => _i78.PaymentsManager(get<_i34.PaymentsRepository>()));
  gh.factory<_i79.PaymentsService>(
      () => _i79.PaymentsService(get<_i78.PaymentsManager>()));
  gh.factory<_i80.PaymentsToCaptainStateManager>(() =>
      _i80.PaymentsToCaptainStateManager(
          get<_i44.CaptainsService>(), get<_i79.PaymentsService>()));
  gh.factory<_i81.ProductsCategoryStateManager>(() =>
      _i81.ProductsCategoryStateManager(
          get<_i47.CategoriesService>(),
          get<_i19.AuthService>(),
          get<_i28.ImageUploadService>(),
          get<_i8.LocalizationService>()));
  gh.factory<_i82.ProductsReportStateManager>(
      () => _i82.ProductsReportStateManager(get<_i38.ReportsService>()));
  gh.factory<_i83.RegisterScreen>(
      () => _i83.RegisterScreen(get<_i35.RegisterStateManager>()));
  gh.factory<_i84.SettingsScreen>(() => _i84.SettingsScreen(
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i64.FireNotificationService>()));
  gh.factory<_i85.SplashModule>(
      () => _i85.SplashModule(get<_i39.SplashScreen>()));
  gh.factory<_i86.StoreCategoriesLinkingStateManager>(() =>
      _i86.StoreCategoriesLinkingStateManager(get<_i71.LinkingService>(),
          get<_i19.AuthService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i87.StoreCategoriesStateManager>(() =>
      _i87.StoreCategoriesStateManager(get<_i47.CategoriesService>(),
          get<_i19.AuthService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i88.StoreLogsStateManager>(
      () => _i88.StoreLogsStateManager(get<_i74.LogsService>()));
  gh.factory<_i89.StoreManager>(
      () => _i89.StoreManager(get<_i41.StoresRepository>()));
  gh.factory<_i90.StorePaymentsService>(
      () => _i90.StorePaymentsService(get<_i89.StoreManager>()));
  gh.factory<_i91.StoreProductsStateManager>(() =>
      _i91.StoreProductsStateManager(get<_i47.CategoriesService>(),
          get<_i19.AuthService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i92.StoresFilterStateManager>(
      () => _i92.StoresFilterStateManager(get<_i63.FiltersService>()));
  gh.factory<_i93.StoresReportScreen>(
      () => _i93.StoresReportScreen(get<_i40.StoresReportStateManager>()));
  gh.factory<_i94.StoresService>(
      () => _i94.StoresService(get<_i89.StoreManager>()));
  gh.factory<_i95.StoresStateManager>(() => _i95.StoresStateManager(
      get<_i94.StoresService>(),
      get<_i19.AuthService>(),
      get<_i28.ImageUploadService>(),
      get<_i47.CategoriesService>()));
  gh.factory<_i96.SubCategoriesLinkingStateManager>(() =>
      _i96.SubCategoriesLinkingStateManager(get<_i71.LinkingService>(),
          get<_i19.AuthService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i97.SubCategoriesListStateManager>(() =>
      _i97.SubCategoriesListStateManager(
          get<_i94.StoresService>(),
          get<_i19.AuthService>(),
          get<_i28.ImageUploadService>(),
          get<_i71.LinkingService>()));
  gh.factory<_i98.SubCategoriesStateManager>(() =>
      _i98.SubCategoriesStateManager(
          get<_i94.StoresService>(),
          get<_i19.AuthService>(),
          get<_i28.ImageUploadService>(),
          get<_i47.CategoriesService>()));
  gh.factory<_i99.UpdateLevelTwoCategoriesStateManager>(() =>
      _i99.UpdateLevelTwoCategoriesStateManager(get<_i47.CategoriesService>(),
          get<_i19.AuthService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i100.UpdateLevelTwoCategoryScreen>(() =>
      _i100.UpdateLevelTwoCategoryScreen(
          get<_i99.UpdateLevelTwoCategoriesStateManager>()));
  gh.factory<_i101.UpdateStoreCategoriesStateManager>(() =>
      _i101.UpdateStoreCategoriesStateManager(get<_i47.CategoriesService>(),
          get<_i19.AuthService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i102.UpdateStoreCategoryScreen>(() =>
      _i102.UpdateStoreCategoryScreen(
          get<_i101.UpdateStoreCategoriesStateManager>()));
  gh.factory<_i103.UpdateSubCategoriesStateManager>(() =>
      _i103.UpdateSubCategoriesStateManager(get<_i47.CategoriesService>(),
          get<_i19.AuthService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i104.UpdateSubCategoryScreen>(() => _i104.UpdateSubCategoryScreen(
      get<_i103.UpdateSubCategoriesStateManager>()));
  gh.factory<_i105.AuthorizationModule>(() => _i105.AuthorizationModule(
      get<_i72.LoginScreen>(), get<_i83.RegisterScreen>()));
  gh.factory<_i106.CaptainBalanceStateManager>(
      () => _i106.CaptainBalanceStateManager(get<_i44.CaptainsService>()));
  gh.factory<_i107.CaptainBalanceStateManager>(
      () => _i107.CaptainBalanceStateManager(get<_i44.CaptainsService>()));
  gh.factory<_i108.CaptainFilterStateManager>(
      () => _i108.CaptainFilterStateManager(get<_i63.FiltersService>()));
  gh.factory<_i109.CaptainLogsStateManager>(
      () => _i109.CaptainLogsStateManager(get<_i74.LogsService>()));
  gh.factory<_i110.CaptainProfileStateManager>(
      () => _i110.CaptainProfileStateManager(get<_i44.CaptainsService>()));
  gh.factory<_i111.CaptainsPaymentsStateManager>(
      () => _i111.CaptainsPaymentsStateManager(get<_i44.CaptainsService>()));
  gh.factory<_i112.CaptainsPaymentsStateManager>(
      () => _i112.CaptainsPaymentsStateManager(get<_i44.CaptainsService>()));
  gh.factory<_i113.CaptainsReportScreen>(
      () => _i113.CaptainsReportScreen(get<_i43.CaptainsReportStateManager>()));
  gh.factory<_i114.CaptainsScreen>(
      () => _i114.CaptainsScreen(get<_i45.CaptainsStateManager>()));
  gh.factory<_i115.CategoriesLevel2ListStateManager>(() =>
      _i115.CategoriesLevel2ListStateManager(
          get<_i71.LinkingService>(),
          get<_i19.AuthService>(),
          get<_i28.ImageUploadService>(),
          get<_i8.LocalizationService>()));
  gh.factory<_i116.ChatPage>(() => _i116.ChatPage(
      get<_i50.ChatStateManager>(),
      get<_i28.ImageUploadService>(),
      get<_i19.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i117.ClientProfileStateManager>(
      () => _i117.ClientProfileStateManager(get<_i53.ClientsService>()));
  gh.factory<_i118.ClientsNeedsSupportStateManager>(
      () => _i118.ClientsNeedsSupportStateManager(get<_i53.ClientsService>()));
  gh.factory<_i119.ClientsReportScreen>(
      () => _i119.ClientsReportScreen(get<_i52.ClientsReportStateManager>()));
  gh.factory<_i120.ClientsScreen>(
      () => _i120.ClientsScreen(get<_i54.ClientsStateManager>()));
  gh.factory<_i121.CompanyFinanceStateManager>(() =>
      _i121.CompanyFinanceStateManager(
          get<_i19.AuthService>(), get<_i56.CompanyService>()));
  gh.factory<_i122.CompanyProfileStateManager>(() =>
      _i122.CompanyProfileStateManager(
          get<_i19.AuthService>(), get<_i56.CompanyService>()));
  gh.factory<_i123.CustomProductScreen>(
      () => _i123.CustomProductScreen(get<_i57.CustomProductStateManager>()));
  gh.factory<_i124.DistrosProfileScreen>(
      () => _i124.DistrosProfileScreen(get<_i60.DistrosProfileStateManager>()));
  gh.factory<_i125.DistrosScreen>(
      () => _i125.DistrosScreen(get<_i61.DistrosStateManager>()));
  gh.factory<_i126.HomeScreen>(
      () => _i126.HomeScreen(get<_i67.HomeStateManager>()));
  gh.factory<_i127.InActiveCaptainsScreen>(() =>
      _i127.InActiveCaptainsScreen(get<_i68.InActiveCaptainsStateManager>()));
  gh.factory<_i128.InActiveDistributorsScreen>(() =>
      _i128.InActiveDistributorsScreen(
          get<_i69.InActiveDistributorsStateManager>()));
  gh.factory<_i129.LevelTowCategoriesListScreen>(() =>
      _i129.LevelTowCategoriesListScreen(
          get<_i115.CategoriesLevel2ListStateManager>(),
          get<_i8.LocalizationService>()));
  gh.factory<_i130.LevelTowCategoriesScreen>(() =>
      _i130.LevelTowCategoriesScreen(get<_i81.ProductsCategoryStateManager>(),
          get<_i8.LocalizationService>()));
  gh.factory<_i131.MainScreen>(() => _i131.MainScreen(get<_i126.HomeScreen>()));
  gh.factory<_i132.MyOrdersStateManager>(() => _i132.MyOrdersStateManager(
      get<_i77.OrdersService>(), get<_i19.AuthService>()));
  gh.factory<_i133.OnGoingOrdersStateManager>(() =>
      _i133.OnGoingOrdersStateManager(
          get<_i77.OrdersService>(), get<_i19.AuthService>()));
  gh.factory<_i134.OrderDetailsStateManager>(() =>
      _i134.OrderDetailsStateManager(
          get<_i77.OrdersService>(), get<_i5.FireStoreHelper>()));
  gh.factory<_i135.OrderTimeLineStateManager>(
      () => _i135.OrderTimeLineStateManager(get<_i77.OrdersService>()));
  gh.factory<_i136.OrderWithoutPendingStateManager>(() =>
      _i136.OrderWithoutPendingStateManager(
          get<_i77.OrdersService>(), get<_i19.AuthService>()));
  gh.factory<_i137.OrdersAccountScreen>(
      () => _i137.OrdersAccountScreen(get<_i76.OrdersAccountStateManager>()));
  gh.factory<_i138.OrdersScreen>(
      () => _i138.OrdersScreen(get<_i132.MyOrdersStateManager>()));
  gh.factory<_i139.OrdersWithoutPendingScreen>(() =>
      _i139.OrdersWithoutPendingScreen(
          get<_i136.OrderWithoutPendingStateManager>()));
  gh.factory<_i140.PaymentsFromCaptainStateManager>(() =>
      _i140.PaymentsFromCaptainStateManager(
          get<_i44.CaptainsService>(), get<_i79.PaymentsService>()));
  gh.factory<_i141.PaymentsListStateManager>(
      () => _i141.PaymentsListStateManager(get<_i79.PaymentsService>()));
  gh.factory<_i142.PaymentsToCaptainScreen>(() =>
      _i142.PaymentsToCaptainScreen(get<_i80.PaymentsToCaptainStateManager>()));
  gh.factory<_i143.ProductsReportScreen>(
      () => _i143.ProductsReportScreen(get<_i82.ProductsReportStateManager>()));
  gh.factory<_i144.ReportsModule>(() => _i144.ReportsModule(
      get<_i143.ProductsReportScreen>(),
      get<_i93.StoresReportScreen>(),
      get<_i113.CaptainsReportScreen>(),
      get<_i119.ClientsReportScreen>(),
      get<_i123.CustomProductScreen>()));
  gh.factory<_i145.SettingsModule>(() => _i145.SettingsModule(
      get<_i84.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i146.StoreBalanceStateManager>(() =>
      _i146.StoreBalanceStateManager(
          get<_i94.StoresService>(), get<_i90.StorePaymentsService>()));
  gh.factory<_i147.StoreCategoriesLinkingScreen>(() =>
      _i147.StoreCategoriesLinkingScreen(
          get<_i86.StoreCategoriesLinkingStateManager>(),
          get<_i8.LocalizationService>()));
  gh.factory<_i148.StoreCategoriesScreen>(() => _i148.StoreCategoriesScreen(
      get<_i87.StoreCategoriesStateManager>(), get<_i8.LocalizationService>()));
  gh.factory<_i149.StoreLogsScreen>(
      () => _i149.StoreLogsScreen(get<_i88.StoreLogsStateManager>()));
  gh.factory<_i150.StoreProductScreen>(
      () => _i150.StoreProductScreen(get<_i91.StoreProductsStateManager>()));
  gh.factory<_i151.StoreProfileStateManager>(
      () => _i151.StoreProfileStateManager(get<_i94.StoresService>()));
  gh.factory<_i152.StoresFilterScreen>(
      () => _i152.StoresFilterScreen(get<_i92.StoresFilterStateManager>()));
  gh.factory<_i153.StoresInActiveStateManager>(() =>
      _i153.StoresInActiveStateManager(
          get<_i94.StoresService>(),
          get<_i19.AuthService>(),
          get<_i28.ImageUploadService>(),
          get<_i47.CategoriesService>()));
  gh.factory<_i154.StoresScreen>(
      () => _i154.StoresScreen(get<_i95.StoresStateManager>()));
  gh.factory<_i155.SubCategoriesLinkingScreen>(() =>
      _i155.SubCategoriesLinkingScreen(
          get<_i96.SubCategoriesLinkingStateManager>()));
  gh.factory<_i156.SubCategoriesListScreen>(() => _i156.SubCategoriesListScreen(
      get<_i97.SubCategoriesListStateManager>(),
      get<_i8.LocalizationService>()));
  gh.factory<_i157.SubCategoriesScreen>(() => _i157.SubCategoriesScreen(
      get<_i98.SubCategoriesStateManager>(), get<_i8.LocalizationService>()));
  gh.factory<_i158.CaptainBalanceScreen>(() =>
      _i158.CaptainBalanceScreen(get<_i107.CaptainBalanceStateManager>()));
  gh.factory<_i159.CaptainBalanceScreen>(() =>
      _i159.CaptainBalanceScreen(get<_i107.CaptainBalanceStateManager>()));
  gh.factory<_i160.CaptainFilterScreen>(
      () => _i160.CaptainFilterScreen(get<_i108.CaptainFilterStateManager>()));
  gh.factory<_i161.CaptainLogsScreen>(
      () => _i161.CaptainLogsScreen(get<_i109.CaptainLogsStateManager>()));
  gh.factory<_i162.CaptainProfileScreen>(() =>
      _i162.CaptainProfileScreen(get<_i110.CaptainProfileStateManager>()));
  gh.factory<_i163.CaptainsPaymentsScreen>(() =>
      _i163.CaptainsPaymentsScreen(get<_i111.CaptainsPaymentsStateManager>()));
  gh.factory<_i164.CaptainsPaymentsScreen>(() =>
      _i164.CaptainsPaymentsScreen(get<_i111.CaptainsPaymentsStateManager>()));
  gh.factory<_i165.CategoriesModule>(() => _i165.CategoriesModule(
      get<_i148.StoreCategoriesScreen>(),
      get<_i130.LevelTowCategoriesScreen>(),
      get<_i150.StoreProductScreen>(),
      get<_i157.SubCategoriesScreen>(),
      get<_i102.UpdateStoreCategoryScreen>(),
      get<_i104.UpdateSubCategoryScreen>(),
      get<_i100.UpdateLevelTwoCategoryScreen>()));
  gh.factory<_i166.ChatModule>(
      () => _i166.ChatModule(get<_i116.ChatPage>(), get<_i19.AuthService>()));
  gh.factory<_i167.ClientProfileScreen>(
      () => _i167.ClientProfileScreen(get<_i117.ClientProfileStateManager>()));
  gh.factory<_i168.ClientsNeedsSupportScreen>(() =>
      _i168.ClientsNeedsSupportScreen(
          get<_i118.ClientsNeedsSupportStateManager>()));
  gh.factory<_i169.CompanyFinanceScreen>(() =>
      _i169.CompanyFinanceScreen(get<_i121.CompanyFinanceStateManager>()));
  gh.factory<_i170.CompanyProfileScreen>(() =>
      _i170.CompanyProfileScreen(get<_i122.CompanyProfileStateManager>()));
  gh.factory<_i171.DistributorsModule>(() => _i171.DistributorsModule(
      get<_i125.DistrosScreen>(),
      get<_i124.DistrosProfileScreen>(),
      get<_i158.CaptainBalanceScreen>(),
      get<_i163.CaptainsPaymentsScreen>(),
      get<_i128.InActiveDistributorsScreen>()));
  gh.factory<_i172.FiltersModule>(() => _i172.FiltersModule(
      get<_i160.CaptainFilterScreen>(), get<_i152.StoresFilterScreen>()));
  gh.factory<_i173.LinkingModule>(() => _i173.LinkingModule(
      get<_i129.LevelTowCategoriesListScreen>(),
      get<_i147.StoreCategoriesLinkingScreen>(),
      get<_i155.SubCategoriesLinkingScreen>(),
      get<_i156.SubCategoriesListScreen>()));
  gh.factory<_i174.LogsModule>(() => _i174.LogsModule(
      get<_i161.CaptainLogsScreen>(), get<_i149.StoreLogsScreen>()));
  gh.factory<_i175.MainModule>(
      () => _i175.MainModule(get<_i131.MainScreen>(), get<_i126.HomeScreen>()));
  gh.factory<_i176.OnGoingOrdersScreen>(
      () => _i176.OnGoingOrdersScreen(get<_i133.OnGoingOrdersStateManager>()));
  gh.factory<_i177.OrderDetailsScreen>(
      () => _i177.OrderDetailsScreen(get<_i134.OrderDetailsStateManager>()));
  gh.factory<_i178.OrderTimLineScreen>(
      () => _i178.OrderTimLineScreen(get<_i135.OrderTimeLineStateManager>()));
  gh.factory<_i179.OrdersModule>(() => _i179.OrdersModule(
      get<_i138.OrdersScreen>(),
      get<_i177.OrderDetailsScreen>(),
      get<_i176.OnGoingOrdersScreen>(),
      get<_i178.OrderTimLineScreen>(),
      get<_i139.OrdersWithoutPendingScreen>(),
      get<_i137.OrdersAccountScreen>()));
  gh.factory<_i180.PaymentsFromCaptainScreen>(() =>
      _i180.PaymentsFromCaptainScreen(
          get<_i140.PaymentsFromCaptainStateManager>()));
  gh.factory<_i181.PaymentsListScreen>(
      () => _i181.PaymentsListScreen(get<_i141.PaymentsListStateManager>()));
  gh.factory<_i182.PaymentsModule>(() => _i182.PaymentsModule(
      get<_i180.PaymentsFromCaptainScreen>(),
      get<_i142.PaymentsToCaptainScreen>(),
      get<_i181.PaymentsListScreen>()));
  gh.factory<_i183.StoreBalanceScreen>(
      () => _i183.StoreBalanceScreen(get<_i146.StoreBalanceStateManager>()));
  gh.factory<_i184.StoreInfoScreen>(
      () => _i184.StoreInfoScreen(get<_i151.StoreProfileStateManager>()));
  gh.factory<_i185.StoresInActiveScreen>(() =>
      _i185.StoresInActiveScreen(get<_i153.StoresInActiveStateManager>()));
  gh.factory<_i186.StoresModule>(() => _i186.StoresModule(
      get<_i154.StoresScreen>(),
      get<_i184.StoreInfoScreen>(),
      get<_i185.StoresInActiveScreen>(),
      get<_i183.StoreBalanceScreen>()));
  gh.factory<_i187.CaptainsModule>(() => _i187.CaptainsModule(
      get<_i127.InActiveCaptainsScreen>(),
      get<_i162.CaptainProfileScreen>(),
      get<_i158.CaptainBalanceScreen>(),
      get<_i163.CaptainsPaymentsScreen>(),
      get<_i114.CaptainsScreen>()));
  gh.factory<_i188.ClientsModule>(() => _i188.ClientsModule(
      get<_i167.ClientProfileScreen>(),
      get<_i120.ClientsScreen>(),
      get<_i168.ClientsNeedsSupportScreen>()));
  gh.factory<_i189.CompanyModule>(() => _i189.CompanyModule(
      get<_i170.CompanyProfileScreen>(), get<_i169.CompanyFinanceScreen>()));
  gh.factory<_i190.MyApp>(() => _i190.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i64.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i85.SplashModule>(),
      get<_i105.AuthorizationModule>(),
      get<_i166.ChatModule>(),
      get<_i145.SettingsModule>(),
      get<_i175.MainModule>(),
      get<_i165.CategoriesModule>(),
      get<_i186.StoresModule>(),
      get<_i187.CaptainsModule>(),
      get<_i189.CompanyModule>(),
      get<_i179.OrdersModule>(),
      get<_i182.PaymentsModule>(),
      get<_i172.FiltersModule>(),
      get<_i174.LogsModule>(),
      get<_i173.LinkingModule>()));
  gh.singleton<_i191.GlobalStateManager>(_i191.GlobalStateManager(
      get<_i68.InActiveCaptainsStateManager>(),
      get<_i45.CaptainsStateManager>()));
  return get;
}
