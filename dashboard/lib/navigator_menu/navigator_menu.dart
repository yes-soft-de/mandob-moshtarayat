import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat_dashboad/di/di_config.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/global_nav_key.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/captains_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/categories_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/clients_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_company/company_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/distros_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_distributor/ui/screen/distors_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_filters/filters_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_main/main_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_orders/orders_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_reports/report_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_settings/settings_module.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/stores_module.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/customIcon/mandob_icons_icons.dart';

// current last index is 19
class NavigatorMenu extends StatefulWidget {
  final Function(StatefulWidget) onTap;
  final StatefulWidget currentPage;
  final double? width;
  NavigatorMenu({this.width, required this.onTap, required this.currentPage});

  @override
  _NavigatorMenuState createState() => _NavigatorMenuState();
}

class _NavigatorMenuState extends State<NavigatorMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var drawerHeader = SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  MandobIcons.logo,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              S.current.twaslnaDashboard,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
    return Container(
        width: widget.width,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: Localizations.localeOf(context).languageCode == 'ar'
                ? BorderRadius.horizontal(left: Radius.circular(25))
                : BorderRadius.horizontal(right: Radius.circular(25))),
        child: CustomListView.custom(children: [
          drawerHeader,
          Divider(
            thickness: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
          customListTile(getIt<MainModule>().homeScreen, S.current.home,
              FontAwesomeIcons.home),
          // Categories
          customExpansionTile(
              title: S.current.categories,
              icon: Icons.category_rounded,
              children: [
                customListTile(getIt<CategoriesModule>().storeCategoriesScreen,
                    S.current.mainCategories, FontAwesomeIcons.circle, true),
                customListTile(getIt<CategoriesModule>().subCategoriesScreen,
                    S.current.subCategories, FontAwesomeIcons.square, true),
                customListTile(
                    getIt<CategoriesModule>().productCategoriesScreen,
                    S.current.categoriesLevel2,
                    FontAwesomeIcons.dotCircle,
                    true),
              ],
              page: widget.currentPage),
          // Store
          customExpansionTile(
              title: S.current.stores,
              icon: FontAwesomeIcons.store,
              children: [
                customListTile(getIt<StoresModule>().storesScreen,
                    S.current.storesList, Icons.storefront_rounded, true),
                customListTile(
                    getIt<StoresModule>().storesInActiveScreen,
                    S.current.storesInActive,
                    FontAwesomeIcons.storeSlash,
                    true),
              ],
              page: widget.currentPage),
          // Distros
          customExpansionTile(
              title: S.current.distributors,
              icon: FontAwesomeIcons.adversal,
              children: [
                customListTile(getIt<DistributorsModule>().distro_screen,
                    S.current.distributors, FontAwesomeIcons.adversal, true),
                customListTile(
                    getIt<DistributorsModule>().inActiveDistributorsScreen,
                    S.current.inActiveDistributors,
                    FontAwesomeIcons.adversal,
                    true),
              ],
              page: widget.currentPage),
          // Captains
          customExpansionTile(
              title: S.current.captains,
              icon: FontAwesomeIcons.car,
              children: [
                customListTile(getIt<CaptainsModule>().captainsScreen,
                    S.current.captains, FontAwesomeIcons.solidListAlt, true),
                customListTile(
                    getIt<CaptainsModule>().inActiveCaptains,
                    S.current.inActiveCaptains,
                    FontAwesomeIcons.solidAddressCard,
                    true),
                customListTile(
                    getIt<CaptainsModule>().captainsPaymentsScreen,
                    S.current.captainPayments,
                    FontAwesomeIcons.solidCreditCard,
                    true),
              ],
              page: widget.currentPage),
          // client
          customExpansionTile(
              title: S.current.clients,
              icon: FontAwesomeIcons.userAlt,
              children: [
                customListTile(getIt<ClientsModule>().clientsScreen,
                    S.current.clients, FontAwesomeIcons.personBooth, true),
              ],
              page: widget.currentPage),
          // Orders
          customExpansionTile(
              title: S.current.orders,
              icon: FontAwesomeIcons.box,
              children: [
                customListTile(getIt<OrdersModule>().myOrdersScreen,
                    S.current.orderPending, FontAwesomeIcons.solidClock, true),
                customListTile(getIt<OrdersModule>().onGoingOrdersScreen,
                    S.current.ongoingOrders, FontAwesomeIcons.play, true),
                customListTile(getIt<OrdersModule>().ordersWithoutPendingScreen,
                    S.current.orders, FontAwesomeIcons.boxes, true),
                customListTile(
                    getIt<OrdersModule>().ordersAccountScreen,
                    S.current.ordersAccount,
                    FontAwesomeIcons.cashRegister,
                    true),
              ],
              page: widget.currentPage),
          customExpansionTile(
              title: S.current.company,
              icon: FontAwesomeIcons.solidCopyright,
              children: [
                customListTile(
                    getIt<CompanyModule>().companyFinanceScreen,
                    S.current.companyFinance,
                    FontAwesomeIcons.moneyCheckAlt,
                    true),
                customListTile(getIt<CompanyModule>().companyProfileScreen,
                    S.current.companyInfo, Icons.info, true),
              ],
              page: widget.currentPage),
          customExpansionTile(
              title: S.current.Logs,
              icon: FontAwesomeIcons.solidFlag,
              children: [
                customListTile(getIt<FiltersModule>().captainFilterScreen,
                    S.current.captainLogs, FontAwesomeIcons.history, true),
                customListTile(getIt<FiltersModule>().storesFilterScreen,
                    S.current.storeLogs, FontAwesomeIcons.storeAlt, true),
              ],
              page: widget.currentPage),
          customExpansionTile(
              title: S.current.reports,
              icon: FontAwesomeIcons.solidNewspaper,
              children: [
                customListTile(
                    getIt<ReportsModule>().captainsReportScreen,
                    S.current.captainsReports,
                    FontAwesomeIcons.motorcycle,
                    true),
                customListTile(getIt<ReportsModule>().storesReportScreen,
                    S.current.storesReports, FontAwesomeIcons.storeAlt, true),
                customListTile(
                    getIt<ReportsModule>().clientsReportScreen,
                    S.current.clientsReport,
                    FontAwesomeIcons.peopleArrows,
                    true),
                customListTile(getIt<ReportsModule>().productsReportScreen,
                    S.current.productsReport, FontAwesomeIcons.chartPie, true),
                customListTile(getIt<ReportsModule>().customProductScreen,
                    S.current.outerOrder, FontAwesomeIcons.info, true),
              ],
              page: widget.currentPage),
          customExpansionTile(
              title: S.current.directSupport,
              icon: FontAwesomeIcons.headphonesAlt,
              children: [
                customListTile(getIt<ClientsModule>().clientsNeedsSupportScreen,
                    S.current.clients, FontAwesomeIcons.headset, true),
              ],
              page: widget.currentPage),
          customListTile(getIt<SettingsModule>().settingsScreen,
              S.current.settings, FontAwesomeIcons.cog),
        ]));
  }

  Widget customListTile(StatefulWidget page, String title, IconData icon,
      [bool subtitle = false]) {
    bool selected = page.runtimeType.toString() ==
        widget.currentPage.runtimeType.toString();
    double? size =
        icon.fontPackage == 'font_awesome_flutter' ? (subtitle ? 18 : 22) : 26;
    if (size == 26 && subtitle) {
      size = 20;
    }

    return InkWell(
      key: ValueKey(page.runtimeType),
      onTap: () {
        widget.onTap(page);
        GlobalVariable.mainScreenScaffold.currentState?.openEndDrawer();
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: subtitle ? 16.0 : 8.0, right: subtitle ? 16 : 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: selected ? Theme.of(context).primaryColor : null,
              borderRadius: BorderRadius.circular(25)),
          child: ListTile(
            minLeadingWidth: subtitle ? 4 : null,
            visualDensity: VisualDensity(vertical: -2),
            leading:
                Icon(icon, color: selected ? Colors.white : null, size: size),
            title: Text(
              title,
              style: TextStyle(
                  color: selected ? Colors.white : null,
                  fontSize: subtitle ? 14 : null),
            ),
          ),
        ),
      ),
    );
  }

  Widget customExpansionTile(
      {required StatefulWidget page,
      required String title,
      required IconData icon,
      required List<Widget> children}) {
    bool extended = false;
    for (var i in children) {
      if (i.key.toString() == '[<${page.runtimeType}>]') {
        extended = true;
        break;
      }
    }
    double? size = icon.fontPackage == 'font_awesome_flutter' ? 22 : 26;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: extended,
          title: Text(title),
          leading: Icon(
            icon,
            size: size,
          ),
          children: children,
        ),
      ),
    );
  }
}
