import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_captain/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat_captain/module_profile/profile_routes.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/screen/activity_screen/activity_screen.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:mandob_moshtarayat_captain/module_profile/ui/screen/order_info/order_info_screen.dart';

@injectable
class ProfileModule extends YesModule {
  final ActivityScreen activityScreen;
  final EditProfileScreen editProfileScreen;
  final OrderInfoScreen orderDetailsScreen;
  ProfileModule(
      this.activityScreen, this.editProfileScreen, this.orderDetailsScreen) {
    YesModule.RoutesMap.addAll({
      ProfileRoutes.ACTIVITY_SCREEN: (context) => activityScreen,
      ProfileRoutes.EDIT_ACTIVITY_SCREEN: (context) => editProfileScreen,
      ProfileRoutes.ORDER_INFO_SCREEN: (context) => orderDetailsScreen
    });
  }
}
