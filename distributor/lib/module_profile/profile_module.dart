import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_profile/profile_routes.dart';
import 'package:mandob_moshtarayat/module_profile/ui/screen/profile_screen.dart';


@injectable
class ProfileModule extends YesModule {
  final ProfileScreen _profileScreen;
  ProfileModule(this._profileScreen,){
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
       ProfileRoutes.PROFILE : (context) => _profileScreen,
    };
  }
}