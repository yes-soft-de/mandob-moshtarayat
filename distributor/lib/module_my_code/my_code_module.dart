import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';
import 'package:mandob_moshtarayat/module_my_code/ui/screen/my_code_screen.dart';

import 'my_code_routes.dart';

@injectable
class MyCodeModule extends YesModule {
  MyCodeModule(MyCodeScreen splashScreen) {
    YesModule.RoutesMap.addAll(
        {MyCodeRoutes.MyCode_SCREEN: (context) => splashScreen});
  }
}
