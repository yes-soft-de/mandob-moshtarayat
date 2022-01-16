import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_home/sceen/home_screen.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/profile_routes.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatelessWidget {
  final HomeScreenState screenState;
  final ProfileModel profileModel;
  MenuScreen(this.screenState, this.profileModel);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomNetworkImage(
                      background: Theme.of(context).scaffoldBackgroundColor,
                      imageSource: profileModel.image.image ??
                          'https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png',
                      width: double.maxFinite,
                      height: double.maxFinite,
                    ),
                  ),
                ),
              ),
              Text(profileModel.storeOwnerName ?? S.current.username),
              Container(
                height: 32,
              ),
              ListTile(
                onTap: () {
//                  Navigator.of(context)
//                      .pushNamed(ProfileRoutes.EDIT_ACTIVITY_SCREEN);
                },
                leading: Icon(Icons.account_circle_rounded),
                title: Text('${S.of(context).profile}'),
              ),

              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).disabledColor,
                    fontWeight: FontWeight.w500),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Yes Soft | Mandoob Captain'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}